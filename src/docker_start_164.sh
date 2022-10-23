#!/bin/bash
set -x
#Обновление образа Docker для QA-164
APP_VERSION_164=$(cat qa-164/Chart.yaml | sed -n '21p' | awk '{print $2}')
## на второй строке выводим текст файла Chart.yaml на экран, выводим 21 строку, и фильтруем через awk ее второе значение
echo $APP_VERSION_164 "- текущая версия сборки QA-164 Fluentd" ## отображаем на экран
((APP_VERSION_164++)) ## инкрементируем
echo $APP_VERSION_164 "- новая версия сборки Fluentd, запускаем docker build, пересобираем образ, пожалуйста подождите." ## проверяем, что значение изменилось
sed -i "s/\b[0-9]\{5\}\b/${APP_VERSION_164}/g" qa-164/Chart.yaml
git status
git config --global push.default simple
git config --global user.name "${GITLAB_USER_NAME}"
git add --all
git commit -m "Version ${APP_VERSION_164}"
git push https://e.budin:${CI_JOB_TOKEN}@gitlab.test/WS/fluentd-deploy-qa.git/ HEAD:master
echo "Значение appVersion в Chart.yaml изменилось."
cd src
docker build -t fluentd-custom-164:$APP_VERSION_164 . 
docker tag fluentd-custom-164:$APP_VERSION_164 repository:7018/fluentd-custom-164:$APP_VERSION_164
docker push repository:7018/fluentd-custom-164:$APP_VERSION_164


