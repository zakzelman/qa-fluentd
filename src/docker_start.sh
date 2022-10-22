#!/bin/bash
set -x
#Обновление образа Docker для QA-127
APP_VERSION_127=$(cat qa-127/Chart.yaml | sed -n '21p' | awk '{print $2}')
## на второй строке выводим текст файла Chart.yaml на экран, выводим 21 строку, и фильтруем через awk ее второе значение
echo $APP_VERSION_127 "- текущая версия сборки QA-127 Fluentd" ## отображаем на экран
((APP_VERSION_127++)) ## инкрементируем
echo $APP_VERSION_127 "- новая версия сборки Fluentd, запускаем docker build, пересобираем образ, пожалуйста подождите." ## проверяем, что значение изменилось
sed -i "s/\b[0-9]\{1\}\b/${APP_VERSION_127}/g" qa-127/Chart.yaml
sed -i "s/\b[0-9]\{2\}\b/${APP_VERSION_127}/g" qa-127/Chart.yaml
sed -i "s/\b[0-9]\{3\}\b/${APP_VERSION_127}/g" qa-127/Chart.yaml

git status
git config --global push.default simple
git config --global user.name "${GITLAB_USER_NAME}"
git add --all
git commit -m "Version ${APP_VERSION_127}"
git push https://e.budin:${CI_JOB_TOKEN}@gitlab.web.s7.ru/websupport-team/fluentd-deploy-qa.git/ HEAD:master
echo "Значение appVersion в Chart.yaml изменилось."
cd src
docker build -t fluentd-custom:$APP_VERSION_127 .
docker tag fluentd-custom:$APP_VERSION_127 prod-nexus.web.s7.ru:7018/fluentd-custom:$APP_VERSION_127
docker push prod-nexus.web.s7.ru:7018/fluentd-custom:$APP_VERSION_127

