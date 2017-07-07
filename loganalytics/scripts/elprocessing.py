from elasticsearch import Elasticsearch
import os, time, subprocess

# By default logstash has been installed at below location
# but need to change if location is different.
LOGSTASHDIR = "/opt/logstash"

# Absolute path of the logstash executable
LOGSTASHEXEC = "/opt/logstash/bin/logstash"

ELASTICSEARCHHOST = "localhost:9200"
MAX_WAIT_FOR_LOSGSTASH = 120 #seconds

class ELProcessing:

    def InitiateLogstash(self, configfile, session):
        ''' Initiates logstash to parse the logfile
            and wait until parse all the data and
            index is successfully created in elasticsearch.
        '''

        es = Elasticsearch([ELASTICSEARCHHOST])
        
        if(es.indices.exists(session) == True):
            es.indices.delete(session)
    
        # Initiate logstash from separate process so we can continue
        # in this process and later we can kill logstash subprocess.
        # Please make a note that logstash will continue executing
        # unless explicitly killed.
        proc = subprocess.Popen([LOGSTASHEXEC,"-f",configfile])
        
        # Wait till index is been created in elasticsearch
        # Please make a note that index created doesn't mean
        # logstash is done with the log parsing.
        while (es.indices.exists(session)) == 0 :
            time.sleep(5)

        # We need to find whether logstash is done with the log
        # parsing or not. For that we can check index size if it
        # is still growing that means logstash is still parsing
        # the logs. When index size stops growing we can safely
        # assume that logstash is done with the log parsing and
        # we can kill the logstash process.
        prev_size = 0
        res = es.indices.stats(index=session, metric="store")
        hit = res['_all']['total']
        size = hit["store"]['size_in_bytes']

        while(prev_size != size):
            prev_size = size
            #es.indices.refresh(index=session)
            time.sleep(10)
            res = es.indices.stats(index=session, metric="store")
            hit = res['_all']['total']
            size = hit["store"]['size_in_bytes']

        # For a safe side wait for few seconds before killing the
        # logstash subprocess.
        time.sleep(5)

        # Kill logstash subprocess as it is done with log parsing.
        pid = proc.pid
        proc.terminate()

    def QueryElasticsearch(self, query, session):
        ''' It queries elasticsearch using provided query string. From the result
            of the query it poplates the data frame and increment the number of
            occurences for the desired column. Later we can write the data frame
            to .csv file
        '''
        es = Elasticsearch([ELASTICSEARCHHOST])
        
        # TODO: if there are >10000+ records then need to handle it.
        res = es.search(index=session, body=query, size=10000)

        return res
