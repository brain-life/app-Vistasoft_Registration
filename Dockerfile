FROM brainlife/mcr:neurodebian1604-r2017a

MAINTAINER Brad Caron <bacaron@imail.iu.edu>

RUN apt-get update
RUN apt-get install fsl-complete

ADD /compiled /app

RUN ldconfig

WORKDIR /output

ENTRYPOINT ["/app/vistasoftregistration"]
