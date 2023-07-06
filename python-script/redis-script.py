import redis
from datetime import datetime
import time

redis_host = "52.90.237.59"
redis_port = 32388
redis_password = ""
count = 1

def connectRedis():
    global count
    r = redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password)
    dt = datetime.now()
    r.set(count, count)
    msg = r.get(count)
    print(count, dt)
    count += 1

if __name__ == '__main__':
    while True:
        try:
            connectRedis()
        except redis.exceptions.ConnectionError as e:
            print(e)
            time.sleep(5)
            print("Reconnecting...")
            continue  # Continue to the next iteration of the loop
        except Exception as e:
            print(e)
