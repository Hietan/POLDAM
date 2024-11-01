FROM ubuntu:latest

ENV POLDAM_BOOST_PATH=/app/boost_1_80_0

RUN apt update && \
		apt install -y git wget gcc-11 g++-11 cmake make && \
		apt install -y openjdk-8-jdk maven && \
		git clone --recursive https://github.com/Hietan/POLDAM.git /app/POLDAM && \
		wget http://downloads.sourceforge.net/project/boost/boost/1.80.0/boost_1_80_0.tar.gz -P /app && \
		tar xfz /app/boost_1_80_0.tar.gz -C /app && \
		rm /app/boost_1_80_0.tar.gz && \
		(cd /app/POLDAM/Data/java8/selogger && mvn package -DskipTests) && \
		cmake . && \
		make && \

WORKDIR /app

CMD ["/bin/bash"]
