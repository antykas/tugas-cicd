#menggunakan image yang sudah di sediakan
FROM '123majumundur/php-7.1-nginx:cicd'
#set nama maintainernya
MAINTAINER Antyka Syahrial <antykasyahrial2@gmail.com>

#library untuk mendownload dependenci composer secara paralel
RUN composer global require hirak/prestissimo
#Membuat direktori dan pindah masuk ke working direktorinya
RUN mkdir /home/app/app
WORKDIR /home/app/app

#install kebutuhannya
COPY composer.json composer.json
RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader && rm -rf /home/app/.composer

#copy seluruh file ke working directorynya
COPY --chown=app:root . ./
#menjalankan composernya
RUN composer dump-autoload --no-scripts --no-dev --optimize
#membuka port 8080
EXPOSE 8080

#APP_KEY=base64:5Db7ZGB3xtPz5eRJ6tfXhmcuJLpK4qF0RJvCVXNVRSw=
#docker pull nama_repo && docker run -p 0.0.0.0:8080:8080/tcp --env-file ./.env  nama_repo