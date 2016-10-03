# docker-hive

Docker image for running Apache Hive

# Usage

First pull image:

	docker pull olegfedoseev/hive:2.1.0

Then run it. You need to provide Hadoop's core-site.xml and Hive's hive-site.xml:

	docker run --name hive -d \
		-p 10000:10000 \
		-p 10002:10002 \
		-v /data/hive/core-site.xml:/usr/local/hadoop/etc/hadoop/core-site.xml \
		-v /data/hive/hive-site.xml:/usr/local/hive/conf/hive-site.xml \
		olegfedoseev/hive:2.1.0

You could also use this image as Hive client:

	docker run -it olegfedoseev/hive:2.1.0 --service beeline -u jdbc:hive2://hive/10000/default -n hive
