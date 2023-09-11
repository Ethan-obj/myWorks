# myWorks
工作

## 长时间对table进行增删改会留下许多的数据空洞/碎片，这些空洞会占据原来数据的空间，并不会交还给disk
- 因此需要不定期的清除这些空间
- 如果不清除这些空间的话，也会被DNMS再次利用起来，但这块disk空间是不能被其他进程使用，只能由DBMS利用
- 可以通过重新组织表空间进行将空洞归还给OS
    - 如果是MyASIM存储引擎则通过``OPTIMIZE TABLE``
    - 如果是InnoDB则通过``alter table tb_user engine='innodb'``
```xml
<Appenders>
    <RollingFile name="file-log"
                 fileName="/hkcdi/logs/app.log"
                 filePattern="/hkcdi/logs/backup/app-%d{yyyy-MM-dd}-%i.log">
        <ThresholdFilter level="INFO"/>
        <PatternLayout>
            <pattern>[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%t] [%X{TraceId}] %c{12} - %msg%n</pattern>
        </PatternLayout>
        <Policies>
            <TimeBasedTriggeringPolicy interval="1"/>
            <SizeBasedTriggeringPolicy size="1MB"/>
        </Policies>
        <DefaultRolloverStrategy max="3"/>
    </RollingFile>
</Appenders>
```
- 上面的 \<TimeBasedTriggeringPolicy interval="1"/> 表示当前时间不与filePattern中的yyyy-MM-dd相匹配时发生rollover
  - 比如 /hkcdi/logs/backup/app-2023-09-01-1.log，当时间第二天了也即是2023-09-02，就会触发一次rollover，会将app.log重命名为app-2023-09-02-1.log
- \<SizeBasedTriggeringPolicy size="50000 KB"/> 跟filePatter中的%i有关。其实你可以认为这个%i就是为了控制一天内(具体时间看filePattern中定义的%d)不要产生过多的归档文件
  - 如果在同一天也就是2023-09-01，当app.log大于1MB时发生rollover并且文件名中的i加1，当加到3时，如果再次发生rollover，则会将app-2023-09-01-1.log删除掉
  - 如果第二天了，也就是2023-09-02，那么前面3个2023-09-01的归档文件不会被删除掉。\<DefaultRolloverStrategy max="3"/> 中的3只针对filePattern中%i前面相同的文件名进行删除
