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

#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <QNetworkReply>
#include <QString>
#include <QSettings>
#include <bb/cascades/InvokeQuery>
#include <bb/cascades/Invocation>
namespace bb
{
    namespace system
    {
        class InvokeManager;
    }
    namespace cascades
    {
        class LocaleHandler;
    }
}
class QTranslator;

/*!
 * @brief Application UI object
 *
 * Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI: public QObject
{
    Q_OBJECT
    Q_PROPERTY (bool shownsfw READ getShowNsfw WRITE setShowNsfw RESET resetShowNsfw)
public:
    ApplicationUI();
    virtual ~ApplicationUI(){};
    Q_INVOKABLE void invokeVideo(const QString &title, const QString &url, const QString &imageurl);
    Q_INVOKABLE static void setv(const QString &objectName, const QString &inputValue);
    Q_INVOKABLE static QString getv(const QString &objectName, const QString &defaultValue);
    Q_INVOKABLE void shareURL(const QString &text);
    Q_INVOKABLE void openURL(const QString &text);
    Q_INVOKABLE void resetShowNsfw();
    Q_INVOKABLE void setShowNsfw(bool newvalue);
    Q_INVOKABLE bool getShowNsfw();
    Q_INVOKABLE void resetShowNsfwCOVER();
    Q_INVOKABLE void setShowNsfwCOVER(bool newvalue);
    Q_INVOKABLE bool getShowNsfwCOVER();
    QString clientid;
    QString clientsecret;
    QString redirecturl;
private slots:
    void onSystemLanguageChanged();
    void onSHAREArmed();
    void onOPENArmed();
    void onViewArmed();
    void onFinished();
protected:
    bb::system::InvokeManager* m_pInvokeManager;
private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;
    bool m_shownsfw ;
    bool m_shownsfwcover;
};

#endif /* ApplicationUI_HPP_ */
