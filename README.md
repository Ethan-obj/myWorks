# myWorks
工作

## 长时间对table进行增删改会留下许多的数据空洞/碎片，这些空洞会占据原来数据的空间，并不会交还给disk
- 因此需要不定期的清除这些空间
- 如果不清除这些空间的话，也会被DNMS再次利用起来，但这块disk空间是不能被其他进程使用，只能由DBMS利用
- 可以通过重新组织表空间进行将空洞归还给OS
    - 如果是MyASIM存储引擎则通过``OPTIMIZE TABLE``
    - 如果是InnoDB则通过``alter table tb_user engine='innodb'``
