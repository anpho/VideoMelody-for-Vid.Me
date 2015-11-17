/*
 * Copyright (c) 2011-2015 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/system/InvokeManager>
#include <bb/PpsObject>
#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>
#include "qnamespace.h"
using namespace bb::cascades;
using namespace bb::system;

ApplicationUI::ApplicationUI() :
        QObject()
{
    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);
    m_pInvokeManager = new InvokeManager(this);
    resetShowNsfw();
    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this,
            SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a
    // compiler warning
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    QmlDocument *qml = QmlDocument::create("qrc:/assets/main.qml").parent(this);
    qml->setContextProperty("_app", this);
    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);

    //set application cover
    QmlDocument *qmlCover = QmlDocument::create("qrc:/assets/cover.qml").parent(this);

    // Create the QML Container from using the QMLDocument
    Container *coverContainer = qmlCover->createRootObject<Container>();
    // Create a SceneCover and set the app cover
    SceneCover *sceneCover = SceneCover::create().content(coverContainer);
    Application::instance()->setCover(sceneCover);
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("VidmeBrowser_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

void ApplicationUI::invokeVideo(const QString &title, const QString &url, const QString &imageurl)
{
    InvokeRequest cardRequest;
    cardRequest.setTarget("sys.mediaplayer.previewer");
    cardRequest.setAction("bb.action.VIEW");
    cardRequest.setUri(url);

    // set title of video
    QVariantMap map;
    map.insert("contentTitle", title);
    QByteArray requestData = bb::PpsObject::encode(map, NULL);
    cardRequest.setData(requestData);

    m_pInvokeManager->invoke(cardRequest);
}

QString ApplicationUI::getv(const QString &objectName, const QString &defaultValue)
{
    QSettings settings;
    if (settings.value(objectName).isNull()) {
        qDebug() << "[SETTINGS]" << objectName << " is " << defaultValue;
        return defaultValue;
    }
    qDebug() << "[SETTINGS]" << objectName << " is " << settings.value(objectName).toString();
    return settings.value(objectName).toString();
}

void ApplicationUI::setv(const QString &objectName, const QString &inputValue)
{
    QSettings settings;
    settings.setValue(objectName, QVariant(inputValue));
    qDebug() << "[SETTINGS]" << objectName << " set to " << inputValue;
}

void ApplicationUI::shareURL(const QString &text)
{
    InvokeQuery *query = InvokeQuery::create().uri(text.toUtf8());
    Invocation *invocation = Invocation::create(query);
    query->setParent(invocation); // destroy query with invocation
    invocation->setParent(this); // app can be destroyed before onFinished() is called

    connect(invocation, SIGNAL(armed()), this, SLOT(onSHAREArmed()));
    connect(invocation, SIGNAL(finished()), this, SLOT(onFinished()));
}

void ApplicationUI::onSHAREArmed()
{
    Invocation *invocation = qobject_cast<Invocation *>(sender());
    invocation->trigger("bb.action.SHARE");
}

void ApplicationUI::onViewArmed()
{
    Invocation *invocation = qobject_cast<Invocation *>(sender());
    invocation->trigger("bb.action.VIEW");
}

void ApplicationUI::onFinished()
{
    Invocation *invocation = qobject_cast<Invocation *>(sender());
    invocation->deleteLater();
}

void ApplicationUI::resetShowNsfw()
{
    m_shownsfw = getv("show_nsfw", "no").compare("yes") == 0;
}
void ApplicationUI::setShowNsfw(bool newvalue)
{
    setv("show_nsfw", newvalue ? "yes" : "no");
    resetShowNsfw();
}
bool ApplicationUI::getShowNsfw()
{
    return m_shownsfw;
}
