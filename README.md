# 332-Hacks
Create a car-sharing website for CMPE 332 Database Management

Alterations to the mysqldump:
```
ALTER TABLE rental_comment ADD comment_reply VARCHAR(200) NOT NULL;
ALTER TABLE reservation ADD unlocked VARCHAR(10);
ALTER TABLE car_rental_history ADD (pu_time DATETIME, do_time DATETIME, status_on_pickup VARCHAR(50));
```
Change the `ROOT_PATH` environment variable in application controller