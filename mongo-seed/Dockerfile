FROM mongo:2

COPY mongodump.tgz /tmp
CMD bash -c 'tar -C /tmp -xf /tmp/mongodump.tgz && mongorestore -h mongo /tmp/mongodb/test/ && rm -r /tmp/{mongodb,mongodump.tgz}'
