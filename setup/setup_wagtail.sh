#!/bin/bash

if [ ! -d "cms" ]
then
    pip install wagtail
    wagtail start config
    mv config cms
    mv cms/config/settings cms
    mv cms/config/static cms
    mv cms/config/templates cms
    mv cms/config/* cms
    rm -R cms/config
    mv cms/manage.py .
    sed -i -e "s/config.settings.dev/cms.settings.dev/g" manage.py
    sed -i -e "s/'home',/'cms.home',/g" cms/settings/base.py
    sed -i -e "s/'search',/'cms.search',/g" cms/settings/base.py
    sed -i -e "s/WSGI_APPLICATION = 'config.wsgi.application'/WSGI_APPLICATION = 'cms.wsgi.application'/g" cms/settings/base.py
    sed -i -e "s/ROOT_URLCONF = 'config.urls'/ROOT_URLCONF = 'cms.urls'/g" cms/settings/base.py
    sed -i -e "s/from search import views as search_views/from cms.search import views as search_views/g" cms/urls.py
    python manage.py migrate
    echo "from django.contrib.auth import get_user_model; get_user_model().objects.create_superuser('admin', '', 'changeme')" | python manage.py shell
else
    echo "EXITED: already run"
fi