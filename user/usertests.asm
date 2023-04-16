
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	df2080e7          	jalr	-526(ra) # 5e02 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	de0080e7          	jalr	-544(ra) # 5e02 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	2a250513          	addi	a0,a0,674 # 62e0 <malloc+0xe6>
      46:	00006097          	auipc	ra,0x6
      4a:	0fc080e7          	jalr	252(ra) # 6142 <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	d72080e7          	jalr	-654(ra) # 5dc2 <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	0000a797          	auipc	a5,0xa
      5c:	51078793          	addi	a5,a5,1296 # a568 <uninit>
      60:	0000d697          	auipc	a3,0xd
      64:	c1868693          	addi	a3,a3,-1000 # cc78 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	28050513          	addi	a0,a0,640 # 6300 <malloc+0x106>
      88:	00006097          	auipc	ra,0x6
      8c:	0ba080e7          	jalr	186(ra) # 6142 <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00006097          	auipc	ra,0x6
      96:	d30080e7          	jalr	-720(ra) # 5dc2 <exit>

000000000000009a <opentest>:
{
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	27050513          	addi	a0,a0,624 # 6318 <malloc+0x11e>
      b0:	00006097          	auipc	ra,0x6
      b4:	d52080e7          	jalr	-686(ra) # 5e02 <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00006097          	auipc	ra,0x6
      c0:	d2e080e7          	jalr	-722(ra) # 5dea <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	27250513          	addi	a0,a0,626 # 6338 <malloc+0x13e>
      ce:	00006097          	auipc	ra,0x6
      d2:	d34080e7          	jalr	-716(ra) # 5e02 <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	23a50513          	addi	a0,a0,570 # 6320 <malloc+0x126>
      ee:	00006097          	auipc	ra,0x6
      f2:	054080e7          	jalr	84(ra) # 6142 <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00006097          	auipc	ra,0x6
      fc:	cca080e7          	jalr	-822(ra) # 5dc2 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	24650513          	addi	a0,a0,582 # 6348 <malloc+0x14e>
     10a:	00006097          	auipc	ra,0x6
     10e:	038080e7          	jalr	56(ra) # 6142 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00006097          	auipc	ra,0x6
     118:	cae080e7          	jalr	-850(ra) # 5dc2 <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	24450513          	addi	a0,a0,580 # 6370 <malloc+0x176>
     134:	00006097          	auipc	ra,0x6
     138:	cde080e7          	jalr	-802(ra) # 5e12 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	23050513          	addi	a0,a0,560 # 6370 <malloc+0x176>
     148:	00006097          	auipc	ra,0x6
     14c:	cba080e7          	jalr	-838(ra) # 5e02 <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	22c58593          	addi	a1,a1,556 # 6380 <malloc+0x186>
     15c:	00006097          	auipc	ra,0x6
     160:	c86080e7          	jalr	-890(ra) # 5de2 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	20850513          	addi	a0,a0,520 # 6370 <malloc+0x176>
     170:	00006097          	auipc	ra,0x6
     174:	c92080e7          	jalr	-878(ra) # 5e02 <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	20c58593          	addi	a1,a1,524 # 6388 <malloc+0x18e>
     184:	8526                	mv	a0,s1
     186:	00006097          	auipc	ra,0x6
     18a:	c5c080e7          	jalr	-932(ra) # 5de2 <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	1dc50513          	addi	a0,a0,476 # 6370 <malloc+0x176>
     19c:	00006097          	auipc	ra,0x6
     1a0:	c76080e7          	jalr	-906(ra) # 5e12 <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00006097          	auipc	ra,0x6
     1aa:	c44080e7          	jalr	-956(ra) # 5dea <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00006097          	auipc	ra,0x6
     1b4:	c3a080e7          	jalr	-966(ra) # 5dea <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	1c650513          	addi	a0,a0,454 # 6390 <malloc+0x196>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	f70080e7          	jalr	-144(ra) # 6142 <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00006097          	auipc	ra,0x6
     1e0:	be6080e7          	jalr	-1050(ra) # 5dc2 <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00006097          	auipc	ra,0x6
     214:	bf2080e7          	jalr	-1038(ra) # 5e02 <open>
    close(fd);
     218:	00006097          	auipc	ra,0x6
     21c:	bd2080e7          	jalr	-1070(ra) # 5dea <close>
  for(i = 0; i < N; i++){
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	zext.b	s1,s1
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00006097          	auipc	ra,0x6
     24a:	bcc080e7          	jalr	-1076(ra) # 5e12 <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	zext.b	s1,s1
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	13c50513          	addi	a0,a0,316 # 63b8 <malloc+0x1be>
     284:	00006097          	auipc	ra,0x6
     288:	b8e080e7          	jalr	-1138(ra) # 5e12 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	128a8a93          	addi	s5,s5,296 # 63b8 <malloc+0x1be>
      int cc = write(fd, buf, sz);
     298:	0000da17          	auipc	s4,0xd
     29c:	9e0a0a13          	addi	s4,s4,-1568 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <diskfull+0x7>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00006097          	auipc	ra,0x6
     2b0:	b56080e7          	jalr	-1194(ra) # 5e02 <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00006097          	auipc	ra,0x6
     2c2:	b24080e7          	jalr	-1244(ra) # 5de2 <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49263          	bne	s1,a0,32c <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00006097          	auipc	ra,0x6
     2d6:	b10080e7          	jalr	-1264(ra) # 5de2 <write>
      if(cc != sz){
     2da:	04951a63          	bne	a0,s1,32e <bigwrite+0xca>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00006097          	auipc	ra,0x6
     2e4:	b0a080e7          	jalr	-1270(ra) # 5dea <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00006097          	auipc	ra,0x6
     2ee:	b28080e7          	jalr	-1240(ra) # 5e12 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	0b650513          	addi	a0,a0,182 # 63c8 <malloc+0x1ce>
     31a:	00006097          	auipc	ra,0x6
     31e:	e28080e7          	jalr	-472(ra) # 6142 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00006097          	auipc	ra,0x6
     328:	a9e080e7          	jalr	-1378(ra) # 5dc2 <exit>
      if(cc != sz){
     32c:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     32e:	86aa                	mv	a3,a0
     330:	864e                	mv	a2,s3
     332:	85de                	mv	a1,s7
     334:	00006517          	auipc	a0,0x6
     338:	0b450513          	addi	a0,a0,180 # 63e8 <malloc+0x1ee>
     33c:	00006097          	auipc	ra,0x6
     340:	e06080e7          	jalr	-506(ra) # 6142 <printf>
        exit(1);
     344:	4505                	li	a0,1
     346:	00006097          	auipc	ra,0x6
     34a:	a7c080e7          	jalr	-1412(ra) # 5dc2 <exit>

000000000000034e <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     34e:	7179                	addi	sp,sp,-48
     350:	f406                	sd	ra,40(sp)
     352:	f022                	sd	s0,32(sp)
     354:	ec26                	sd	s1,24(sp)
     356:	e84a                	sd	s2,16(sp)
     358:	e44e                	sd	s3,8(sp)
     35a:	e052                	sd	s4,0(sp)
     35c:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     35e:	00006517          	auipc	a0,0x6
     362:	0a250513          	addi	a0,a0,162 # 6400 <malloc+0x206>
     366:	00006097          	auipc	ra,0x6
     36a:	aac080e7          	jalr	-1364(ra) # 5e12 <unlink>
     36e:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     372:	00006997          	auipc	s3,0x6
     376:	08e98993          	addi	s3,s3,142 # 6400 <malloc+0x206>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     37a:	5a7d                	li	s4,-1
     37c:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     380:	20100593          	li	a1,513
     384:	854e                	mv	a0,s3
     386:	00006097          	auipc	ra,0x6
     38a:	a7c080e7          	jalr	-1412(ra) # 5e02 <open>
     38e:	84aa                	mv	s1,a0
    if(fd < 0){
     390:	06054b63          	bltz	a0,406 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
     394:	4605                	li	a2,1
     396:	85d2                	mv	a1,s4
     398:	00006097          	auipc	ra,0x6
     39c:	a4a080e7          	jalr	-1462(ra) # 5de2 <write>
    close(fd);
     3a0:	8526                	mv	a0,s1
     3a2:	00006097          	auipc	ra,0x6
     3a6:	a48080e7          	jalr	-1464(ra) # 5dea <close>
    unlink("junk");
     3aa:	854e                	mv	a0,s3
     3ac:	00006097          	auipc	ra,0x6
     3b0:	a66080e7          	jalr	-1434(ra) # 5e12 <unlink>
  for(int i = 0; i < assumed_free; i++){
     3b4:	397d                	addiw	s2,s2,-1
     3b6:	fc0915e3          	bnez	s2,380 <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     3ba:	20100593          	li	a1,513
     3be:	00006517          	auipc	a0,0x6
     3c2:	04250513          	addi	a0,a0,66 # 6400 <malloc+0x206>
     3c6:	00006097          	auipc	ra,0x6
     3ca:	a3c080e7          	jalr	-1476(ra) # 5e02 <open>
     3ce:	84aa                	mv	s1,a0
  if(fd < 0){
     3d0:	04054863          	bltz	a0,420 <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     3d4:	4605                	li	a2,1
     3d6:	00006597          	auipc	a1,0x6
     3da:	fb258593          	addi	a1,a1,-78 # 6388 <malloc+0x18e>
     3de:	00006097          	auipc	ra,0x6
     3e2:	a04080e7          	jalr	-1532(ra) # 5de2 <write>
     3e6:	4785                	li	a5,1
     3e8:	04f50963          	beq	a0,a5,43a <badwrite+0xec>
    printf("write failed\n");
     3ec:	00006517          	auipc	a0,0x6
     3f0:	03450513          	addi	a0,a0,52 # 6420 <malloc+0x226>
     3f4:	00006097          	auipc	ra,0x6
     3f8:	d4e080e7          	jalr	-690(ra) # 6142 <printf>
    exit(1);
     3fc:	4505                	li	a0,1
     3fe:	00006097          	auipc	ra,0x6
     402:	9c4080e7          	jalr	-1596(ra) # 5dc2 <exit>
      printf("open junk failed\n");
     406:	00006517          	auipc	a0,0x6
     40a:	00250513          	addi	a0,a0,2 # 6408 <malloc+0x20e>
     40e:	00006097          	auipc	ra,0x6
     412:	d34080e7          	jalr	-716(ra) # 6142 <printf>
      exit(1);
     416:	4505                	li	a0,1
     418:	00006097          	auipc	ra,0x6
     41c:	9aa080e7          	jalr	-1622(ra) # 5dc2 <exit>
    printf("open junk failed\n");
     420:	00006517          	auipc	a0,0x6
     424:	fe850513          	addi	a0,a0,-24 # 6408 <malloc+0x20e>
     428:	00006097          	auipc	ra,0x6
     42c:	d1a080e7          	jalr	-742(ra) # 6142 <printf>
    exit(1);
     430:	4505                	li	a0,1
     432:	00006097          	auipc	ra,0x6
     436:	990080e7          	jalr	-1648(ra) # 5dc2 <exit>
  }
  close(fd);
     43a:	8526                	mv	a0,s1
     43c:	00006097          	auipc	ra,0x6
     440:	9ae080e7          	jalr	-1618(ra) # 5dea <close>
  unlink("junk");
     444:	00006517          	auipc	a0,0x6
     448:	fbc50513          	addi	a0,a0,-68 # 6400 <malloc+0x206>
     44c:	00006097          	auipc	ra,0x6
     450:	9c6080e7          	jalr	-1594(ra) # 5e12 <unlink>

  exit(0);
     454:	4501                	li	a0,0
     456:	00006097          	auipc	ra,0x6
     45a:	96c080e7          	jalr	-1684(ra) # 5dc2 <exit>

000000000000045e <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     45e:	715d                	addi	sp,sp,-80
     460:	e486                	sd	ra,72(sp)
     462:	e0a2                	sd	s0,64(sp)
     464:	fc26                	sd	s1,56(sp)
     466:	f84a                	sd	s2,48(sp)
     468:	f44e                	sd	s3,40(sp)
     46a:	0880                	addi	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     46c:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     46e:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     472:	40000993          	li	s3,1024
    name[0] = 'z';
     476:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     47a:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     47e:	41f4d71b          	sraiw	a4,s1,0x1f
     482:	01b7571b          	srliw	a4,a4,0x1b
     486:	009707bb          	addw	a5,a4,s1
     48a:	4057d69b          	sraiw	a3,a5,0x5
     48e:	0306869b          	addiw	a3,a3,48
     492:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     496:	8bfd                	andi	a5,a5,31
     498:	9f99                	subw	a5,a5,a4
     49a:	0307879b          	addiw	a5,a5,48
     49e:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     4a2:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     4a6:	fb040513          	addi	a0,s0,-80
     4aa:	00006097          	auipc	ra,0x6
     4ae:	968080e7          	jalr	-1688(ra) # 5e12 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     4b2:	60200593          	li	a1,1538
     4b6:	fb040513          	addi	a0,s0,-80
     4ba:	00006097          	auipc	ra,0x6
     4be:	948080e7          	jalr	-1720(ra) # 5e02 <open>
    if(fd < 0){
     4c2:	00054963          	bltz	a0,4d4 <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
     4c6:	00006097          	auipc	ra,0x6
     4ca:	924080e7          	jalr	-1756(ra) # 5dea <close>
  for(int i = 0; i < nzz; i++){
     4ce:	2485                	addiw	s1,s1,1
     4d0:	fb3493e3          	bne	s1,s3,476 <outofinodes+0x18>
     4d4:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     4d6:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     4da:	40000993          	li	s3,1024
    name[0] = 'z';
     4de:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     4e2:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     4e6:	41f4d71b          	sraiw	a4,s1,0x1f
     4ea:	01b7571b          	srliw	a4,a4,0x1b
     4ee:	009707bb          	addw	a5,a4,s1
     4f2:	4057d69b          	sraiw	a3,a5,0x5
     4f6:	0306869b          	addiw	a3,a3,48
     4fa:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     4fe:	8bfd                	andi	a5,a5,31
     500:	9f99                	subw	a5,a5,a4
     502:	0307879b          	addiw	a5,a5,48
     506:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     50a:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     50e:	fb040513          	addi	a0,s0,-80
     512:	00006097          	auipc	ra,0x6
     516:	900080e7          	jalr	-1792(ra) # 5e12 <unlink>
  for(int i = 0; i < nzz; i++){
     51a:	2485                	addiw	s1,s1,1
     51c:	fd3491e3          	bne	s1,s3,4de <outofinodes+0x80>
  }
}
     520:	60a6                	ld	ra,72(sp)
     522:	6406                	ld	s0,64(sp)
     524:	74e2                	ld	s1,56(sp)
     526:	7942                	ld	s2,48(sp)
     528:	79a2                	ld	s3,40(sp)
     52a:	6161                	addi	sp,sp,80
     52c:	8082                	ret

000000000000052e <copyin>:
{
     52e:	715d                	addi	sp,sp,-80
     530:	e486                	sd	ra,72(sp)
     532:	e0a2                	sd	s0,64(sp)
     534:	fc26                	sd	s1,56(sp)
     536:	f84a                	sd	s2,48(sp)
     538:	f44e                	sd	s3,40(sp)
     53a:	f052                	sd	s4,32(sp)
     53c:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     53e:	4785                	li	a5,1
     540:	07fe                	slli	a5,a5,0x1f
     542:	fcf43023          	sd	a5,-64(s0)
     546:	57fd                	li	a5,-1
     548:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     54c:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     550:	00006a17          	auipc	s4,0x6
     554:	ee0a0a13          	addi	s4,s4,-288 # 6430 <malloc+0x236>
    uint64 addr = addrs[ai];
     558:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     55c:	20100593          	li	a1,513
     560:	8552                	mv	a0,s4
     562:	00006097          	auipc	ra,0x6
     566:	8a0080e7          	jalr	-1888(ra) # 5e02 <open>
     56a:	84aa                	mv	s1,a0
    if(fd < 0){
     56c:	08054863          	bltz	a0,5fc <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     570:	6609                	lui	a2,0x2
     572:	85ce                	mv	a1,s3
     574:	00006097          	auipc	ra,0x6
     578:	86e080e7          	jalr	-1938(ra) # 5de2 <write>
    if(n >= 0){
     57c:	08055d63          	bgez	a0,616 <copyin+0xe8>
    close(fd);
     580:	8526                	mv	a0,s1
     582:	00006097          	auipc	ra,0x6
     586:	868080e7          	jalr	-1944(ra) # 5dea <close>
    unlink("copyin1");
     58a:	8552                	mv	a0,s4
     58c:	00006097          	auipc	ra,0x6
     590:	886080e7          	jalr	-1914(ra) # 5e12 <unlink>
    n = write(1, (char*)addr, 8192);
     594:	6609                	lui	a2,0x2
     596:	85ce                	mv	a1,s3
     598:	4505                	li	a0,1
     59a:	00006097          	auipc	ra,0x6
     59e:	848080e7          	jalr	-1976(ra) # 5de2 <write>
    if(n > 0){
     5a2:	08a04963          	bgtz	a0,634 <copyin+0x106>
    if(pipe(fds) < 0){
     5a6:	fb840513          	addi	a0,s0,-72
     5aa:	00006097          	auipc	ra,0x6
     5ae:	828080e7          	jalr	-2008(ra) # 5dd2 <pipe>
     5b2:	0a054063          	bltz	a0,652 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     5b6:	6609                	lui	a2,0x2
     5b8:	85ce                	mv	a1,s3
     5ba:	fbc42503          	lw	a0,-68(s0)
     5be:	00006097          	auipc	ra,0x6
     5c2:	824080e7          	jalr	-2012(ra) # 5de2 <write>
    if(n > 0){
     5c6:	0aa04363          	bgtz	a0,66c <copyin+0x13e>
    close(fds[0]);
     5ca:	fb842503          	lw	a0,-72(s0)
     5ce:	00006097          	auipc	ra,0x6
     5d2:	81c080e7          	jalr	-2020(ra) # 5dea <close>
    close(fds[1]);
     5d6:	fbc42503          	lw	a0,-68(s0)
     5da:	00006097          	auipc	ra,0x6
     5de:	810080e7          	jalr	-2032(ra) # 5dea <close>
  for(int ai = 0; ai < 2; ai++){
     5e2:	0921                	addi	s2,s2,8
     5e4:	fd040793          	addi	a5,s0,-48
     5e8:	f6f918e3          	bne	s2,a5,558 <copyin+0x2a>
}
     5ec:	60a6                	ld	ra,72(sp)
     5ee:	6406                	ld	s0,64(sp)
     5f0:	74e2                	ld	s1,56(sp)
     5f2:	7942                	ld	s2,48(sp)
     5f4:	79a2                	ld	s3,40(sp)
     5f6:	7a02                	ld	s4,32(sp)
     5f8:	6161                	addi	sp,sp,80
     5fa:	8082                	ret
      printf("open(copyin1) failed\n");
     5fc:	00006517          	auipc	a0,0x6
     600:	e3c50513          	addi	a0,a0,-452 # 6438 <malloc+0x23e>
     604:	00006097          	auipc	ra,0x6
     608:	b3e080e7          	jalr	-1218(ra) # 6142 <printf>
      exit(1);
     60c:	4505                	li	a0,1
     60e:	00005097          	auipc	ra,0x5
     612:	7b4080e7          	jalr	1972(ra) # 5dc2 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     616:	862a                	mv	a2,a0
     618:	85ce                	mv	a1,s3
     61a:	00006517          	auipc	a0,0x6
     61e:	e3650513          	addi	a0,a0,-458 # 6450 <malloc+0x256>
     622:	00006097          	auipc	ra,0x6
     626:	b20080e7          	jalr	-1248(ra) # 6142 <printf>
      exit(1);
     62a:	4505                	li	a0,1
     62c:	00005097          	auipc	ra,0x5
     630:	796080e7          	jalr	1942(ra) # 5dc2 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     634:	862a                	mv	a2,a0
     636:	85ce                	mv	a1,s3
     638:	00006517          	auipc	a0,0x6
     63c:	e4850513          	addi	a0,a0,-440 # 6480 <malloc+0x286>
     640:	00006097          	auipc	ra,0x6
     644:	b02080e7          	jalr	-1278(ra) # 6142 <printf>
      exit(1);
     648:	4505                	li	a0,1
     64a:	00005097          	auipc	ra,0x5
     64e:	778080e7          	jalr	1912(ra) # 5dc2 <exit>
      printf("pipe() failed\n");
     652:	00006517          	auipc	a0,0x6
     656:	e5e50513          	addi	a0,a0,-418 # 64b0 <malloc+0x2b6>
     65a:	00006097          	auipc	ra,0x6
     65e:	ae8080e7          	jalr	-1304(ra) # 6142 <printf>
      exit(1);
     662:	4505                	li	a0,1
     664:	00005097          	auipc	ra,0x5
     668:	75e080e7          	jalr	1886(ra) # 5dc2 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     66c:	862a                	mv	a2,a0
     66e:	85ce                	mv	a1,s3
     670:	00006517          	auipc	a0,0x6
     674:	e5050513          	addi	a0,a0,-432 # 64c0 <malloc+0x2c6>
     678:	00006097          	auipc	ra,0x6
     67c:	aca080e7          	jalr	-1334(ra) # 6142 <printf>
      exit(1);
     680:	4505                	li	a0,1
     682:	00005097          	auipc	ra,0x5
     686:	740080e7          	jalr	1856(ra) # 5dc2 <exit>

000000000000068a <copyout>:
{
     68a:	711d                	addi	sp,sp,-96
     68c:	ec86                	sd	ra,88(sp)
     68e:	e8a2                	sd	s0,80(sp)
     690:	e4a6                	sd	s1,72(sp)
     692:	e0ca                	sd	s2,64(sp)
     694:	fc4e                	sd	s3,56(sp)
     696:	f852                	sd	s4,48(sp)
     698:	f456                	sd	s5,40(sp)
     69a:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     69c:	4785                	li	a5,1
     69e:	07fe                	slli	a5,a5,0x1f
     6a0:	faf43823          	sd	a5,-80(s0)
     6a4:	57fd                	li	a5,-1
     6a6:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     6aa:	fb040913          	addi	s2,s0,-80
    int fd = open("README", 0);
     6ae:	00006a17          	auipc	s4,0x6
     6b2:	e42a0a13          	addi	s4,s4,-446 # 64f0 <malloc+0x2f6>
    n = write(fds[1], "x", 1);
     6b6:	00006a97          	auipc	s5,0x6
     6ba:	cd2a8a93          	addi	s5,s5,-814 # 6388 <malloc+0x18e>
    uint64 addr = addrs[ai];
     6be:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     6c2:	4581                	li	a1,0
     6c4:	8552                	mv	a0,s4
     6c6:	00005097          	auipc	ra,0x5
     6ca:	73c080e7          	jalr	1852(ra) # 5e02 <open>
     6ce:	84aa                	mv	s1,a0
    if(fd < 0){
     6d0:	08054663          	bltz	a0,75c <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     6d4:	6609                	lui	a2,0x2
     6d6:	85ce                	mv	a1,s3
     6d8:	00005097          	auipc	ra,0x5
     6dc:	702080e7          	jalr	1794(ra) # 5dda <read>
    if(n > 0){
     6e0:	08a04b63          	bgtz	a0,776 <copyout+0xec>
    close(fd);
     6e4:	8526                	mv	a0,s1
     6e6:	00005097          	auipc	ra,0x5
     6ea:	704080e7          	jalr	1796(ra) # 5dea <close>
    if(pipe(fds) < 0){
     6ee:	fa840513          	addi	a0,s0,-88
     6f2:	00005097          	auipc	ra,0x5
     6f6:	6e0080e7          	jalr	1760(ra) # 5dd2 <pipe>
     6fa:	08054d63          	bltz	a0,794 <copyout+0x10a>
    n = write(fds[1], "x", 1);
     6fe:	4605                	li	a2,1
     700:	85d6                	mv	a1,s5
     702:	fac42503          	lw	a0,-84(s0)
     706:	00005097          	auipc	ra,0x5
     70a:	6dc080e7          	jalr	1756(ra) # 5de2 <write>
    if(n != 1){
     70e:	4785                	li	a5,1
     710:	08f51f63          	bne	a0,a5,7ae <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     714:	6609                	lui	a2,0x2
     716:	85ce                	mv	a1,s3
     718:	fa842503          	lw	a0,-88(s0)
     71c:	00005097          	auipc	ra,0x5
     720:	6be080e7          	jalr	1726(ra) # 5dda <read>
    if(n > 0){
     724:	0aa04263          	bgtz	a0,7c8 <copyout+0x13e>
    close(fds[0]);
     728:	fa842503          	lw	a0,-88(s0)
     72c:	00005097          	auipc	ra,0x5
     730:	6be080e7          	jalr	1726(ra) # 5dea <close>
    close(fds[1]);
     734:	fac42503          	lw	a0,-84(s0)
     738:	00005097          	auipc	ra,0x5
     73c:	6b2080e7          	jalr	1714(ra) # 5dea <close>
  for(int ai = 0; ai < 2; ai++){
     740:	0921                	addi	s2,s2,8
     742:	fc040793          	addi	a5,s0,-64
     746:	f6f91ce3          	bne	s2,a5,6be <copyout+0x34>
}
     74a:	60e6                	ld	ra,88(sp)
     74c:	6446                	ld	s0,80(sp)
     74e:	64a6                	ld	s1,72(sp)
     750:	6906                	ld	s2,64(sp)
     752:	79e2                	ld	s3,56(sp)
     754:	7a42                	ld	s4,48(sp)
     756:	7aa2                	ld	s5,40(sp)
     758:	6125                	addi	sp,sp,96
     75a:	8082                	ret
      printf("open(README) failed\n");
     75c:	00006517          	auipc	a0,0x6
     760:	d9c50513          	addi	a0,a0,-612 # 64f8 <malloc+0x2fe>
     764:	00006097          	auipc	ra,0x6
     768:	9de080e7          	jalr	-1570(ra) # 6142 <printf>
      exit(1);
     76c:	4505                	li	a0,1
     76e:	00005097          	auipc	ra,0x5
     772:	654080e7          	jalr	1620(ra) # 5dc2 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     776:	862a                	mv	a2,a0
     778:	85ce                	mv	a1,s3
     77a:	00006517          	auipc	a0,0x6
     77e:	d9650513          	addi	a0,a0,-618 # 6510 <malloc+0x316>
     782:	00006097          	auipc	ra,0x6
     786:	9c0080e7          	jalr	-1600(ra) # 6142 <printf>
      exit(1);
     78a:	4505                	li	a0,1
     78c:	00005097          	auipc	ra,0x5
     790:	636080e7          	jalr	1590(ra) # 5dc2 <exit>
      printf("pipe() failed\n");
     794:	00006517          	auipc	a0,0x6
     798:	d1c50513          	addi	a0,a0,-740 # 64b0 <malloc+0x2b6>
     79c:	00006097          	auipc	ra,0x6
     7a0:	9a6080e7          	jalr	-1626(ra) # 6142 <printf>
      exit(1);
     7a4:	4505                	li	a0,1
     7a6:	00005097          	auipc	ra,0x5
     7aa:	61c080e7          	jalr	1564(ra) # 5dc2 <exit>
      printf("pipe write failed\n");
     7ae:	00006517          	auipc	a0,0x6
     7b2:	d9250513          	addi	a0,a0,-622 # 6540 <malloc+0x346>
     7b6:	00006097          	auipc	ra,0x6
     7ba:	98c080e7          	jalr	-1652(ra) # 6142 <printf>
      exit(1);
     7be:	4505                	li	a0,1
     7c0:	00005097          	auipc	ra,0x5
     7c4:	602080e7          	jalr	1538(ra) # 5dc2 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7c8:	862a                	mv	a2,a0
     7ca:	85ce                	mv	a1,s3
     7cc:	00006517          	auipc	a0,0x6
     7d0:	d8c50513          	addi	a0,a0,-628 # 6558 <malloc+0x35e>
     7d4:	00006097          	auipc	ra,0x6
     7d8:	96e080e7          	jalr	-1682(ra) # 6142 <printf>
      exit(1);
     7dc:	4505                	li	a0,1
     7de:	00005097          	auipc	ra,0x5
     7e2:	5e4080e7          	jalr	1508(ra) # 5dc2 <exit>

00000000000007e6 <truncate1>:
{
     7e6:	711d                	addi	sp,sp,-96
     7e8:	ec86                	sd	ra,88(sp)
     7ea:	e8a2                	sd	s0,80(sp)
     7ec:	e4a6                	sd	s1,72(sp)
     7ee:	e0ca                	sd	s2,64(sp)
     7f0:	fc4e                	sd	s3,56(sp)
     7f2:	f852                	sd	s4,48(sp)
     7f4:	f456                	sd	s5,40(sp)
     7f6:	1080                	addi	s0,sp,96
     7f8:	8aaa                	mv	s5,a0
  unlink("truncfile");
     7fa:	00006517          	auipc	a0,0x6
     7fe:	b7650513          	addi	a0,a0,-1162 # 6370 <malloc+0x176>
     802:	00005097          	auipc	ra,0x5
     806:	610080e7          	jalr	1552(ra) # 5e12 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     80a:	60100593          	li	a1,1537
     80e:	00006517          	auipc	a0,0x6
     812:	b6250513          	addi	a0,a0,-1182 # 6370 <malloc+0x176>
     816:	00005097          	auipc	ra,0x5
     81a:	5ec080e7          	jalr	1516(ra) # 5e02 <open>
     81e:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     820:	4611                	li	a2,4
     822:	00006597          	auipc	a1,0x6
     826:	b5e58593          	addi	a1,a1,-1186 # 6380 <malloc+0x186>
     82a:	00005097          	auipc	ra,0x5
     82e:	5b8080e7          	jalr	1464(ra) # 5de2 <write>
  close(fd1);
     832:	8526                	mv	a0,s1
     834:	00005097          	auipc	ra,0x5
     838:	5b6080e7          	jalr	1462(ra) # 5dea <close>
  int fd2 = open("truncfile", O_RDONLY);
     83c:	4581                	li	a1,0
     83e:	00006517          	auipc	a0,0x6
     842:	b3250513          	addi	a0,a0,-1230 # 6370 <malloc+0x176>
     846:	00005097          	auipc	ra,0x5
     84a:	5bc080e7          	jalr	1468(ra) # 5e02 <open>
     84e:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     850:	02000613          	li	a2,32
     854:	fa040593          	addi	a1,s0,-96
     858:	00005097          	auipc	ra,0x5
     85c:	582080e7          	jalr	1410(ra) # 5dda <read>
  if(n != 4){
     860:	4791                	li	a5,4
     862:	0cf51e63          	bne	a0,a5,93e <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     866:	40100593          	li	a1,1025
     86a:	00006517          	auipc	a0,0x6
     86e:	b0650513          	addi	a0,a0,-1274 # 6370 <malloc+0x176>
     872:	00005097          	auipc	ra,0x5
     876:	590080e7          	jalr	1424(ra) # 5e02 <open>
     87a:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     87c:	4581                	li	a1,0
     87e:	00006517          	auipc	a0,0x6
     882:	af250513          	addi	a0,a0,-1294 # 6370 <malloc+0x176>
     886:	00005097          	auipc	ra,0x5
     88a:	57c080e7          	jalr	1404(ra) # 5e02 <open>
     88e:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     890:	02000613          	li	a2,32
     894:	fa040593          	addi	a1,s0,-96
     898:	00005097          	auipc	ra,0x5
     89c:	542080e7          	jalr	1346(ra) # 5dda <read>
     8a0:	8a2a                	mv	s4,a0
  if(n != 0){
     8a2:	ed4d                	bnez	a0,95c <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     8a4:	02000613          	li	a2,32
     8a8:	fa040593          	addi	a1,s0,-96
     8ac:	8526                	mv	a0,s1
     8ae:	00005097          	auipc	ra,0x5
     8b2:	52c080e7          	jalr	1324(ra) # 5dda <read>
     8b6:	8a2a                	mv	s4,a0
  if(n != 0){
     8b8:	e971                	bnez	a0,98c <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     8ba:	4619                	li	a2,6
     8bc:	00006597          	auipc	a1,0x6
     8c0:	d2c58593          	addi	a1,a1,-724 # 65e8 <malloc+0x3ee>
     8c4:	854e                	mv	a0,s3
     8c6:	00005097          	auipc	ra,0x5
     8ca:	51c080e7          	jalr	1308(ra) # 5de2 <write>
  n = read(fd3, buf, sizeof(buf));
     8ce:	02000613          	li	a2,32
     8d2:	fa040593          	addi	a1,s0,-96
     8d6:	854a                	mv	a0,s2
     8d8:	00005097          	auipc	ra,0x5
     8dc:	502080e7          	jalr	1282(ra) # 5dda <read>
  if(n != 6){
     8e0:	4799                	li	a5,6
     8e2:	0cf51d63          	bne	a0,a5,9bc <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     8e6:	02000613          	li	a2,32
     8ea:	fa040593          	addi	a1,s0,-96
     8ee:	8526                	mv	a0,s1
     8f0:	00005097          	auipc	ra,0x5
     8f4:	4ea080e7          	jalr	1258(ra) # 5dda <read>
  if(n != 2){
     8f8:	4789                	li	a5,2
     8fa:	0ef51063          	bne	a0,a5,9da <truncate1+0x1f4>
  unlink("truncfile");
     8fe:	00006517          	auipc	a0,0x6
     902:	a7250513          	addi	a0,a0,-1422 # 6370 <malloc+0x176>
     906:	00005097          	auipc	ra,0x5
     90a:	50c080e7          	jalr	1292(ra) # 5e12 <unlink>
  close(fd1);
     90e:	854e                	mv	a0,s3
     910:	00005097          	auipc	ra,0x5
     914:	4da080e7          	jalr	1242(ra) # 5dea <close>
  close(fd2);
     918:	8526                	mv	a0,s1
     91a:	00005097          	auipc	ra,0x5
     91e:	4d0080e7          	jalr	1232(ra) # 5dea <close>
  close(fd3);
     922:	854a                	mv	a0,s2
     924:	00005097          	auipc	ra,0x5
     928:	4c6080e7          	jalr	1222(ra) # 5dea <close>
}
     92c:	60e6                	ld	ra,88(sp)
     92e:	6446                	ld	s0,80(sp)
     930:	64a6                	ld	s1,72(sp)
     932:	6906                	ld	s2,64(sp)
     934:	79e2                	ld	s3,56(sp)
     936:	7a42                	ld	s4,48(sp)
     938:	7aa2                	ld	s5,40(sp)
     93a:	6125                	addi	sp,sp,96
     93c:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     93e:	862a                	mv	a2,a0
     940:	85d6                	mv	a1,s5
     942:	00006517          	auipc	a0,0x6
     946:	c4650513          	addi	a0,a0,-954 # 6588 <malloc+0x38e>
     94a:	00005097          	auipc	ra,0x5
     94e:	7f8080e7          	jalr	2040(ra) # 6142 <printf>
    exit(1);
     952:	4505                	li	a0,1
     954:	00005097          	auipc	ra,0x5
     958:	46e080e7          	jalr	1134(ra) # 5dc2 <exit>
    printf("aaa fd3=%d\n", fd3);
     95c:	85ca                	mv	a1,s2
     95e:	00006517          	auipc	a0,0x6
     962:	c4a50513          	addi	a0,a0,-950 # 65a8 <malloc+0x3ae>
     966:	00005097          	auipc	ra,0x5
     96a:	7dc080e7          	jalr	2012(ra) # 6142 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     96e:	8652                	mv	a2,s4
     970:	85d6                	mv	a1,s5
     972:	00006517          	auipc	a0,0x6
     976:	c4650513          	addi	a0,a0,-954 # 65b8 <malloc+0x3be>
     97a:	00005097          	auipc	ra,0x5
     97e:	7c8080e7          	jalr	1992(ra) # 6142 <printf>
    exit(1);
     982:	4505                	li	a0,1
     984:	00005097          	auipc	ra,0x5
     988:	43e080e7          	jalr	1086(ra) # 5dc2 <exit>
    printf("bbb fd2=%d\n", fd2);
     98c:	85a6                	mv	a1,s1
     98e:	00006517          	auipc	a0,0x6
     992:	c4a50513          	addi	a0,a0,-950 # 65d8 <malloc+0x3de>
     996:	00005097          	auipc	ra,0x5
     99a:	7ac080e7          	jalr	1964(ra) # 6142 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     99e:	8652                	mv	a2,s4
     9a0:	85d6                	mv	a1,s5
     9a2:	00006517          	auipc	a0,0x6
     9a6:	c1650513          	addi	a0,a0,-1002 # 65b8 <malloc+0x3be>
     9aa:	00005097          	auipc	ra,0x5
     9ae:	798080e7          	jalr	1944(ra) # 6142 <printf>
    exit(1);
     9b2:	4505                	li	a0,1
     9b4:	00005097          	auipc	ra,0x5
     9b8:	40e080e7          	jalr	1038(ra) # 5dc2 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     9bc:	862a                	mv	a2,a0
     9be:	85d6                	mv	a1,s5
     9c0:	00006517          	auipc	a0,0x6
     9c4:	c3050513          	addi	a0,a0,-976 # 65f0 <malloc+0x3f6>
     9c8:	00005097          	auipc	ra,0x5
     9cc:	77a080e7          	jalr	1914(ra) # 6142 <printf>
    exit(1);
     9d0:	4505                	li	a0,1
     9d2:	00005097          	auipc	ra,0x5
     9d6:	3f0080e7          	jalr	1008(ra) # 5dc2 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     9da:	862a                	mv	a2,a0
     9dc:	85d6                	mv	a1,s5
     9de:	00006517          	auipc	a0,0x6
     9e2:	c3250513          	addi	a0,a0,-974 # 6610 <malloc+0x416>
     9e6:	00005097          	auipc	ra,0x5
     9ea:	75c080e7          	jalr	1884(ra) # 6142 <printf>
    exit(1);
     9ee:	4505                	li	a0,1
     9f0:	00005097          	auipc	ra,0x5
     9f4:	3d2080e7          	jalr	978(ra) # 5dc2 <exit>

00000000000009f8 <writetest>:
{
     9f8:	7139                	addi	sp,sp,-64
     9fa:	fc06                	sd	ra,56(sp)
     9fc:	f822                	sd	s0,48(sp)
     9fe:	f426                	sd	s1,40(sp)
     a00:	f04a                	sd	s2,32(sp)
     a02:	ec4e                	sd	s3,24(sp)
     a04:	e852                	sd	s4,16(sp)
     a06:	e456                	sd	s5,8(sp)
     a08:	e05a                	sd	s6,0(sp)
     a0a:	0080                	addi	s0,sp,64
     a0c:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     a0e:	20200593          	li	a1,514
     a12:	00006517          	auipc	a0,0x6
     a16:	c1e50513          	addi	a0,a0,-994 # 6630 <malloc+0x436>
     a1a:	00005097          	auipc	ra,0x5
     a1e:	3e8080e7          	jalr	1000(ra) # 5e02 <open>
  if(fd < 0){
     a22:	0a054d63          	bltz	a0,adc <writetest+0xe4>
     a26:	892a                	mv	s2,a0
     a28:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a2a:	00006997          	auipc	s3,0x6
     a2e:	c2e98993          	addi	s3,s3,-978 # 6658 <malloc+0x45e>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a32:	00006a97          	auipc	s5,0x6
     a36:	c5ea8a93          	addi	s5,s5,-930 # 6690 <malloc+0x496>
  for(i = 0; i < N; i++){
     a3a:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a3e:	4629                	li	a2,10
     a40:	85ce                	mv	a1,s3
     a42:	854a                	mv	a0,s2
     a44:	00005097          	auipc	ra,0x5
     a48:	39e080e7          	jalr	926(ra) # 5de2 <write>
     a4c:	47a9                	li	a5,10
     a4e:	0af51563          	bne	a0,a5,af8 <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a52:	4629                	li	a2,10
     a54:	85d6                	mv	a1,s5
     a56:	854a                	mv	a0,s2
     a58:	00005097          	auipc	ra,0x5
     a5c:	38a080e7          	jalr	906(ra) # 5de2 <write>
     a60:	47a9                	li	a5,10
     a62:	0af51a63          	bne	a0,a5,b16 <writetest+0x11e>
  for(i = 0; i < N; i++){
     a66:	2485                	addiw	s1,s1,1
     a68:	fd449be3          	bne	s1,s4,a3e <writetest+0x46>
  close(fd);
     a6c:	854a                	mv	a0,s2
     a6e:	00005097          	auipc	ra,0x5
     a72:	37c080e7          	jalr	892(ra) # 5dea <close>
  fd = open("small", O_RDONLY);
     a76:	4581                	li	a1,0
     a78:	00006517          	auipc	a0,0x6
     a7c:	bb850513          	addi	a0,a0,-1096 # 6630 <malloc+0x436>
     a80:	00005097          	auipc	ra,0x5
     a84:	382080e7          	jalr	898(ra) # 5e02 <open>
     a88:	84aa                	mv	s1,a0
  if(fd < 0){
     a8a:	0a054563          	bltz	a0,b34 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     a8e:	7d000613          	li	a2,2000
     a92:	0000c597          	auipc	a1,0xc
     a96:	1e658593          	addi	a1,a1,486 # cc78 <buf>
     a9a:	00005097          	auipc	ra,0x5
     a9e:	340080e7          	jalr	832(ra) # 5dda <read>
  if(i != N*SZ*2){
     aa2:	7d000793          	li	a5,2000
     aa6:	0af51563          	bne	a0,a5,b50 <writetest+0x158>
  close(fd);
     aaa:	8526                	mv	a0,s1
     aac:	00005097          	auipc	ra,0x5
     ab0:	33e080e7          	jalr	830(ra) # 5dea <close>
  if(unlink("small") < 0){
     ab4:	00006517          	auipc	a0,0x6
     ab8:	b7c50513          	addi	a0,a0,-1156 # 6630 <malloc+0x436>
     abc:	00005097          	auipc	ra,0x5
     ac0:	356080e7          	jalr	854(ra) # 5e12 <unlink>
     ac4:	0a054463          	bltz	a0,b6c <writetest+0x174>
}
     ac8:	70e2                	ld	ra,56(sp)
     aca:	7442                	ld	s0,48(sp)
     acc:	74a2                	ld	s1,40(sp)
     ace:	7902                	ld	s2,32(sp)
     ad0:	69e2                	ld	s3,24(sp)
     ad2:	6a42                	ld	s4,16(sp)
     ad4:	6aa2                	ld	s5,8(sp)
     ad6:	6b02                	ld	s6,0(sp)
     ad8:	6121                	addi	sp,sp,64
     ada:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     adc:	85da                	mv	a1,s6
     ade:	00006517          	auipc	a0,0x6
     ae2:	b5a50513          	addi	a0,a0,-1190 # 6638 <malloc+0x43e>
     ae6:	00005097          	auipc	ra,0x5
     aea:	65c080e7          	jalr	1628(ra) # 6142 <printf>
    exit(1);
     aee:	4505                	li	a0,1
     af0:	00005097          	auipc	ra,0x5
     af4:	2d2080e7          	jalr	722(ra) # 5dc2 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     af8:	8626                	mv	a2,s1
     afa:	85da                	mv	a1,s6
     afc:	00006517          	auipc	a0,0x6
     b00:	b6c50513          	addi	a0,a0,-1172 # 6668 <malloc+0x46e>
     b04:	00005097          	auipc	ra,0x5
     b08:	63e080e7          	jalr	1598(ra) # 6142 <printf>
      exit(1);
     b0c:	4505                	li	a0,1
     b0e:	00005097          	auipc	ra,0x5
     b12:	2b4080e7          	jalr	692(ra) # 5dc2 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     b16:	8626                	mv	a2,s1
     b18:	85da                	mv	a1,s6
     b1a:	00006517          	auipc	a0,0x6
     b1e:	b8650513          	addi	a0,a0,-1146 # 66a0 <malloc+0x4a6>
     b22:	00005097          	auipc	ra,0x5
     b26:	620080e7          	jalr	1568(ra) # 6142 <printf>
      exit(1);
     b2a:	4505                	li	a0,1
     b2c:	00005097          	auipc	ra,0x5
     b30:	296080e7          	jalr	662(ra) # 5dc2 <exit>
    printf("%s: error: open small failed!\n", s);
     b34:	85da                	mv	a1,s6
     b36:	00006517          	auipc	a0,0x6
     b3a:	b9250513          	addi	a0,a0,-1134 # 66c8 <malloc+0x4ce>
     b3e:	00005097          	auipc	ra,0x5
     b42:	604080e7          	jalr	1540(ra) # 6142 <printf>
    exit(1);
     b46:	4505                	li	a0,1
     b48:	00005097          	auipc	ra,0x5
     b4c:	27a080e7          	jalr	634(ra) # 5dc2 <exit>
    printf("%s: read failed\n", s);
     b50:	85da                	mv	a1,s6
     b52:	00006517          	auipc	a0,0x6
     b56:	b9650513          	addi	a0,a0,-1130 # 66e8 <malloc+0x4ee>
     b5a:	00005097          	auipc	ra,0x5
     b5e:	5e8080e7          	jalr	1512(ra) # 6142 <printf>
    exit(1);
     b62:	4505                	li	a0,1
     b64:	00005097          	auipc	ra,0x5
     b68:	25e080e7          	jalr	606(ra) # 5dc2 <exit>
    printf("%s: unlink small failed\n", s);
     b6c:	85da                	mv	a1,s6
     b6e:	00006517          	auipc	a0,0x6
     b72:	b9250513          	addi	a0,a0,-1134 # 6700 <malloc+0x506>
     b76:	00005097          	auipc	ra,0x5
     b7a:	5cc080e7          	jalr	1484(ra) # 6142 <printf>
    exit(1);
     b7e:	4505                	li	a0,1
     b80:	00005097          	auipc	ra,0x5
     b84:	242080e7          	jalr	578(ra) # 5dc2 <exit>

0000000000000b88 <writebig>:
{
     b88:	7139                	addi	sp,sp,-64
     b8a:	fc06                	sd	ra,56(sp)
     b8c:	f822                	sd	s0,48(sp)
     b8e:	f426                	sd	s1,40(sp)
     b90:	f04a                	sd	s2,32(sp)
     b92:	ec4e                	sd	s3,24(sp)
     b94:	e852                	sd	s4,16(sp)
     b96:	e456                	sd	s5,8(sp)
     b98:	0080                	addi	s0,sp,64
     b9a:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     b9c:	20200593          	li	a1,514
     ba0:	00006517          	auipc	a0,0x6
     ba4:	b8050513          	addi	a0,a0,-1152 # 6720 <malloc+0x526>
     ba8:	00005097          	auipc	ra,0x5
     bac:	25a080e7          	jalr	602(ra) # 5e02 <open>
     bb0:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     bb2:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     bb4:	0000c917          	auipc	s2,0xc
     bb8:	0c490913          	addi	s2,s2,196 # cc78 <buf>
  for(i = 0; i < MAXFILE; i++){
     bbc:	10c00a13          	li	s4,268
  if(fd < 0){
     bc0:	06054c63          	bltz	a0,c38 <writebig+0xb0>
    ((int*)buf)[0] = i;
     bc4:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     bc8:	40000613          	li	a2,1024
     bcc:	85ca                	mv	a1,s2
     bce:	854e                	mv	a0,s3
     bd0:	00005097          	auipc	ra,0x5
     bd4:	212080e7          	jalr	530(ra) # 5de2 <write>
     bd8:	40000793          	li	a5,1024
     bdc:	06f51c63          	bne	a0,a5,c54 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     be0:	2485                	addiw	s1,s1,1
     be2:	ff4491e3          	bne	s1,s4,bc4 <writebig+0x3c>
  close(fd);
     be6:	854e                	mv	a0,s3
     be8:	00005097          	auipc	ra,0x5
     bec:	202080e7          	jalr	514(ra) # 5dea <close>
  fd = open("big", O_RDONLY);
     bf0:	4581                	li	a1,0
     bf2:	00006517          	auipc	a0,0x6
     bf6:	b2e50513          	addi	a0,a0,-1234 # 6720 <malloc+0x526>
     bfa:	00005097          	auipc	ra,0x5
     bfe:	208080e7          	jalr	520(ra) # 5e02 <open>
     c02:	89aa                	mv	s3,a0
  n = 0;
     c04:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     c06:	0000c917          	auipc	s2,0xc
     c0a:	07290913          	addi	s2,s2,114 # cc78 <buf>
  if(fd < 0){
     c0e:	06054263          	bltz	a0,c72 <writebig+0xea>
    i = read(fd, buf, BSIZE);
     c12:	40000613          	li	a2,1024
     c16:	85ca                	mv	a1,s2
     c18:	854e                	mv	a0,s3
     c1a:	00005097          	auipc	ra,0x5
     c1e:	1c0080e7          	jalr	448(ra) # 5dda <read>
    if(i == 0){
     c22:	c535                	beqz	a0,c8e <writebig+0x106>
    } else if(i != BSIZE){
     c24:	40000793          	li	a5,1024
     c28:	0af51f63          	bne	a0,a5,ce6 <writebig+0x15e>
    if(((int*)buf)[0] != n){
     c2c:	00092683          	lw	a3,0(s2)
     c30:	0c969a63          	bne	a3,s1,d04 <writebig+0x17c>
    n++;
     c34:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c36:	bff1                	j	c12 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     c38:	85d6                	mv	a1,s5
     c3a:	00006517          	auipc	a0,0x6
     c3e:	aee50513          	addi	a0,a0,-1298 # 6728 <malloc+0x52e>
     c42:	00005097          	auipc	ra,0x5
     c46:	500080e7          	jalr	1280(ra) # 6142 <printf>
    exit(1);
     c4a:	4505                	li	a0,1
     c4c:	00005097          	auipc	ra,0x5
     c50:	176080e7          	jalr	374(ra) # 5dc2 <exit>
      printf("%s: error: write big file failed\n", s, i);
     c54:	8626                	mv	a2,s1
     c56:	85d6                	mv	a1,s5
     c58:	00006517          	auipc	a0,0x6
     c5c:	af050513          	addi	a0,a0,-1296 # 6748 <malloc+0x54e>
     c60:	00005097          	auipc	ra,0x5
     c64:	4e2080e7          	jalr	1250(ra) # 6142 <printf>
      exit(1);
     c68:	4505                	li	a0,1
     c6a:	00005097          	auipc	ra,0x5
     c6e:	158080e7          	jalr	344(ra) # 5dc2 <exit>
    printf("%s: error: open big failed!\n", s);
     c72:	85d6                	mv	a1,s5
     c74:	00006517          	auipc	a0,0x6
     c78:	afc50513          	addi	a0,a0,-1284 # 6770 <malloc+0x576>
     c7c:	00005097          	auipc	ra,0x5
     c80:	4c6080e7          	jalr	1222(ra) # 6142 <printf>
    exit(1);
     c84:	4505                	li	a0,1
     c86:	00005097          	auipc	ra,0x5
     c8a:	13c080e7          	jalr	316(ra) # 5dc2 <exit>
      if(n == MAXFILE - 1){
     c8e:	10b00793          	li	a5,267
     c92:	02f48a63          	beq	s1,a5,cc6 <writebig+0x13e>
  close(fd);
     c96:	854e                	mv	a0,s3
     c98:	00005097          	auipc	ra,0x5
     c9c:	152080e7          	jalr	338(ra) # 5dea <close>
  if(unlink("big") < 0){
     ca0:	00006517          	auipc	a0,0x6
     ca4:	a8050513          	addi	a0,a0,-1408 # 6720 <malloc+0x526>
     ca8:	00005097          	auipc	ra,0x5
     cac:	16a080e7          	jalr	362(ra) # 5e12 <unlink>
     cb0:	06054963          	bltz	a0,d22 <writebig+0x19a>
}
     cb4:	70e2                	ld	ra,56(sp)
     cb6:	7442                	ld	s0,48(sp)
     cb8:	74a2                	ld	s1,40(sp)
     cba:	7902                	ld	s2,32(sp)
     cbc:	69e2                	ld	s3,24(sp)
     cbe:	6a42                	ld	s4,16(sp)
     cc0:	6aa2                	ld	s5,8(sp)
     cc2:	6121                	addi	sp,sp,64
     cc4:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     cc6:	10b00613          	li	a2,267
     cca:	85d6                	mv	a1,s5
     ccc:	00006517          	auipc	a0,0x6
     cd0:	ac450513          	addi	a0,a0,-1340 # 6790 <malloc+0x596>
     cd4:	00005097          	auipc	ra,0x5
     cd8:	46e080e7          	jalr	1134(ra) # 6142 <printf>
        exit(1);
     cdc:	4505                	li	a0,1
     cde:	00005097          	auipc	ra,0x5
     ce2:	0e4080e7          	jalr	228(ra) # 5dc2 <exit>
      printf("%s: read failed %d\n", s, i);
     ce6:	862a                	mv	a2,a0
     ce8:	85d6                	mv	a1,s5
     cea:	00006517          	auipc	a0,0x6
     cee:	ace50513          	addi	a0,a0,-1330 # 67b8 <malloc+0x5be>
     cf2:	00005097          	auipc	ra,0x5
     cf6:	450080e7          	jalr	1104(ra) # 6142 <printf>
      exit(1);
     cfa:	4505                	li	a0,1
     cfc:	00005097          	auipc	ra,0x5
     d00:	0c6080e7          	jalr	198(ra) # 5dc2 <exit>
      printf("%s: read content of block %d is %d\n", s,
     d04:	8626                	mv	a2,s1
     d06:	85d6                	mv	a1,s5
     d08:	00006517          	auipc	a0,0x6
     d0c:	ac850513          	addi	a0,a0,-1336 # 67d0 <malloc+0x5d6>
     d10:	00005097          	auipc	ra,0x5
     d14:	432080e7          	jalr	1074(ra) # 6142 <printf>
      exit(1);
     d18:	4505                	li	a0,1
     d1a:	00005097          	auipc	ra,0x5
     d1e:	0a8080e7          	jalr	168(ra) # 5dc2 <exit>
    printf("%s: unlink big failed\n", s);
     d22:	85d6                	mv	a1,s5
     d24:	00006517          	auipc	a0,0x6
     d28:	ad450513          	addi	a0,a0,-1324 # 67f8 <malloc+0x5fe>
     d2c:	00005097          	auipc	ra,0x5
     d30:	416080e7          	jalr	1046(ra) # 6142 <printf>
    exit(1);
     d34:	4505                	li	a0,1
     d36:	00005097          	auipc	ra,0x5
     d3a:	08c080e7          	jalr	140(ra) # 5dc2 <exit>

0000000000000d3e <unlinkread>:
{
     d3e:	7179                	addi	sp,sp,-48
     d40:	f406                	sd	ra,40(sp)
     d42:	f022                	sd	s0,32(sp)
     d44:	ec26                	sd	s1,24(sp)
     d46:	e84a                	sd	s2,16(sp)
     d48:	e44e                	sd	s3,8(sp)
     d4a:	1800                	addi	s0,sp,48
     d4c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     d4e:	20200593          	li	a1,514
     d52:	00006517          	auipc	a0,0x6
     d56:	abe50513          	addi	a0,a0,-1346 # 6810 <malloc+0x616>
     d5a:	00005097          	auipc	ra,0x5
     d5e:	0a8080e7          	jalr	168(ra) # 5e02 <open>
  if(fd < 0){
     d62:	0e054563          	bltz	a0,e4c <unlinkread+0x10e>
     d66:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d68:	4615                	li	a2,5
     d6a:	00006597          	auipc	a1,0x6
     d6e:	ad658593          	addi	a1,a1,-1322 # 6840 <malloc+0x646>
     d72:	00005097          	auipc	ra,0x5
     d76:	070080e7          	jalr	112(ra) # 5de2 <write>
  close(fd);
     d7a:	8526                	mv	a0,s1
     d7c:	00005097          	auipc	ra,0x5
     d80:	06e080e7          	jalr	110(ra) # 5dea <close>
  fd = open("unlinkread", O_RDWR);
     d84:	4589                	li	a1,2
     d86:	00006517          	auipc	a0,0x6
     d8a:	a8a50513          	addi	a0,a0,-1398 # 6810 <malloc+0x616>
     d8e:	00005097          	auipc	ra,0x5
     d92:	074080e7          	jalr	116(ra) # 5e02 <open>
     d96:	84aa                	mv	s1,a0
  if(fd < 0){
     d98:	0c054863          	bltz	a0,e68 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     d9c:	00006517          	auipc	a0,0x6
     da0:	a7450513          	addi	a0,a0,-1420 # 6810 <malloc+0x616>
     da4:	00005097          	auipc	ra,0x5
     da8:	06e080e7          	jalr	110(ra) # 5e12 <unlink>
     dac:	ed61                	bnez	a0,e84 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     dae:	20200593          	li	a1,514
     db2:	00006517          	auipc	a0,0x6
     db6:	a5e50513          	addi	a0,a0,-1442 # 6810 <malloc+0x616>
     dba:	00005097          	auipc	ra,0x5
     dbe:	048080e7          	jalr	72(ra) # 5e02 <open>
     dc2:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     dc4:	460d                	li	a2,3
     dc6:	00006597          	auipc	a1,0x6
     dca:	ac258593          	addi	a1,a1,-1342 # 6888 <malloc+0x68e>
     dce:	00005097          	auipc	ra,0x5
     dd2:	014080e7          	jalr	20(ra) # 5de2 <write>
  close(fd1);
     dd6:	854a                	mv	a0,s2
     dd8:	00005097          	auipc	ra,0x5
     ddc:	012080e7          	jalr	18(ra) # 5dea <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     de0:	660d                	lui	a2,0x3
     de2:	0000c597          	auipc	a1,0xc
     de6:	e9658593          	addi	a1,a1,-362 # cc78 <buf>
     dea:	8526                	mv	a0,s1
     dec:	00005097          	auipc	ra,0x5
     df0:	fee080e7          	jalr	-18(ra) # 5dda <read>
     df4:	4795                	li	a5,5
     df6:	0af51563          	bne	a0,a5,ea0 <unlinkread+0x162>
  if(buf[0] != 'h'){
     dfa:	0000c717          	auipc	a4,0xc
     dfe:	e7e74703          	lbu	a4,-386(a4) # cc78 <buf>
     e02:	06800793          	li	a5,104
     e06:	0af71b63          	bne	a4,a5,ebc <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     e0a:	4629                	li	a2,10
     e0c:	0000c597          	auipc	a1,0xc
     e10:	e6c58593          	addi	a1,a1,-404 # cc78 <buf>
     e14:	8526                	mv	a0,s1
     e16:	00005097          	auipc	ra,0x5
     e1a:	fcc080e7          	jalr	-52(ra) # 5de2 <write>
     e1e:	47a9                	li	a5,10
     e20:	0af51c63          	bne	a0,a5,ed8 <unlinkread+0x19a>
  close(fd);
     e24:	8526                	mv	a0,s1
     e26:	00005097          	auipc	ra,0x5
     e2a:	fc4080e7          	jalr	-60(ra) # 5dea <close>
  unlink("unlinkread");
     e2e:	00006517          	auipc	a0,0x6
     e32:	9e250513          	addi	a0,a0,-1566 # 6810 <malloc+0x616>
     e36:	00005097          	auipc	ra,0x5
     e3a:	fdc080e7          	jalr	-36(ra) # 5e12 <unlink>
}
     e3e:	70a2                	ld	ra,40(sp)
     e40:	7402                	ld	s0,32(sp)
     e42:	64e2                	ld	s1,24(sp)
     e44:	6942                	ld	s2,16(sp)
     e46:	69a2                	ld	s3,8(sp)
     e48:	6145                	addi	sp,sp,48
     e4a:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     e4c:	85ce                	mv	a1,s3
     e4e:	00006517          	auipc	a0,0x6
     e52:	9d250513          	addi	a0,a0,-1582 # 6820 <malloc+0x626>
     e56:	00005097          	auipc	ra,0x5
     e5a:	2ec080e7          	jalr	748(ra) # 6142 <printf>
    exit(1);
     e5e:	4505                	li	a0,1
     e60:	00005097          	auipc	ra,0x5
     e64:	f62080e7          	jalr	-158(ra) # 5dc2 <exit>
    printf("%s: open unlinkread failed\n", s);
     e68:	85ce                	mv	a1,s3
     e6a:	00006517          	auipc	a0,0x6
     e6e:	9de50513          	addi	a0,a0,-1570 # 6848 <malloc+0x64e>
     e72:	00005097          	auipc	ra,0x5
     e76:	2d0080e7          	jalr	720(ra) # 6142 <printf>
    exit(1);
     e7a:	4505                	li	a0,1
     e7c:	00005097          	auipc	ra,0x5
     e80:	f46080e7          	jalr	-186(ra) # 5dc2 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     e84:	85ce                	mv	a1,s3
     e86:	00006517          	auipc	a0,0x6
     e8a:	9e250513          	addi	a0,a0,-1566 # 6868 <malloc+0x66e>
     e8e:	00005097          	auipc	ra,0x5
     e92:	2b4080e7          	jalr	692(ra) # 6142 <printf>
    exit(1);
     e96:	4505                	li	a0,1
     e98:	00005097          	auipc	ra,0x5
     e9c:	f2a080e7          	jalr	-214(ra) # 5dc2 <exit>
    printf("%s: unlinkread read failed", s);
     ea0:	85ce                	mv	a1,s3
     ea2:	00006517          	auipc	a0,0x6
     ea6:	9ee50513          	addi	a0,a0,-1554 # 6890 <malloc+0x696>
     eaa:	00005097          	auipc	ra,0x5
     eae:	298080e7          	jalr	664(ra) # 6142 <printf>
    exit(1);
     eb2:	4505                	li	a0,1
     eb4:	00005097          	auipc	ra,0x5
     eb8:	f0e080e7          	jalr	-242(ra) # 5dc2 <exit>
    printf("%s: unlinkread wrong data\n", s);
     ebc:	85ce                	mv	a1,s3
     ebe:	00006517          	auipc	a0,0x6
     ec2:	9f250513          	addi	a0,a0,-1550 # 68b0 <malloc+0x6b6>
     ec6:	00005097          	auipc	ra,0x5
     eca:	27c080e7          	jalr	636(ra) # 6142 <printf>
    exit(1);
     ece:	4505                	li	a0,1
     ed0:	00005097          	auipc	ra,0x5
     ed4:	ef2080e7          	jalr	-270(ra) # 5dc2 <exit>
    printf("%s: unlinkread write failed\n", s);
     ed8:	85ce                	mv	a1,s3
     eda:	00006517          	auipc	a0,0x6
     ede:	9f650513          	addi	a0,a0,-1546 # 68d0 <malloc+0x6d6>
     ee2:	00005097          	auipc	ra,0x5
     ee6:	260080e7          	jalr	608(ra) # 6142 <printf>
    exit(1);
     eea:	4505                	li	a0,1
     eec:	00005097          	auipc	ra,0x5
     ef0:	ed6080e7          	jalr	-298(ra) # 5dc2 <exit>

0000000000000ef4 <linktest>:
{
     ef4:	1101                	addi	sp,sp,-32
     ef6:	ec06                	sd	ra,24(sp)
     ef8:	e822                	sd	s0,16(sp)
     efa:	e426                	sd	s1,8(sp)
     efc:	e04a                	sd	s2,0(sp)
     efe:	1000                	addi	s0,sp,32
     f00:	892a                	mv	s2,a0
  unlink("lf1");
     f02:	00006517          	auipc	a0,0x6
     f06:	9ee50513          	addi	a0,a0,-1554 # 68f0 <malloc+0x6f6>
     f0a:	00005097          	auipc	ra,0x5
     f0e:	f08080e7          	jalr	-248(ra) # 5e12 <unlink>
  unlink("lf2");
     f12:	00006517          	auipc	a0,0x6
     f16:	9e650513          	addi	a0,a0,-1562 # 68f8 <malloc+0x6fe>
     f1a:	00005097          	auipc	ra,0x5
     f1e:	ef8080e7          	jalr	-264(ra) # 5e12 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     f22:	20200593          	li	a1,514
     f26:	00006517          	auipc	a0,0x6
     f2a:	9ca50513          	addi	a0,a0,-1590 # 68f0 <malloc+0x6f6>
     f2e:	00005097          	auipc	ra,0x5
     f32:	ed4080e7          	jalr	-300(ra) # 5e02 <open>
  if(fd < 0){
     f36:	10054763          	bltz	a0,1044 <linktest+0x150>
     f3a:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     f3c:	4615                	li	a2,5
     f3e:	00006597          	auipc	a1,0x6
     f42:	90258593          	addi	a1,a1,-1790 # 6840 <malloc+0x646>
     f46:	00005097          	auipc	ra,0x5
     f4a:	e9c080e7          	jalr	-356(ra) # 5de2 <write>
     f4e:	4795                	li	a5,5
     f50:	10f51863          	bne	a0,a5,1060 <linktest+0x16c>
  close(fd);
     f54:	8526                	mv	a0,s1
     f56:	00005097          	auipc	ra,0x5
     f5a:	e94080e7          	jalr	-364(ra) # 5dea <close>
  if(link("lf1", "lf2") < 0){
     f5e:	00006597          	auipc	a1,0x6
     f62:	99a58593          	addi	a1,a1,-1638 # 68f8 <malloc+0x6fe>
     f66:	00006517          	auipc	a0,0x6
     f6a:	98a50513          	addi	a0,a0,-1654 # 68f0 <malloc+0x6f6>
     f6e:	00005097          	auipc	ra,0x5
     f72:	eb4080e7          	jalr	-332(ra) # 5e22 <link>
     f76:	10054363          	bltz	a0,107c <linktest+0x188>
  unlink("lf1");
     f7a:	00006517          	auipc	a0,0x6
     f7e:	97650513          	addi	a0,a0,-1674 # 68f0 <malloc+0x6f6>
     f82:	00005097          	auipc	ra,0x5
     f86:	e90080e7          	jalr	-368(ra) # 5e12 <unlink>
  if(open("lf1", 0) >= 0){
     f8a:	4581                	li	a1,0
     f8c:	00006517          	auipc	a0,0x6
     f90:	96450513          	addi	a0,a0,-1692 # 68f0 <malloc+0x6f6>
     f94:	00005097          	auipc	ra,0x5
     f98:	e6e080e7          	jalr	-402(ra) # 5e02 <open>
     f9c:	0e055e63          	bgez	a0,1098 <linktest+0x1a4>
  fd = open("lf2", 0);
     fa0:	4581                	li	a1,0
     fa2:	00006517          	auipc	a0,0x6
     fa6:	95650513          	addi	a0,a0,-1706 # 68f8 <malloc+0x6fe>
     faa:	00005097          	auipc	ra,0x5
     fae:	e58080e7          	jalr	-424(ra) # 5e02 <open>
     fb2:	84aa                	mv	s1,a0
  if(fd < 0){
     fb4:	10054063          	bltz	a0,10b4 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     fb8:	660d                	lui	a2,0x3
     fba:	0000c597          	auipc	a1,0xc
     fbe:	cbe58593          	addi	a1,a1,-834 # cc78 <buf>
     fc2:	00005097          	auipc	ra,0x5
     fc6:	e18080e7          	jalr	-488(ra) # 5dda <read>
     fca:	4795                	li	a5,5
     fcc:	10f51263          	bne	a0,a5,10d0 <linktest+0x1dc>
  close(fd);
     fd0:	8526                	mv	a0,s1
     fd2:	00005097          	auipc	ra,0x5
     fd6:	e18080e7          	jalr	-488(ra) # 5dea <close>
  if(link("lf2", "lf2") >= 0){
     fda:	00006597          	auipc	a1,0x6
     fde:	91e58593          	addi	a1,a1,-1762 # 68f8 <malloc+0x6fe>
     fe2:	852e                	mv	a0,a1
     fe4:	00005097          	auipc	ra,0x5
     fe8:	e3e080e7          	jalr	-450(ra) # 5e22 <link>
     fec:	10055063          	bgez	a0,10ec <linktest+0x1f8>
  unlink("lf2");
     ff0:	00006517          	auipc	a0,0x6
     ff4:	90850513          	addi	a0,a0,-1784 # 68f8 <malloc+0x6fe>
     ff8:	00005097          	auipc	ra,0x5
     ffc:	e1a080e7          	jalr	-486(ra) # 5e12 <unlink>
  if(link("lf2", "lf1") >= 0){
    1000:	00006597          	auipc	a1,0x6
    1004:	8f058593          	addi	a1,a1,-1808 # 68f0 <malloc+0x6f6>
    1008:	00006517          	auipc	a0,0x6
    100c:	8f050513          	addi	a0,a0,-1808 # 68f8 <malloc+0x6fe>
    1010:	00005097          	auipc	ra,0x5
    1014:	e12080e7          	jalr	-494(ra) # 5e22 <link>
    1018:	0e055863          	bgez	a0,1108 <linktest+0x214>
  if(link(".", "lf1") >= 0){
    101c:	00006597          	auipc	a1,0x6
    1020:	8d458593          	addi	a1,a1,-1836 # 68f0 <malloc+0x6f6>
    1024:	00006517          	auipc	a0,0x6
    1028:	9dc50513          	addi	a0,a0,-1572 # 6a00 <malloc+0x806>
    102c:	00005097          	auipc	ra,0x5
    1030:	df6080e7          	jalr	-522(ra) # 5e22 <link>
    1034:	0e055863          	bgez	a0,1124 <linktest+0x230>
}
    1038:	60e2                	ld	ra,24(sp)
    103a:	6442                	ld	s0,16(sp)
    103c:	64a2                	ld	s1,8(sp)
    103e:	6902                	ld	s2,0(sp)
    1040:	6105                	addi	sp,sp,32
    1042:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    1044:	85ca                	mv	a1,s2
    1046:	00006517          	auipc	a0,0x6
    104a:	8ba50513          	addi	a0,a0,-1862 # 6900 <malloc+0x706>
    104e:	00005097          	auipc	ra,0x5
    1052:	0f4080e7          	jalr	244(ra) # 6142 <printf>
    exit(1);
    1056:	4505                	li	a0,1
    1058:	00005097          	auipc	ra,0x5
    105c:	d6a080e7          	jalr	-662(ra) # 5dc2 <exit>
    printf("%s: write lf1 failed\n", s);
    1060:	85ca                	mv	a1,s2
    1062:	00006517          	auipc	a0,0x6
    1066:	8b650513          	addi	a0,a0,-1866 # 6918 <malloc+0x71e>
    106a:	00005097          	auipc	ra,0x5
    106e:	0d8080e7          	jalr	216(ra) # 6142 <printf>
    exit(1);
    1072:	4505                	li	a0,1
    1074:	00005097          	auipc	ra,0x5
    1078:	d4e080e7          	jalr	-690(ra) # 5dc2 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    107c:	85ca                	mv	a1,s2
    107e:	00006517          	auipc	a0,0x6
    1082:	8b250513          	addi	a0,a0,-1870 # 6930 <malloc+0x736>
    1086:	00005097          	auipc	ra,0x5
    108a:	0bc080e7          	jalr	188(ra) # 6142 <printf>
    exit(1);
    108e:	4505                	li	a0,1
    1090:	00005097          	auipc	ra,0x5
    1094:	d32080e7          	jalr	-718(ra) # 5dc2 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    1098:	85ca                	mv	a1,s2
    109a:	00006517          	auipc	a0,0x6
    109e:	8b650513          	addi	a0,a0,-1866 # 6950 <malloc+0x756>
    10a2:	00005097          	auipc	ra,0x5
    10a6:	0a0080e7          	jalr	160(ra) # 6142 <printf>
    exit(1);
    10aa:	4505                	li	a0,1
    10ac:	00005097          	auipc	ra,0x5
    10b0:	d16080e7          	jalr	-746(ra) # 5dc2 <exit>
    printf("%s: open lf2 failed\n", s);
    10b4:	85ca                	mv	a1,s2
    10b6:	00006517          	auipc	a0,0x6
    10ba:	8ca50513          	addi	a0,a0,-1846 # 6980 <malloc+0x786>
    10be:	00005097          	auipc	ra,0x5
    10c2:	084080e7          	jalr	132(ra) # 6142 <printf>
    exit(1);
    10c6:	4505                	li	a0,1
    10c8:	00005097          	auipc	ra,0x5
    10cc:	cfa080e7          	jalr	-774(ra) # 5dc2 <exit>
    printf("%s: read lf2 failed\n", s);
    10d0:	85ca                	mv	a1,s2
    10d2:	00006517          	auipc	a0,0x6
    10d6:	8c650513          	addi	a0,a0,-1850 # 6998 <malloc+0x79e>
    10da:	00005097          	auipc	ra,0x5
    10de:	068080e7          	jalr	104(ra) # 6142 <printf>
    exit(1);
    10e2:	4505                	li	a0,1
    10e4:	00005097          	auipc	ra,0x5
    10e8:	cde080e7          	jalr	-802(ra) # 5dc2 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    10ec:	85ca                	mv	a1,s2
    10ee:	00006517          	auipc	a0,0x6
    10f2:	8c250513          	addi	a0,a0,-1854 # 69b0 <malloc+0x7b6>
    10f6:	00005097          	auipc	ra,0x5
    10fa:	04c080e7          	jalr	76(ra) # 6142 <printf>
    exit(1);
    10fe:	4505                	li	a0,1
    1100:	00005097          	auipc	ra,0x5
    1104:	cc2080e7          	jalr	-830(ra) # 5dc2 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    1108:	85ca                	mv	a1,s2
    110a:	00006517          	auipc	a0,0x6
    110e:	8ce50513          	addi	a0,a0,-1842 # 69d8 <malloc+0x7de>
    1112:	00005097          	auipc	ra,0x5
    1116:	030080e7          	jalr	48(ra) # 6142 <printf>
    exit(1);
    111a:	4505                	li	a0,1
    111c:	00005097          	auipc	ra,0x5
    1120:	ca6080e7          	jalr	-858(ra) # 5dc2 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    1124:	85ca                	mv	a1,s2
    1126:	00006517          	auipc	a0,0x6
    112a:	8e250513          	addi	a0,a0,-1822 # 6a08 <malloc+0x80e>
    112e:	00005097          	auipc	ra,0x5
    1132:	014080e7          	jalr	20(ra) # 6142 <printf>
    exit(1);
    1136:	4505                	li	a0,1
    1138:	00005097          	auipc	ra,0x5
    113c:	c8a080e7          	jalr	-886(ra) # 5dc2 <exit>

0000000000001140 <validatetest>:
{
    1140:	7139                	addi	sp,sp,-64
    1142:	fc06                	sd	ra,56(sp)
    1144:	f822                	sd	s0,48(sp)
    1146:	f426                	sd	s1,40(sp)
    1148:	f04a                	sd	s2,32(sp)
    114a:	ec4e                	sd	s3,24(sp)
    114c:	e852                	sd	s4,16(sp)
    114e:	e456                	sd	s5,8(sp)
    1150:	e05a                	sd	s6,0(sp)
    1152:	0080                	addi	s0,sp,64
    1154:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1156:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    1158:	00006997          	auipc	s3,0x6
    115c:	8d098993          	addi	s3,s3,-1840 # 6a28 <malloc+0x82e>
    1160:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1162:	6a85                	lui	s5,0x1
    1164:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    1168:	85a6                	mv	a1,s1
    116a:	854e                	mv	a0,s3
    116c:	00005097          	auipc	ra,0x5
    1170:	cb6080e7          	jalr	-842(ra) # 5e22 <link>
    1174:	01251f63          	bne	a0,s2,1192 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1178:	94d6                	add	s1,s1,s5
    117a:	ff4497e3          	bne	s1,s4,1168 <validatetest+0x28>
}
    117e:	70e2                	ld	ra,56(sp)
    1180:	7442                	ld	s0,48(sp)
    1182:	74a2                	ld	s1,40(sp)
    1184:	7902                	ld	s2,32(sp)
    1186:	69e2                	ld	s3,24(sp)
    1188:	6a42                	ld	s4,16(sp)
    118a:	6aa2                	ld	s5,8(sp)
    118c:	6b02                	ld	s6,0(sp)
    118e:	6121                	addi	sp,sp,64
    1190:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1192:	85da                	mv	a1,s6
    1194:	00006517          	auipc	a0,0x6
    1198:	8a450513          	addi	a0,a0,-1884 # 6a38 <malloc+0x83e>
    119c:	00005097          	auipc	ra,0x5
    11a0:	fa6080e7          	jalr	-90(ra) # 6142 <printf>
      exit(1);
    11a4:	4505                	li	a0,1
    11a6:	00005097          	auipc	ra,0x5
    11aa:	c1c080e7          	jalr	-996(ra) # 5dc2 <exit>

00000000000011ae <bigdir>:
{
    11ae:	715d                	addi	sp,sp,-80
    11b0:	e486                	sd	ra,72(sp)
    11b2:	e0a2                	sd	s0,64(sp)
    11b4:	fc26                	sd	s1,56(sp)
    11b6:	f84a                	sd	s2,48(sp)
    11b8:	f44e                	sd	s3,40(sp)
    11ba:	f052                	sd	s4,32(sp)
    11bc:	ec56                	sd	s5,24(sp)
    11be:	e85a                	sd	s6,16(sp)
    11c0:	0880                	addi	s0,sp,80
    11c2:	89aa                	mv	s3,a0
  unlink("bd");
    11c4:	00006517          	auipc	a0,0x6
    11c8:	89450513          	addi	a0,a0,-1900 # 6a58 <malloc+0x85e>
    11cc:	00005097          	auipc	ra,0x5
    11d0:	c46080e7          	jalr	-954(ra) # 5e12 <unlink>
  fd = open("bd", O_CREATE);
    11d4:	20000593          	li	a1,512
    11d8:	00006517          	auipc	a0,0x6
    11dc:	88050513          	addi	a0,a0,-1920 # 6a58 <malloc+0x85e>
    11e0:	00005097          	auipc	ra,0x5
    11e4:	c22080e7          	jalr	-990(ra) # 5e02 <open>
  if(fd < 0){
    11e8:	0c054963          	bltz	a0,12ba <bigdir+0x10c>
  close(fd);
    11ec:	00005097          	auipc	ra,0x5
    11f0:	bfe080e7          	jalr	-1026(ra) # 5dea <close>
  for(i = 0; i < N; i++){
    11f4:	4901                	li	s2,0
    name[0] = 'x';
    11f6:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    11fa:	00006a17          	auipc	s4,0x6
    11fe:	85ea0a13          	addi	s4,s4,-1954 # 6a58 <malloc+0x85e>
  for(i = 0; i < N; i++){
    1202:	1f400b13          	li	s6,500
    name[0] = 'x';
    1206:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    120a:	41f9571b          	sraiw	a4,s2,0x1f
    120e:	01a7571b          	srliw	a4,a4,0x1a
    1212:	012707bb          	addw	a5,a4,s2
    1216:	4067d69b          	sraiw	a3,a5,0x6
    121a:	0306869b          	addiw	a3,a3,48
    121e:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1222:	03f7f793          	andi	a5,a5,63
    1226:	9f99                	subw	a5,a5,a4
    1228:	0307879b          	addiw	a5,a5,48
    122c:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1230:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    1234:	fb040593          	addi	a1,s0,-80
    1238:	8552                	mv	a0,s4
    123a:	00005097          	auipc	ra,0x5
    123e:	be8080e7          	jalr	-1048(ra) # 5e22 <link>
    1242:	84aa                	mv	s1,a0
    1244:	e949                	bnez	a0,12d6 <bigdir+0x128>
  for(i = 0; i < N; i++){
    1246:	2905                	addiw	s2,s2,1
    1248:	fb691fe3          	bne	s2,s6,1206 <bigdir+0x58>
  unlink("bd");
    124c:	00006517          	auipc	a0,0x6
    1250:	80c50513          	addi	a0,a0,-2036 # 6a58 <malloc+0x85e>
    1254:	00005097          	auipc	ra,0x5
    1258:	bbe080e7          	jalr	-1090(ra) # 5e12 <unlink>
    name[0] = 'x';
    125c:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1260:	1f400a13          	li	s4,500
    name[0] = 'x';
    1264:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    1268:	41f4d71b          	sraiw	a4,s1,0x1f
    126c:	01a7571b          	srliw	a4,a4,0x1a
    1270:	009707bb          	addw	a5,a4,s1
    1274:	4067d69b          	sraiw	a3,a5,0x6
    1278:	0306869b          	addiw	a3,a3,48
    127c:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1280:	03f7f793          	andi	a5,a5,63
    1284:	9f99                	subw	a5,a5,a4
    1286:	0307879b          	addiw	a5,a5,48
    128a:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    128e:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1292:	fb040513          	addi	a0,s0,-80
    1296:	00005097          	auipc	ra,0x5
    129a:	b7c080e7          	jalr	-1156(ra) # 5e12 <unlink>
    129e:	ed21                	bnez	a0,12f6 <bigdir+0x148>
  for(i = 0; i < N; i++){
    12a0:	2485                	addiw	s1,s1,1
    12a2:	fd4491e3          	bne	s1,s4,1264 <bigdir+0xb6>
}
    12a6:	60a6                	ld	ra,72(sp)
    12a8:	6406                	ld	s0,64(sp)
    12aa:	74e2                	ld	s1,56(sp)
    12ac:	7942                	ld	s2,48(sp)
    12ae:	79a2                	ld	s3,40(sp)
    12b0:	7a02                	ld	s4,32(sp)
    12b2:	6ae2                	ld	s5,24(sp)
    12b4:	6b42                	ld	s6,16(sp)
    12b6:	6161                	addi	sp,sp,80
    12b8:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    12ba:	85ce                	mv	a1,s3
    12bc:	00005517          	auipc	a0,0x5
    12c0:	7a450513          	addi	a0,a0,1956 # 6a60 <malloc+0x866>
    12c4:	00005097          	auipc	ra,0x5
    12c8:	e7e080e7          	jalr	-386(ra) # 6142 <printf>
    exit(1);
    12cc:	4505                	li	a0,1
    12ce:	00005097          	auipc	ra,0x5
    12d2:	af4080e7          	jalr	-1292(ra) # 5dc2 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    12d6:	fb040613          	addi	a2,s0,-80
    12da:	85ce                	mv	a1,s3
    12dc:	00005517          	auipc	a0,0x5
    12e0:	7a450513          	addi	a0,a0,1956 # 6a80 <malloc+0x886>
    12e4:	00005097          	auipc	ra,0x5
    12e8:	e5e080e7          	jalr	-418(ra) # 6142 <printf>
      exit(1);
    12ec:	4505                	li	a0,1
    12ee:	00005097          	auipc	ra,0x5
    12f2:	ad4080e7          	jalr	-1324(ra) # 5dc2 <exit>
      printf("%s: bigdir unlink failed", s);
    12f6:	85ce                	mv	a1,s3
    12f8:	00005517          	auipc	a0,0x5
    12fc:	7a850513          	addi	a0,a0,1960 # 6aa0 <malloc+0x8a6>
    1300:	00005097          	auipc	ra,0x5
    1304:	e42080e7          	jalr	-446(ra) # 6142 <printf>
      exit(1);
    1308:	4505                	li	a0,1
    130a:	00005097          	auipc	ra,0x5
    130e:	ab8080e7          	jalr	-1352(ra) # 5dc2 <exit>

0000000000001312 <pgbug>:
{
    1312:	7179                	addi	sp,sp,-48
    1314:	f406                	sd	ra,40(sp)
    1316:	f022                	sd	s0,32(sp)
    1318:	ec26                	sd	s1,24(sp)
    131a:	1800                	addi	s0,sp,48
  argv[0] = 0;
    131c:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1320:	00008497          	auipc	s1,0x8
    1324:	ce048493          	addi	s1,s1,-800 # 9000 <big>
    1328:	fd840593          	addi	a1,s0,-40
    132c:	6088                	ld	a0,0(s1)
    132e:	00005097          	auipc	ra,0x5
    1332:	acc080e7          	jalr	-1332(ra) # 5dfa <exec>
  pipe(big);
    1336:	6088                	ld	a0,0(s1)
    1338:	00005097          	auipc	ra,0x5
    133c:	a9a080e7          	jalr	-1382(ra) # 5dd2 <pipe>
  exit(0);
    1340:	4501                	li	a0,0
    1342:	00005097          	auipc	ra,0x5
    1346:	a80080e7          	jalr	-1408(ra) # 5dc2 <exit>

000000000000134a <badarg>:
{
    134a:	7139                	addi	sp,sp,-64
    134c:	fc06                	sd	ra,56(sp)
    134e:	f822                	sd	s0,48(sp)
    1350:	f426                	sd	s1,40(sp)
    1352:	f04a                	sd	s2,32(sp)
    1354:	ec4e                	sd	s3,24(sp)
    1356:	0080                	addi	s0,sp,64
    1358:	64b1                	lui	s1,0xc
    135a:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    135e:	597d                	li	s2,-1
    1360:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    1364:	00005997          	auipc	s3,0x5
    1368:	fb498993          	addi	s3,s3,-76 # 6318 <malloc+0x11e>
    argv[0] = (char*)0xffffffff;
    136c:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1370:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1374:	fc040593          	addi	a1,s0,-64
    1378:	854e                	mv	a0,s3
    137a:	00005097          	auipc	ra,0x5
    137e:	a80080e7          	jalr	-1408(ra) # 5dfa <exec>
  for(int i = 0; i < 50000; i++){
    1382:	34fd                	addiw	s1,s1,-1
    1384:	f4e5                	bnez	s1,136c <badarg+0x22>
  exit(0);
    1386:	4501                	li	a0,0
    1388:	00005097          	auipc	ra,0x5
    138c:	a3a080e7          	jalr	-1478(ra) # 5dc2 <exit>

0000000000001390 <copyinstr2>:
{
    1390:	7155                	addi	sp,sp,-208
    1392:	e586                	sd	ra,200(sp)
    1394:	e1a2                	sd	s0,192(sp)
    1396:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    1398:	f6840793          	addi	a5,s0,-152
    139c:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    13a0:	07800713          	li	a4,120
    13a4:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    13a8:	0785                	addi	a5,a5,1
    13aa:	fed79de3          	bne	a5,a3,13a4 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    13ae:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    13b2:	f6840513          	addi	a0,s0,-152
    13b6:	00005097          	auipc	ra,0x5
    13ba:	a5c080e7          	jalr	-1444(ra) # 5e12 <unlink>
  if(ret != -1){
    13be:	57fd                	li	a5,-1
    13c0:	0ef51063          	bne	a0,a5,14a0 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    13c4:	20100593          	li	a1,513
    13c8:	f6840513          	addi	a0,s0,-152
    13cc:	00005097          	auipc	ra,0x5
    13d0:	a36080e7          	jalr	-1482(ra) # 5e02 <open>
  if(fd != -1){
    13d4:	57fd                	li	a5,-1
    13d6:	0ef51563          	bne	a0,a5,14c0 <copyinstr2+0x130>
  ret = link(b, b);
    13da:	f6840593          	addi	a1,s0,-152
    13de:	852e                	mv	a0,a1
    13e0:	00005097          	auipc	ra,0x5
    13e4:	a42080e7          	jalr	-1470(ra) # 5e22 <link>
  if(ret != -1){
    13e8:	57fd                	li	a5,-1
    13ea:	0ef51b63          	bne	a0,a5,14e0 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    13ee:	00007797          	auipc	a5,0x7
    13f2:	90a78793          	addi	a5,a5,-1782 # 7cf8 <malloc+0x1afe>
    13f6:	f4f43c23          	sd	a5,-168(s0)
    13fa:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    13fe:	f5840593          	addi	a1,s0,-168
    1402:	f6840513          	addi	a0,s0,-152
    1406:	00005097          	auipc	ra,0x5
    140a:	9f4080e7          	jalr	-1548(ra) # 5dfa <exec>
  if(ret != -1){
    140e:	57fd                	li	a5,-1
    1410:	0ef51963          	bne	a0,a5,1502 <copyinstr2+0x172>
  int pid = fork();
    1414:	00005097          	auipc	ra,0x5
    1418:	9a6080e7          	jalr	-1626(ra) # 5dba <fork>
  if(pid < 0){
    141c:	10054363          	bltz	a0,1522 <copyinstr2+0x192>
  if(pid == 0){
    1420:	12051463          	bnez	a0,1548 <copyinstr2+0x1b8>
    1424:	00008797          	auipc	a5,0x8
    1428:	13c78793          	addi	a5,a5,316 # 9560 <big.0>
    142c:	00009697          	auipc	a3,0x9
    1430:	13468693          	addi	a3,a3,308 # a560 <big.0+0x1000>
      big[i] = 'x';
    1434:	07800713          	li	a4,120
    1438:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    143c:	0785                	addi	a5,a5,1
    143e:	fed79de3          	bne	a5,a3,1438 <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    1442:	00009797          	auipc	a5,0x9
    1446:	10078f23          	sb	zero,286(a5) # a560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    144a:	00007797          	auipc	a5,0x7
    144e:	2ee78793          	addi	a5,a5,750 # 8738 <malloc+0x253e>
    1452:	6390                	ld	a2,0(a5)
    1454:	6794                	ld	a3,8(a5)
    1456:	6b98                	ld	a4,16(a5)
    1458:	6f9c                	ld	a5,24(a5)
    145a:	f2c43823          	sd	a2,-208(s0)
    145e:	f2d43c23          	sd	a3,-200(s0)
    1462:	f4e43023          	sd	a4,-192(s0)
    1466:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    146a:	f3040593          	addi	a1,s0,-208
    146e:	00005517          	auipc	a0,0x5
    1472:	eaa50513          	addi	a0,a0,-342 # 6318 <malloc+0x11e>
    1476:	00005097          	auipc	ra,0x5
    147a:	984080e7          	jalr	-1660(ra) # 5dfa <exec>
    if(ret != -1){
    147e:	57fd                	li	a5,-1
    1480:	0af50e63          	beq	a0,a5,153c <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    1484:	55fd                	li	a1,-1
    1486:	00005517          	auipc	a0,0x5
    148a:	6c250513          	addi	a0,a0,1730 # 6b48 <malloc+0x94e>
    148e:	00005097          	auipc	ra,0x5
    1492:	cb4080e7          	jalr	-844(ra) # 6142 <printf>
      exit(1);
    1496:	4505                	li	a0,1
    1498:	00005097          	auipc	ra,0x5
    149c:	92a080e7          	jalr	-1750(ra) # 5dc2 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    14a0:	862a                	mv	a2,a0
    14a2:	f6840593          	addi	a1,s0,-152
    14a6:	00005517          	auipc	a0,0x5
    14aa:	61a50513          	addi	a0,a0,1562 # 6ac0 <malloc+0x8c6>
    14ae:	00005097          	auipc	ra,0x5
    14b2:	c94080e7          	jalr	-876(ra) # 6142 <printf>
    exit(1);
    14b6:	4505                	li	a0,1
    14b8:	00005097          	auipc	ra,0x5
    14bc:	90a080e7          	jalr	-1782(ra) # 5dc2 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    14c0:	862a                	mv	a2,a0
    14c2:	f6840593          	addi	a1,s0,-152
    14c6:	00005517          	auipc	a0,0x5
    14ca:	61a50513          	addi	a0,a0,1562 # 6ae0 <malloc+0x8e6>
    14ce:	00005097          	auipc	ra,0x5
    14d2:	c74080e7          	jalr	-908(ra) # 6142 <printf>
    exit(1);
    14d6:	4505                	li	a0,1
    14d8:	00005097          	auipc	ra,0x5
    14dc:	8ea080e7          	jalr	-1814(ra) # 5dc2 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    14e0:	86aa                	mv	a3,a0
    14e2:	f6840613          	addi	a2,s0,-152
    14e6:	85b2                	mv	a1,a2
    14e8:	00005517          	auipc	a0,0x5
    14ec:	61850513          	addi	a0,a0,1560 # 6b00 <malloc+0x906>
    14f0:	00005097          	auipc	ra,0x5
    14f4:	c52080e7          	jalr	-942(ra) # 6142 <printf>
    exit(1);
    14f8:	4505                	li	a0,1
    14fa:	00005097          	auipc	ra,0x5
    14fe:	8c8080e7          	jalr	-1848(ra) # 5dc2 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1502:	567d                	li	a2,-1
    1504:	f6840593          	addi	a1,s0,-152
    1508:	00005517          	auipc	a0,0x5
    150c:	62050513          	addi	a0,a0,1568 # 6b28 <malloc+0x92e>
    1510:	00005097          	auipc	ra,0x5
    1514:	c32080e7          	jalr	-974(ra) # 6142 <printf>
    exit(1);
    1518:	4505                	li	a0,1
    151a:	00005097          	auipc	ra,0x5
    151e:	8a8080e7          	jalr	-1880(ra) # 5dc2 <exit>
    printf("fork failed\n");
    1522:	00006517          	auipc	a0,0x6
    1526:	a8650513          	addi	a0,a0,-1402 # 6fa8 <malloc+0xdae>
    152a:	00005097          	auipc	ra,0x5
    152e:	c18080e7          	jalr	-1000(ra) # 6142 <printf>
    exit(1);
    1532:	4505                	li	a0,1
    1534:	00005097          	auipc	ra,0x5
    1538:	88e080e7          	jalr	-1906(ra) # 5dc2 <exit>
    exit(747); // OK
    153c:	2eb00513          	li	a0,747
    1540:	00005097          	auipc	ra,0x5
    1544:	882080e7          	jalr	-1918(ra) # 5dc2 <exit>
  int st = 0;
    1548:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    154c:	f5440513          	addi	a0,s0,-172
    1550:	00005097          	auipc	ra,0x5
    1554:	87a080e7          	jalr	-1926(ra) # 5dca <wait>
  if(st != 747){
    1558:	f5442703          	lw	a4,-172(s0)
    155c:	2eb00793          	li	a5,747
    1560:	00f71663          	bne	a4,a5,156c <copyinstr2+0x1dc>
}
    1564:	60ae                	ld	ra,200(sp)
    1566:	640e                	ld	s0,192(sp)
    1568:	6169                	addi	sp,sp,208
    156a:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    156c:	00005517          	auipc	a0,0x5
    1570:	60450513          	addi	a0,a0,1540 # 6b70 <malloc+0x976>
    1574:	00005097          	auipc	ra,0x5
    1578:	bce080e7          	jalr	-1074(ra) # 6142 <printf>
    exit(1);
    157c:	4505                	li	a0,1
    157e:	00005097          	auipc	ra,0x5
    1582:	844080e7          	jalr	-1980(ra) # 5dc2 <exit>

0000000000001586 <truncate3>:
{
    1586:	7159                	addi	sp,sp,-112
    1588:	f486                	sd	ra,104(sp)
    158a:	f0a2                	sd	s0,96(sp)
    158c:	eca6                	sd	s1,88(sp)
    158e:	e8ca                	sd	s2,80(sp)
    1590:	e4ce                	sd	s3,72(sp)
    1592:	e0d2                	sd	s4,64(sp)
    1594:	fc56                	sd	s5,56(sp)
    1596:	1880                	addi	s0,sp,112
    1598:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    159a:	60100593          	li	a1,1537
    159e:	00005517          	auipc	a0,0x5
    15a2:	dd250513          	addi	a0,a0,-558 # 6370 <malloc+0x176>
    15a6:	00005097          	auipc	ra,0x5
    15aa:	85c080e7          	jalr	-1956(ra) # 5e02 <open>
    15ae:	00005097          	auipc	ra,0x5
    15b2:	83c080e7          	jalr	-1988(ra) # 5dea <close>
  pid = fork();
    15b6:	00005097          	auipc	ra,0x5
    15ba:	804080e7          	jalr	-2044(ra) # 5dba <fork>
  if(pid < 0){
    15be:	08054063          	bltz	a0,163e <truncate3+0xb8>
  if(pid == 0){
    15c2:	e969                	bnez	a0,1694 <truncate3+0x10e>
    15c4:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    15c8:	00005a17          	auipc	s4,0x5
    15cc:	da8a0a13          	addi	s4,s4,-600 # 6370 <malloc+0x176>
      int n = write(fd, "1234567890", 10);
    15d0:	00005a97          	auipc	s5,0x5
    15d4:	600a8a93          	addi	s5,s5,1536 # 6bd0 <malloc+0x9d6>
      int fd = open("truncfile", O_WRONLY);
    15d8:	4585                	li	a1,1
    15da:	8552                	mv	a0,s4
    15dc:	00005097          	auipc	ra,0x5
    15e0:	826080e7          	jalr	-2010(ra) # 5e02 <open>
    15e4:	84aa                	mv	s1,a0
      if(fd < 0){
    15e6:	06054a63          	bltz	a0,165a <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    15ea:	4629                	li	a2,10
    15ec:	85d6                	mv	a1,s5
    15ee:	00004097          	auipc	ra,0x4
    15f2:	7f4080e7          	jalr	2036(ra) # 5de2 <write>
      if(n != 10){
    15f6:	47a9                	li	a5,10
    15f8:	06f51f63          	bne	a0,a5,1676 <truncate3+0xf0>
      close(fd);
    15fc:	8526                	mv	a0,s1
    15fe:	00004097          	auipc	ra,0x4
    1602:	7ec080e7          	jalr	2028(ra) # 5dea <close>
      fd = open("truncfile", O_RDONLY);
    1606:	4581                	li	a1,0
    1608:	8552                	mv	a0,s4
    160a:	00004097          	auipc	ra,0x4
    160e:	7f8080e7          	jalr	2040(ra) # 5e02 <open>
    1612:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1614:	02000613          	li	a2,32
    1618:	f9840593          	addi	a1,s0,-104
    161c:	00004097          	auipc	ra,0x4
    1620:	7be080e7          	jalr	1982(ra) # 5dda <read>
      close(fd);
    1624:	8526                	mv	a0,s1
    1626:	00004097          	auipc	ra,0x4
    162a:	7c4080e7          	jalr	1988(ra) # 5dea <close>
    for(int i = 0; i < 100; i++){
    162e:	39fd                	addiw	s3,s3,-1
    1630:	fa0994e3          	bnez	s3,15d8 <truncate3+0x52>
    exit(0);
    1634:	4501                	li	a0,0
    1636:	00004097          	auipc	ra,0x4
    163a:	78c080e7          	jalr	1932(ra) # 5dc2 <exit>
    printf("%s: fork failed\n", s);
    163e:	85ca                	mv	a1,s2
    1640:	00005517          	auipc	a0,0x5
    1644:	56050513          	addi	a0,a0,1376 # 6ba0 <malloc+0x9a6>
    1648:	00005097          	auipc	ra,0x5
    164c:	afa080e7          	jalr	-1286(ra) # 6142 <printf>
    exit(1);
    1650:	4505                	li	a0,1
    1652:	00004097          	auipc	ra,0x4
    1656:	770080e7          	jalr	1904(ra) # 5dc2 <exit>
        printf("%s: open failed\n", s);
    165a:	85ca                	mv	a1,s2
    165c:	00005517          	auipc	a0,0x5
    1660:	55c50513          	addi	a0,a0,1372 # 6bb8 <malloc+0x9be>
    1664:	00005097          	auipc	ra,0x5
    1668:	ade080e7          	jalr	-1314(ra) # 6142 <printf>
        exit(1);
    166c:	4505                	li	a0,1
    166e:	00004097          	auipc	ra,0x4
    1672:	754080e7          	jalr	1876(ra) # 5dc2 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1676:	862a                	mv	a2,a0
    1678:	85ca                	mv	a1,s2
    167a:	00005517          	auipc	a0,0x5
    167e:	56650513          	addi	a0,a0,1382 # 6be0 <malloc+0x9e6>
    1682:	00005097          	auipc	ra,0x5
    1686:	ac0080e7          	jalr	-1344(ra) # 6142 <printf>
        exit(1);
    168a:	4505                	li	a0,1
    168c:	00004097          	auipc	ra,0x4
    1690:	736080e7          	jalr	1846(ra) # 5dc2 <exit>
    1694:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1698:	00005a17          	auipc	s4,0x5
    169c:	cd8a0a13          	addi	s4,s4,-808 # 6370 <malloc+0x176>
    int n = write(fd, "xxx", 3);
    16a0:	00005a97          	auipc	s5,0x5
    16a4:	560a8a93          	addi	s5,s5,1376 # 6c00 <malloc+0xa06>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    16a8:	60100593          	li	a1,1537
    16ac:	8552                	mv	a0,s4
    16ae:	00004097          	auipc	ra,0x4
    16b2:	754080e7          	jalr	1876(ra) # 5e02 <open>
    16b6:	84aa                	mv	s1,a0
    if(fd < 0){
    16b8:	04054763          	bltz	a0,1706 <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    16bc:	460d                	li	a2,3
    16be:	85d6                	mv	a1,s5
    16c0:	00004097          	auipc	ra,0x4
    16c4:	722080e7          	jalr	1826(ra) # 5de2 <write>
    if(n != 3){
    16c8:	478d                	li	a5,3
    16ca:	04f51c63          	bne	a0,a5,1722 <truncate3+0x19c>
    close(fd);
    16ce:	8526                	mv	a0,s1
    16d0:	00004097          	auipc	ra,0x4
    16d4:	71a080e7          	jalr	1818(ra) # 5dea <close>
  for(int i = 0; i < 150; i++){
    16d8:	39fd                	addiw	s3,s3,-1
    16da:	fc0997e3          	bnez	s3,16a8 <truncate3+0x122>
  wait(&xstatus);
    16de:	fbc40513          	addi	a0,s0,-68
    16e2:	00004097          	auipc	ra,0x4
    16e6:	6e8080e7          	jalr	1768(ra) # 5dca <wait>
  unlink("truncfile");
    16ea:	00005517          	auipc	a0,0x5
    16ee:	c8650513          	addi	a0,a0,-890 # 6370 <malloc+0x176>
    16f2:	00004097          	auipc	ra,0x4
    16f6:	720080e7          	jalr	1824(ra) # 5e12 <unlink>
  exit(xstatus);
    16fa:	fbc42503          	lw	a0,-68(s0)
    16fe:	00004097          	auipc	ra,0x4
    1702:	6c4080e7          	jalr	1732(ra) # 5dc2 <exit>
      printf("%s: open failed\n", s);
    1706:	85ca                	mv	a1,s2
    1708:	00005517          	auipc	a0,0x5
    170c:	4b050513          	addi	a0,a0,1200 # 6bb8 <malloc+0x9be>
    1710:	00005097          	auipc	ra,0x5
    1714:	a32080e7          	jalr	-1486(ra) # 6142 <printf>
      exit(1);
    1718:	4505                	li	a0,1
    171a:	00004097          	auipc	ra,0x4
    171e:	6a8080e7          	jalr	1704(ra) # 5dc2 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1722:	862a                	mv	a2,a0
    1724:	85ca                	mv	a1,s2
    1726:	00005517          	auipc	a0,0x5
    172a:	4e250513          	addi	a0,a0,1250 # 6c08 <malloc+0xa0e>
    172e:	00005097          	auipc	ra,0x5
    1732:	a14080e7          	jalr	-1516(ra) # 6142 <printf>
      exit(1);
    1736:	4505                	li	a0,1
    1738:	00004097          	auipc	ra,0x4
    173c:	68a080e7          	jalr	1674(ra) # 5dc2 <exit>

0000000000001740 <exectest>:
{
    1740:	715d                	addi	sp,sp,-80
    1742:	e486                	sd	ra,72(sp)
    1744:	e0a2                	sd	s0,64(sp)
    1746:	fc26                	sd	s1,56(sp)
    1748:	f84a                	sd	s2,48(sp)
    174a:	0880                	addi	s0,sp,80
    174c:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    174e:	00005797          	auipc	a5,0x5
    1752:	bca78793          	addi	a5,a5,-1078 # 6318 <malloc+0x11e>
    1756:	fcf43023          	sd	a5,-64(s0)
    175a:	00005797          	auipc	a5,0x5
    175e:	4ce78793          	addi	a5,a5,1230 # 6c28 <malloc+0xa2e>
    1762:	fcf43423          	sd	a5,-56(s0)
    1766:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    176a:	00005517          	auipc	a0,0x5
    176e:	4c650513          	addi	a0,a0,1222 # 6c30 <malloc+0xa36>
    1772:	00004097          	auipc	ra,0x4
    1776:	6a0080e7          	jalr	1696(ra) # 5e12 <unlink>
  pid = fork();
    177a:	00004097          	auipc	ra,0x4
    177e:	640080e7          	jalr	1600(ra) # 5dba <fork>
  if(pid < 0) {
    1782:	04054663          	bltz	a0,17ce <exectest+0x8e>
    1786:	84aa                	mv	s1,a0
  if(pid == 0) {
    1788:	e959                	bnez	a0,181e <exectest+0xde>
    close(1);
    178a:	4505                	li	a0,1
    178c:	00004097          	auipc	ra,0x4
    1790:	65e080e7          	jalr	1630(ra) # 5dea <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1794:	20100593          	li	a1,513
    1798:	00005517          	auipc	a0,0x5
    179c:	49850513          	addi	a0,a0,1176 # 6c30 <malloc+0xa36>
    17a0:	00004097          	auipc	ra,0x4
    17a4:	662080e7          	jalr	1634(ra) # 5e02 <open>
    if(fd < 0) {
    17a8:	04054163          	bltz	a0,17ea <exectest+0xaa>
    if(fd != 1) {
    17ac:	4785                	li	a5,1
    17ae:	04f50c63          	beq	a0,a5,1806 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    17b2:	85ca                	mv	a1,s2
    17b4:	00005517          	auipc	a0,0x5
    17b8:	49c50513          	addi	a0,a0,1180 # 6c50 <malloc+0xa56>
    17bc:	00005097          	auipc	ra,0x5
    17c0:	986080e7          	jalr	-1658(ra) # 6142 <printf>
      exit(1);
    17c4:	4505                	li	a0,1
    17c6:	00004097          	auipc	ra,0x4
    17ca:	5fc080e7          	jalr	1532(ra) # 5dc2 <exit>
     printf("%s: fork failed\n", s);
    17ce:	85ca                	mv	a1,s2
    17d0:	00005517          	auipc	a0,0x5
    17d4:	3d050513          	addi	a0,a0,976 # 6ba0 <malloc+0x9a6>
    17d8:	00005097          	auipc	ra,0x5
    17dc:	96a080e7          	jalr	-1686(ra) # 6142 <printf>
     exit(1);
    17e0:	4505                	li	a0,1
    17e2:	00004097          	auipc	ra,0x4
    17e6:	5e0080e7          	jalr	1504(ra) # 5dc2 <exit>
      printf("%s: create failed\n", s);
    17ea:	85ca                	mv	a1,s2
    17ec:	00005517          	auipc	a0,0x5
    17f0:	44c50513          	addi	a0,a0,1100 # 6c38 <malloc+0xa3e>
    17f4:	00005097          	auipc	ra,0x5
    17f8:	94e080e7          	jalr	-1714(ra) # 6142 <printf>
      exit(1);
    17fc:	4505                	li	a0,1
    17fe:	00004097          	auipc	ra,0x4
    1802:	5c4080e7          	jalr	1476(ra) # 5dc2 <exit>
    if(exec("echo", echoargv) < 0){
    1806:	fc040593          	addi	a1,s0,-64
    180a:	00005517          	auipc	a0,0x5
    180e:	b0e50513          	addi	a0,a0,-1266 # 6318 <malloc+0x11e>
    1812:	00004097          	auipc	ra,0x4
    1816:	5e8080e7          	jalr	1512(ra) # 5dfa <exec>
    181a:	02054163          	bltz	a0,183c <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    181e:	fdc40513          	addi	a0,s0,-36
    1822:	00004097          	auipc	ra,0x4
    1826:	5a8080e7          	jalr	1448(ra) # 5dca <wait>
    182a:	02951763          	bne	a0,s1,1858 <exectest+0x118>
  if(xstatus != 0)
    182e:	fdc42503          	lw	a0,-36(s0)
    1832:	cd0d                	beqz	a0,186c <exectest+0x12c>
    exit(xstatus);
    1834:	00004097          	auipc	ra,0x4
    1838:	58e080e7          	jalr	1422(ra) # 5dc2 <exit>
      printf("%s: exec echo failed\n", s);
    183c:	85ca                	mv	a1,s2
    183e:	00005517          	auipc	a0,0x5
    1842:	42250513          	addi	a0,a0,1058 # 6c60 <malloc+0xa66>
    1846:	00005097          	auipc	ra,0x5
    184a:	8fc080e7          	jalr	-1796(ra) # 6142 <printf>
      exit(1);
    184e:	4505                	li	a0,1
    1850:	00004097          	auipc	ra,0x4
    1854:	572080e7          	jalr	1394(ra) # 5dc2 <exit>
    printf("%s: wait failed!\n", s);
    1858:	85ca                	mv	a1,s2
    185a:	00005517          	auipc	a0,0x5
    185e:	41e50513          	addi	a0,a0,1054 # 6c78 <malloc+0xa7e>
    1862:	00005097          	auipc	ra,0x5
    1866:	8e0080e7          	jalr	-1824(ra) # 6142 <printf>
    186a:	b7d1                	j	182e <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    186c:	4581                	li	a1,0
    186e:	00005517          	auipc	a0,0x5
    1872:	3c250513          	addi	a0,a0,962 # 6c30 <malloc+0xa36>
    1876:	00004097          	auipc	ra,0x4
    187a:	58c080e7          	jalr	1420(ra) # 5e02 <open>
  if(fd < 0) {
    187e:	02054a63          	bltz	a0,18b2 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    1882:	4609                	li	a2,2
    1884:	fb840593          	addi	a1,s0,-72
    1888:	00004097          	auipc	ra,0x4
    188c:	552080e7          	jalr	1362(ra) # 5dda <read>
    1890:	4789                	li	a5,2
    1892:	02f50e63          	beq	a0,a5,18ce <exectest+0x18e>
    printf("%s: read failed\n", s);
    1896:	85ca                	mv	a1,s2
    1898:	00005517          	auipc	a0,0x5
    189c:	e5050513          	addi	a0,a0,-432 # 66e8 <malloc+0x4ee>
    18a0:	00005097          	auipc	ra,0x5
    18a4:	8a2080e7          	jalr	-1886(ra) # 6142 <printf>
    exit(1);
    18a8:	4505                	li	a0,1
    18aa:	00004097          	auipc	ra,0x4
    18ae:	518080e7          	jalr	1304(ra) # 5dc2 <exit>
    printf("%s: open failed\n", s);
    18b2:	85ca                	mv	a1,s2
    18b4:	00005517          	auipc	a0,0x5
    18b8:	30450513          	addi	a0,a0,772 # 6bb8 <malloc+0x9be>
    18bc:	00005097          	auipc	ra,0x5
    18c0:	886080e7          	jalr	-1914(ra) # 6142 <printf>
    exit(1);
    18c4:	4505                	li	a0,1
    18c6:	00004097          	auipc	ra,0x4
    18ca:	4fc080e7          	jalr	1276(ra) # 5dc2 <exit>
  unlink("echo-ok");
    18ce:	00005517          	auipc	a0,0x5
    18d2:	36250513          	addi	a0,a0,866 # 6c30 <malloc+0xa36>
    18d6:	00004097          	auipc	ra,0x4
    18da:	53c080e7          	jalr	1340(ra) # 5e12 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    18de:	fb844703          	lbu	a4,-72(s0)
    18e2:	04f00793          	li	a5,79
    18e6:	00f71863          	bne	a4,a5,18f6 <exectest+0x1b6>
    18ea:	fb944703          	lbu	a4,-71(s0)
    18ee:	04b00793          	li	a5,75
    18f2:	02f70063          	beq	a4,a5,1912 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    18f6:	85ca                	mv	a1,s2
    18f8:	00005517          	auipc	a0,0x5
    18fc:	39850513          	addi	a0,a0,920 # 6c90 <malloc+0xa96>
    1900:	00005097          	auipc	ra,0x5
    1904:	842080e7          	jalr	-1982(ra) # 6142 <printf>
    exit(1);
    1908:	4505                	li	a0,1
    190a:	00004097          	auipc	ra,0x4
    190e:	4b8080e7          	jalr	1208(ra) # 5dc2 <exit>
    exit(0);
    1912:	4501                	li	a0,0
    1914:	00004097          	auipc	ra,0x4
    1918:	4ae080e7          	jalr	1198(ra) # 5dc2 <exit>

000000000000191c <pipe1>:
{
    191c:	711d                	addi	sp,sp,-96
    191e:	ec86                	sd	ra,88(sp)
    1920:	e8a2                	sd	s0,80(sp)
    1922:	e4a6                	sd	s1,72(sp)
    1924:	e0ca                	sd	s2,64(sp)
    1926:	fc4e                	sd	s3,56(sp)
    1928:	f852                	sd	s4,48(sp)
    192a:	f456                	sd	s5,40(sp)
    192c:	f05a                	sd	s6,32(sp)
    192e:	ec5e                	sd	s7,24(sp)
    1930:	1080                	addi	s0,sp,96
    1932:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    1934:	fa840513          	addi	a0,s0,-88
    1938:	00004097          	auipc	ra,0x4
    193c:	49a080e7          	jalr	1178(ra) # 5dd2 <pipe>
    1940:	e93d                	bnez	a0,19b6 <pipe1+0x9a>
    1942:	84aa                	mv	s1,a0
  pid = fork();
    1944:	00004097          	auipc	ra,0x4
    1948:	476080e7          	jalr	1142(ra) # 5dba <fork>
    194c:	8a2a                	mv	s4,a0
  if(pid == 0){
    194e:	c151                	beqz	a0,19d2 <pipe1+0xb6>
  } else if(pid > 0){
    1950:	16a05d63          	blez	a0,1aca <pipe1+0x1ae>
    close(fds[1]);
    1954:	fac42503          	lw	a0,-84(s0)
    1958:	00004097          	auipc	ra,0x4
    195c:	492080e7          	jalr	1170(ra) # 5dea <close>
    total = 0;
    1960:	8a26                	mv	s4,s1
    cc = 1;
    1962:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1964:	0000ba97          	auipc	s5,0xb
    1968:	314a8a93          	addi	s5,s5,788 # cc78 <buf>
    196c:	864e                	mv	a2,s3
    196e:	85d6                	mv	a1,s5
    1970:	fa842503          	lw	a0,-88(s0)
    1974:	00004097          	auipc	ra,0x4
    1978:	466080e7          	jalr	1126(ra) # 5dda <read>
    197c:	10a05263          	blez	a0,1a80 <pipe1+0x164>
      for(i = 0; i < n; i++){
    1980:	0000b717          	auipc	a4,0xb
    1984:	2f870713          	addi	a4,a4,760 # cc78 <buf>
    1988:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    198c:	00074683          	lbu	a3,0(a4)
    1990:	0ff4f793          	zext.b	a5,s1
    1994:	2485                	addiw	s1,s1,1
    1996:	0cf69163          	bne	a3,a5,1a58 <pipe1+0x13c>
      for(i = 0; i < n; i++){
    199a:	0705                	addi	a4,a4,1
    199c:	fec498e3          	bne	s1,a2,198c <pipe1+0x70>
      total += n;
    19a0:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    19a4:	0019979b          	slliw	a5,s3,0x1
    19a8:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    19ac:	670d                	lui	a4,0x3
    19ae:	fb377fe3          	bgeu	a4,s3,196c <pipe1+0x50>
        cc = sizeof(buf);
    19b2:	698d                	lui	s3,0x3
    19b4:	bf65                	j	196c <pipe1+0x50>
    printf("%s: pipe() failed\n", s);
    19b6:	85ca                	mv	a1,s2
    19b8:	00005517          	auipc	a0,0x5
    19bc:	2f050513          	addi	a0,a0,752 # 6ca8 <malloc+0xaae>
    19c0:	00004097          	auipc	ra,0x4
    19c4:	782080e7          	jalr	1922(ra) # 6142 <printf>
    exit(1);
    19c8:	4505                	li	a0,1
    19ca:	00004097          	auipc	ra,0x4
    19ce:	3f8080e7          	jalr	1016(ra) # 5dc2 <exit>
    close(fds[0]);
    19d2:	fa842503          	lw	a0,-88(s0)
    19d6:	00004097          	auipc	ra,0x4
    19da:	414080e7          	jalr	1044(ra) # 5dea <close>
    for(n = 0; n < N; n++){
    19de:	0000bb17          	auipc	s6,0xb
    19e2:	29ab0b13          	addi	s6,s6,666 # cc78 <buf>
    19e6:	416004bb          	negw	s1,s6
    19ea:	0ff4f493          	zext.b	s1,s1
    19ee:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    19f2:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    19f4:	6a85                	lui	s5,0x1
    19f6:	42da8a93          	addi	s5,s5,1069 # 142d <copyinstr2+0x9d>
{
    19fa:	87da                	mv	a5,s6
        buf[i] = seq++;
    19fc:	0097873b          	addw	a4,a5,s1
    1a00:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1a04:	0785                	addi	a5,a5,1
    1a06:	fef99be3          	bne	s3,a5,19fc <pipe1+0xe0>
        buf[i] = seq++;
    1a0a:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1a0e:	40900613          	li	a2,1033
    1a12:	85de                	mv	a1,s7
    1a14:	fac42503          	lw	a0,-84(s0)
    1a18:	00004097          	auipc	ra,0x4
    1a1c:	3ca080e7          	jalr	970(ra) # 5de2 <write>
    1a20:	40900793          	li	a5,1033
    1a24:	00f51c63          	bne	a0,a5,1a3c <pipe1+0x120>
    for(n = 0; n < N; n++){
    1a28:	24a5                	addiw	s1,s1,9
    1a2a:	0ff4f493          	zext.b	s1,s1
    1a2e:	fd5a16e3          	bne	s4,s5,19fa <pipe1+0xde>
    exit(0);
    1a32:	4501                	li	a0,0
    1a34:	00004097          	auipc	ra,0x4
    1a38:	38e080e7          	jalr	910(ra) # 5dc2 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1a3c:	85ca                	mv	a1,s2
    1a3e:	00005517          	auipc	a0,0x5
    1a42:	28250513          	addi	a0,a0,642 # 6cc0 <malloc+0xac6>
    1a46:	00004097          	auipc	ra,0x4
    1a4a:	6fc080e7          	jalr	1788(ra) # 6142 <printf>
        exit(1);
    1a4e:	4505                	li	a0,1
    1a50:	00004097          	auipc	ra,0x4
    1a54:	372080e7          	jalr	882(ra) # 5dc2 <exit>
          printf("%s: pipe1 oops 2\n", s);
    1a58:	85ca                	mv	a1,s2
    1a5a:	00005517          	auipc	a0,0x5
    1a5e:	27e50513          	addi	a0,a0,638 # 6cd8 <malloc+0xade>
    1a62:	00004097          	auipc	ra,0x4
    1a66:	6e0080e7          	jalr	1760(ra) # 6142 <printf>
}
    1a6a:	60e6                	ld	ra,88(sp)
    1a6c:	6446                	ld	s0,80(sp)
    1a6e:	64a6                	ld	s1,72(sp)
    1a70:	6906                	ld	s2,64(sp)
    1a72:	79e2                	ld	s3,56(sp)
    1a74:	7a42                	ld	s4,48(sp)
    1a76:	7aa2                	ld	s5,40(sp)
    1a78:	7b02                	ld	s6,32(sp)
    1a7a:	6be2                	ld	s7,24(sp)
    1a7c:	6125                	addi	sp,sp,96
    1a7e:	8082                	ret
    if(total != N * SZ){
    1a80:	6785                	lui	a5,0x1
    1a82:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr2+0x9d>
    1a86:	02fa0063          	beq	s4,a5,1aa6 <pipe1+0x18a>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1a8a:	85d2                	mv	a1,s4
    1a8c:	00005517          	auipc	a0,0x5
    1a90:	26450513          	addi	a0,a0,612 # 6cf0 <malloc+0xaf6>
    1a94:	00004097          	auipc	ra,0x4
    1a98:	6ae080e7          	jalr	1710(ra) # 6142 <printf>
      exit(1);
    1a9c:	4505                	li	a0,1
    1a9e:	00004097          	auipc	ra,0x4
    1aa2:	324080e7          	jalr	804(ra) # 5dc2 <exit>
    close(fds[0]);
    1aa6:	fa842503          	lw	a0,-88(s0)
    1aaa:	00004097          	auipc	ra,0x4
    1aae:	340080e7          	jalr	832(ra) # 5dea <close>
    wait(&xstatus);
    1ab2:	fa440513          	addi	a0,s0,-92
    1ab6:	00004097          	auipc	ra,0x4
    1aba:	314080e7          	jalr	788(ra) # 5dca <wait>
    exit(xstatus);
    1abe:	fa442503          	lw	a0,-92(s0)
    1ac2:	00004097          	auipc	ra,0x4
    1ac6:	300080e7          	jalr	768(ra) # 5dc2 <exit>
    printf("%s: fork() failed\n", s);
    1aca:	85ca                	mv	a1,s2
    1acc:	00005517          	auipc	a0,0x5
    1ad0:	24450513          	addi	a0,a0,580 # 6d10 <malloc+0xb16>
    1ad4:	00004097          	auipc	ra,0x4
    1ad8:	66e080e7          	jalr	1646(ra) # 6142 <printf>
    exit(1);
    1adc:	4505                	li	a0,1
    1ade:	00004097          	auipc	ra,0x4
    1ae2:	2e4080e7          	jalr	740(ra) # 5dc2 <exit>

0000000000001ae6 <exitwait>:
{
    1ae6:	7139                	addi	sp,sp,-64
    1ae8:	fc06                	sd	ra,56(sp)
    1aea:	f822                	sd	s0,48(sp)
    1aec:	f426                	sd	s1,40(sp)
    1aee:	f04a                	sd	s2,32(sp)
    1af0:	ec4e                	sd	s3,24(sp)
    1af2:	e852                	sd	s4,16(sp)
    1af4:	0080                	addi	s0,sp,64
    1af6:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1af8:	4901                	li	s2,0
    1afa:	06400993          	li	s3,100
    pid = fork();
    1afe:	00004097          	auipc	ra,0x4
    1b02:	2bc080e7          	jalr	700(ra) # 5dba <fork>
    1b06:	84aa                	mv	s1,a0
    if(pid < 0){
    1b08:	02054a63          	bltz	a0,1b3c <exitwait+0x56>
    if(pid){
    1b0c:	c151                	beqz	a0,1b90 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1b0e:	fcc40513          	addi	a0,s0,-52
    1b12:	00004097          	auipc	ra,0x4
    1b16:	2b8080e7          	jalr	696(ra) # 5dca <wait>
    1b1a:	02951f63          	bne	a0,s1,1b58 <exitwait+0x72>
      if(i != xstate) {
    1b1e:	fcc42783          	lw	a5,-52(s0)
    1b22:	05279963          	bne	a5,s2,1b74 <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1b26:	2905                	addiw	s2,s2,1
    1b28:	fd391be3          	bne	s2,s3,1afe <exitwait+0x18>
}
    1b2c:	70e2                	ld	ra,56(sp)
    1b2e:	7442                	ld	s0,48(sp)
    1b30:	74a2                	ld	s1,40(sp)
    1b32:	7902                	ld	s2,32(sp)
    1b34:	69e2                	ld	s3,24(sp)
    1b36:	6a42                	ld	s4,16(sp)
    1b38:	6121                	addi	sp,sp,64
    1b3a:	8082                	ret
      printf("%s: fork failed\n", s);
    1b3c:	85d2                	mv	a1,s4
    1b3e:	00005517          	auipc	a0,0x5
    1b42:	06250513          	addi	a0,a0,98 # 6ba0 <malloc+0x9a6>
    1b46:	00004097          	auipc	ra,0x4
    1b4a:	5fc080e7          	jalr	1532(ra) # 6142 <printf>
      exit(1);
    1b4e:	4505                	li	a0,1
    1b50:	00004097          	auipc	ra,0x4
    1b54:	272080e7          	jalr	626(ra) # 5dc2 <exit>
        printf("%s: wait wrong pid\n", s);
    1b58:	85d2                	mv	a1,s4
    1b5a:	00005517          	auipc	a0,0x5
    1b5e:	1ce50513          	addi	a0,a0,462 # 6d28 <malloc+0xb2e>
    1b62:	00004097          	auipc	ra,0x4
    1b66:	5e0080e7          	jalr	1504(ra) # 6142 <printf>
        exit(1);
    1b6a:	4505                	li	a0,1
    1b6c:	00004097          	auipc	ra,0x4
    1b70:	256080e7          	jalr	598(ra) # 5dc2 <exit>
        printf("%s: wait wrong exit status\n", s);
    1b74:	85d2                	mv	a1,s4
    1b76:	00005517          	auipc	a0,0x5
    1b7a:	1ca50513          	addi	a0,a0,458 # 6d40 <malloc+0xb46>
    1b7e:	00004097          	auipc	ra,0x4
    1b82:	5c4080e7          	jalr	1476(ra) # 6142 <printf>
        exit(1);
    1b86:	4505                	li	a0,1
    1b88:	00004097          	auipc	ra,0x4
    1b8c:	23a080e7          	jalr	570(ra) # 5dc2 <exit>
      exit(i);
    1b90:	854a                	mv	a0,s2
    1b92:	00004097          	auipc	ra,0x4
    1b96:	230080e7          	jalr	560(ra) # 5dc2 <exit>

0000000000001b9a <twochildren>:
{
    1b9a:	1101                	addi	sp,sp,-32
    1b9c:	ec06                	sd	ra,24(sp)
    1b9e:	e822                	sd	s0,16(sp)
    1ba0:	e426                	sd	s1,8(sp)
    1ba2:	e04a                	sd	s2,0(sp)
    1ba4:	1000                	addi	s0,sp,32
    1ba6:	892a                	mv	s2,a0
    1ba8:	3e800493          	li	s1,1000
    int pid1 = fork();
    1bac:	00004097          	auipc	ra,0x4
    1bb0:	20e080e7          	jalr	526(ra) # 5dba <fork>
    if(pid1 < 0){
    1bb4:	02054c63          	bltz	a0,1bec <twochildren+0x52>
    if(pid1 == 0){
    1bb8:	c921                	beqz	a0,1c08 <twochildren+0x6e>
      int pid2 = fork();
    1bba:	00004097          	auipc	ra,0x4
    1bbe:	200080e7          	jalr	512(ra) # 5dba <fork>
      if(pid2 < 0){
    1bc2:	04054763          	bltz	a0,1c10 <twochildren+0x76>
      if(pid2 == 0){
    1bc6:	c13d                	beqz	a0,1c2c <twochildren+0x92>
        wait(0);
    1bc8:	4501                	li	a0,0
    1bca:	00004097          	auipc	ra,0x4
    1bce:	200080e7          	jalr	512(ra) # 5dca <wait>
        wait(0);
    1bd2:	4501                	li	a0,0
    1bd4:	00004097          	auipc	ra,0x4
    1bd8:	1f6080e7          	jalr	502(ra) # 5dca <wait>
  for(int i = 0; i < 1000; i++){
    1bdc:	34fd                	addiw	s1,s1,-1
    1bde:	f4f9                	bnez	s1,1bac <twochildren+0x12>
}
    1be0:	60e2                	ld	ra,24(sp)
    1be2:	6442                	ld	s0,16(sp)
    1be4:	64a2                	ld	s1,8(sp)
    1be6:	6902                	ld	s2,0(sp)
    1be8:	6105                	addi	sp,sp,32
    1bea:	8082                	ret
      printf("%s: fork failed\n", s);
    1bec:	85ca                	mv	a1,s2
    1bee:	00005517          	auipc	a0,0x5
    1bf2:	fb250513          	addi	a0,a0,-78 # 6ba0 <malloc+0x9a6>
    1bf6:	00004097          	auipc	ra,0x4
    1bfa:	54c080e7          	jalr	1356(ra) # 6142 <printf>
      exit(1);
    1bfe:	4505                	li	a0,1
    1c00:	00004097          	auipc	ra,0x4
    1c04:	1c2080e7          	jalr	450(ra) # 5dc2 <exit>
      exit(0);
    1c08:	00004097          	auipc	ra,0x4
    1c0c:	1ba080e7          	jalr	442(ra) # 5dc2 <exit>
        printf("%s: fork failed\n", s);
    1c10:	85ca                	mv	a1,s2
    1c12:	00005517          	auipc	a0,0x5
    1c16:	f8e50513          	addi	a0,a0,-114 # 6ba0 <malloc+0x9a6>
    1c1a:	00004097          	auipc	ra,0x4
    1c1e:	528080e7          	jalr	1320(ra) # 6142 <printf>
        exit(1);
    1c22:	4505                	li	a0,1
    1c24:	00004097          	auipc	ra,0x4
    1c28:	19e080e7          	jalr	414(ra) # 5dc2 <exit>
        exit(0);
    1c2c:	00004097          	auipc	ra,0x4
    1c30:	196080e7          	jalr	406(ra) # 5dc2 <exit>

0000000000001c34 <forkfork>:
{
    1c34:	7179                	addi	sp,sp,-48
    1c36:	f406                	sd	ra,40(sp)
    1c38:	f022                	sd	s0,32(sp)
    1c3a:	ec26                	sd	s1,24(sp)
    1c3c:	1800                	addi	s0,sp,48
    1c3e:	84aa                	mv	s1,a0
    int pid = fork();
    1c40:	00004097          	auipc	ra,0x4
    1c44:	17a080e7          	jalr	378(ra) # 5dba <fork>
    if(pid < 0){
    1c48:	04054163          	bltz	a0,1c8a <forkfork+0x56>
    if(pid == 0){
    1c4c:	cd29                	beqz	a0,1ca6 <forkfork+0x72>
    int pid = fork();
    1c4e:	00004097          	auipc	ra,0x4
    1c52:	16c080e7          	jalr	364(ra) # 5dba <fork>
    if(pid < 0){
    1c56:	02054a63          	bltz	a0,1c8a <forkfork+0x56>
    if(pid == 0){
    1c5a:	c531                	beqz	a0,1ca6 <forkfork+0x72>
    wait(&xstatus);
    1c5c:	fdc40513          	addi	a0,s0,-36
    1c60:	00004097          	auipc	ra,0x4
    1c64:	16a080e7          	jalr	362(ra) # 5dca <wait>
    if(xstatus != 0) {
    1c68:	fdc42783          	lw	a5,-36(s0)
    1c6c:	ebbd                	bnez	a5,1ce2 <forkfork+0xae>
    wait(&xstatus);
    1c6e:	fdc40513          	addi	a0,s0,-36
    1c72:	00004097          	auipc	ra,0x4
    1c76:	158080e7          	jalr	344(ra) # 5dca <wait>
    if(xstatus != 0) {
    1c7a:	fdc42783          	lw	a5,-36(s0)
    1c7e:	e3b5                	bnez	a5,1ce2 <forkfork+0xae>
}
    1c80:	70a2                	ld	ra,40(sp)
    1c82:	7402                	ld	s0,32(sp)
    1c84:	64e2                	ld	s1,24(sp)
    1c86:	6145                	addi	sp,sp,48
    1c88:	8082                	ret
      printf("%s: fork failed", s);
    1c8a:	85a6                	mv	a1,s1
    1c8c:	00005517          	auipc	a0,0x5
    1c90:	0d450513          	addi	a0,a0,212 # 6d60 <malloc+0xb66>
    1c94:	00004097          	auipc	ra,0x4
    1c98:	4ae080e7          	jalr	1198(ra) # 6142 <printf>
      exit(1);
    1c9c:	4505                	li	a0,1
    1c9e:	00004097          	auipc	ra,0x4
    1ca2:	124080e7          	jalr	292(ra) # 5dc2 <exit>
{
    1ca6:	0c800493          	li	s1,200
        int pid1 = fork();
    1caa:	00004097          	auipc	ra,0x4
    1cae:	110080e7          	jalr	272(ra) # 5dba <fork>
        if(pid1 < 0){
    1cb2:	00054f63          	bltz	a0,1cd0 <forkfork+0x9c>
        if(pid1 == 0){
    1cb6:	c115                	beqz	a0,1cda <forkfork+0xa6>
        wait(0);
    1cb8:	4501                	li	a0,0
    1cba:	00004097          	auipc	ra,0x4
    1cbe:	110080e7          	jalr	272(ra) # 5dca <wait>
      for(int j = 0; j < 200; j++){
    1cc2:	34fd                	addiw	s1,s1,-1
    1cc4:	f0fd                	bnez	s1,1caa <forkfork+0x76>
      exit(0);
    1cc6:	4501                	li	a0,0
    1cc8:	00004097          	auipc	ra,0x4
    1ccc:	0fa080e7          	jalr	250(ra) # 5dc2 <exit>
          exit(1);
    1cd0:	4505                	li	a0,1
    1cd2:	00004097          	auipc	ra,0x4
    1cd6:	0f0080e7          	jalr	240(ra) # 5dc2 <exit>
          exit(0);
    1cda:	00004097          	auipc	ra,0x4
    1cde:	0e8080e7          	jalr	232(ra) # 5dc2 <exit>
      printf("%s: fork in child failed", s);
    1ce2:	85a6                	mv	a1,s1
    1ce4:	00005517          	auipc	a0,0x5
    1ce8:	08c50513          	addi	a0,a0,140 # 6d70 <malloc+0xb76>
    1cec:	00004097          	auipc	ra,0x4
    1cf0:	456080e7          	jalr	1110(ra) # 6142 <printf>
      exit(1);
    1cf4:	4505                	li	a0,1
    1cf6:	00004097          	auipc	ra,0x4
    1cfa:	0cc080e7          	jalr	204(ra) # 5dc2 <exit>

0000000000001cfe <reparent2>:
{
    1cfe:	1101                	addi	sp,sp,-32
    1d00:	ec06                	sd	ra,24(sp)
    1d02:	e822                	sd	s0,16(sp)
    1d04:	e426                	sd	s1,8(sp)
    1d06:	1000                	addi	s0,sp,32
    1d08:	32000493          	li	s1,800
    int pid1 = fork();
    1d0c:	00004097          	auipc	ra,0x4
    1d10:	0ae080e7          	jalr	174(ra) # 5dba <fork>
    if(pid1 < 0){
    1d14:	00054f63          	bltz	a0,1d32 <reparent2+0x34>
    if(pid1 == 0){
    1d18:	c915                	beqz	a0,1d4c <reparent2+0x4e>
    wait(0);
    1d1a:	4501                	li	a0,0
    1d1c:	00004097          	auipc	ra,0x4
    1d20:	0ae080e7          	jalr	174(ra) # 5dca <wait>
  for(int i = 0; i < 800; i++){
    1d24:	34fd                	addiw	s1,s1,-1
    1d26:	f0fd                	bnez	s1,1d0c <reparent2+0xe>
  exit(0);
    1d28:	4501                	li	a0,0
    1d2a:	00004097          	auipc	ra,0x4
    1d2e:	098080e7          	jalr	152(ra) # 5dc2 <exit>
      printf("fork failed\n");
    1d32:	00005517          	auipc	a0,0x5
    1d36:	27650513          	addi	a0,a0,630 # 6fa8 <malloc+0xdae>
    1d3a:	00004097          	auipc	ra,0x4
    1d3e:	408080e7          	jalr	1032(ra) # 6142 <printf>
      exit(1);
    1d42:	4505                	li	a0,1
    1d44:	00004097          	auipc	ra,0x4
    1d48:	07e080e7          	jalr	126(ra) # 5dc2 <exit>
      fork();
    1d4c:	00004097          	auipc	ra,0x4
    1d50:	06e080e7          	jalr	110(ra) # 5dba <fork>
      fork();
    1d54:	00004097          	auipc	ra,0x4
    1d58:	066080e7          	jalr	102(ra) # 5dba <fork>
      exit(0);
    1d5c:	4501                	li	a0,0
    1d5e:	00004097          	auipc	ra,0x4
    1d62:	064080e7          	jalr	100(ra) # 5dc2 <exit>

0000000000001d66 <createdelete>:
{
    1d66:	7175                	addi	sp,sp,-144
    1d68:	e506                	sd	ra,136(sp)
    1d6a:	e122                	sd	s0,128(sp)
    1d6c:	fca6                	sd	s1,120(sp)
    1d6e:	f8ca                	sd	s2,112(sp)
    1d70:	f4ce                	sd	s3,104(sp)
    1d72:	f0d2                	sd	s4,96(sp)
    1d74:	ecd6                	sd	s5,88(sp)
    1d76:	e8da                	sd	s6,80(sp)
    1d78:	e4de                	sd	s7,72(sp)
    1d7a:	e0e2                	sd	s8,64(sp)
    1d7c:	fc66                	sd	s9,56(sp)
    1d7e:	0900                	addi	s0,sp,144
    1d80:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1d82:	4901                	li	s2,0
    1d84:	4991                	li	s3,4
    pid = fork();
    1d86:	00004097          	auipc	ra,0x4
    1d8a:	034080e7          	jalr	52(ra) # 5dba <fork>
    1d8e:	84aa                	mv	s1,a0
    if(pid < 0){
    1d90:	02054f63          	bltz	a0,1dce <createdelete+0x68>
    if(pid == 0){
    1d94:	c939                	beqz	a0,1dea <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1d96:	2905                	addiw	s2,s2,1
    1d98:	ff3917e3          	bne	s2,s3,1d86 <createdelete+0x20>
    1d9c:	4491                	li	s1,4
    wait(&xstatus);
    1d9e:	f7c40513          	addi	a0,s0,-132
    1da2:	00004097          	auipc	ra,0x4
    1da6:	028080e7          	jalr	40(ra) # 5dca <wait>
    if(xstatus != 0)
    1daa:	f7c42903          	lw	s2,-132(s0)
    1dae:	0e091263          	bnez	s2,1e92 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1db2:	34fd                	addiw	s1,s1,-1
    1db4:	f4ed                	bnez	s1,1d9e <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1db6:	f8040123          	sb	zero,-126(s0)
    1dba:	03000993          	li	s3,48
    1dbe:	5a7d                	li	s4,-1
    1dc0:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1dc4:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1dc6:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1dc8:	07400a93          	li	s5,116
    1dcc:	a29d                	j	1f32 <createdelete+0x1cc>
      printf("fork failed\n", s);
    1dce:	85e6                	mv	a1,s9
    1dd0:	00005517          	auipc	a0,0x5
    1dd4:	1d850513          	addi	a0,a0,472 # 6fa8 <malloc+0xdae>
    1dd8:	00004097          	auipc	ra,0x4
    1ddc:	36a080e7          	jalr	874(ra) # 6142 <printf>
      exit(1);
    1de0:	4505                	li	a0,1
    1de2:	00004097          	auipc	ra,0x4
    1de6:	fe0080e7          	jalr	-32(ra) # 5dc2 <exit>
      name[0] = 'p' + pi;
    1dea:	0709091b          	addiw	s2,s2,112
    1dee:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1df2:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1df6:	4951                	li	s2,20
    1df8:	a015                	j	1e1c <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1dfa:	85e6                	mv	a1,s9
    1dfc:	00005517          	auipc	a0,0x5
    1e00:	e3c50513          	addi	a0,a0,-452 # 6c38 <malloc+0xa3e>
    1e04:	00004097          	auipc	ra,0x4
    1e08:	33e080e7          	jalr	830(ra) # 6142 <printf>
          exit(1);
    1e0c:	4505                	li	a0,1
    1e0e:	00004097          	auipc	ra,0x4
    1e12:	fb4080e7          	jalr	-76(ra) # 5dc2 <exit>
      for(i = 0; i < N; i++){
    1e16:	2485                	addiw	s1,s1,1
    1e18:	07248863          	beq	s1,s2,1e88 <createdelete+0x122>
        name[1] = '0' + i;
    1e1c:	0304879b          	addiw	a5,s1,48
    1e20:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1e24:	20200593          	li	a1,514
    1e28:	f8040513          	addi	a0,s0,-128
    1e2c:	00004097          	auipc	ra,0x4
    1e30:	fd6080e7          	jalr	-42(ra) # 5e02 <open>
        if(fd < 0){
    1e34:	fc0543e3          	bltz	a0,1dfa <createdelete+0x94>
        close(fd);
    1e38:	00004097          	auipc	ra,0x4
    1e3c:	fb2080e7          	jalr	-78(ra) # 5dea <close>
        if(i > 0 && (i % 2 ) == 0){
    1e40:	fc905be3          	blez	s1,1e16 <createdelete+0xb0>
    1e44:	0014f793          	andi	a5,s1,1
    1e48:	f7f9                	bnez	a5,1e16 <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1e4a:	01f4d79b          	srliw	a5,s1,0x1f
    1e4e:	9fa5                	addw	a5,a5,s1
    1e50:	4017d79b          	sraiw	a5,a5,0x1
    1e54:	0307879b          	addiw	a5,a5,48
    1e58:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1e5c:	f8040513          	addi	a0,s0,-128
    1e60:	00004097          	auipc	ra,0x4
    1e64:	fb2080e7          	jalr	-78(ra) # 5e12 <unlink>
    1e68:	fa0557e3          	bgez	a0,1e16 <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1e6c:	85e6                	mv	a1,s9
    1e6e:	00005517          	auipc	a0,0x5
    1e72:	f2250513          	addi	a0,a0,-222 # 6d90 <malloc+0xb96>
    1e76:	00004097          	auipc	ra,0x4
    1e7a:	2cc080e7          	jalr	716(ra) # 6142 <printf>
            exit(1);
    1e7e:	4505                	li	a0,1
    1e80:	00004097          	auipc	ra,0x4
    1e84:	f42080e7          	jalr	-190(ra) # 5dc2 <exit>
      exit(0);
    1e88:	4501                	li	a0,0
    1e8a:	00004097          	auipc	ra,0x4
    1e8e:	f38080e7          	jalr	-200(ra) # 5dc2 <exit>
      exit(1);
    1e92:	4505                	li	a0,1
    1e94:	00004097          	auipc	ra,0x4
    1e98:	f2e080e7          	jalr	-210(ra) # 5dc2 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1e9c:	f8040613          	addi	a2,s0,-128
    1ea0:	85e6                	mv	a1,s9
    1ea2:	00005517          	auipc	a0,0x5
    1ea6:	f0650513          	addi	a0,a0,-250 # 6da8 <malloc+0xbae>
    1eaa:	00004097          	auipc	ra,0x4
    1eae:	298080e7          	jalr	664(ra) # 6142 <printf>
        exit(1);
    1eb2:	4505                	li	a0,1
    1eb4:	00004097          	auipc	ra,0x4
    1eb8:	f0e080e7          	jalr	-242(ra) # 5dc2 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ebc:	054b7163          	bgeu	s6,s4,1efe <createdelete+0x198>
      if(fd >= 0)
    1ec0:	02055a63          	bgez	a0,1ef4 <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1ec4:	2485                	addiw	s1,s1,1
    1ec6:	0ff4f493          	zext.b	s1,s1
    1eca:	05548c63          	beq	s1,s5,1f22 <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1ece:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1ed2:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1ed6:	4581                	li	a1,0
    1ed8:	f8040513          	addi	a0,s0,-128
    1edc:	00004097          	auipc	ra,0x4
    1ee0:	f26080e7          	jalr	-218(ra) # 5e02 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1ee4:	00090463          	beqz	s2,1eec <createdelete+0x186>
    1ee8:	fd2bdae3          	bge	s7,s2,1ebc <createdelete+0x156>
    1eec:	fa0548e3          	bltz	a0,1e9c <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ef0:	014b7963          	bgeu	s6,s4,1f02 <createdelete+0x19c>
        close(fd);
    1ef4:	00004097          	auipc	ra,0x4
    1ef8:	ef6080e7          	jalr	-266(ra) # 5dea <close>
    1efc:	b7e1                	j	1ec4 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1efe:	fc0543e3          	bltz	a0,1ec4 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1f02:	f8040613          	addi	a2,s0,-128
    1f06:	85e6                	mv	a1,s9
    1f08:	00005517          	auipc	a0,0x5
    1f0c:	ec850513          	addi	a0,a0,-312 # 6dd0 <malloc+0xbd6>
    1f10:	00004097          	auipc	ra,0x4
    1f14:	232080e7          	jalr	562(ra) # 6142 <printf>
        exit(1);
    1f18:	4505                	li	a0,1
    1f1a:	00004097          	auipc	ra,0x4
    1f1e:	ea8080e7          	jalr	-344(ra) # 5dc2 <exit>
  for(i = 0; i < N; i++){
    1f22:	2905                	addiw	s2,s2,1
    1f24:	2a05                	addiw	s4,s4,1
    1f26:	2985                	addiw	s3,s3,1 # 3001 <execout+0xa7>
    1f28:	0ff9f993          	zext.b	s3,s3
    1f2c:	47d1                	li	a5,20
    1f2e:	02f90a63          	beq	s2,a5,1f62 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1f32:	84e2                	mv	s1,s8
    1f34:	bf69                	j	1ece <createdelete+0x168>
  for(i = 0; i < N; i++){
    1f36:	2905                	addiw	s2,s2,1
    1f38:	0ff97913          	zext.b	s2,s2
    1f3c:	2985                	addiw	s3,s3,1
    1f3e:	0ff9f993          	zext.b	s3,s3
    1f42:	03490863          	beq	s2,s4,1f72 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1f46:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1f48:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1f4c:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1f50:	f8040513          	addi	a0,s0,-128
    1f54:	00004097          	auipc	ra,0x4
    1f58:	ebe080e7          	jalr	-322(ra) # 5e12 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1f5c:	34fd                	addiw	s1,s1,-1
    1f5e:	f4ed                	bnez	s1,1f48 <createdelete+0x1e2>
    1f60:	bfd9                	j	1f36 <createdelete+0x1d0>
    1f62:	03000993          	li	s3,48
    1f66:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1f6a:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1f6c:	08400a13          	li	s4,132
    1f70:	bfd9                	j	1f46 <createdelete+0x1e0>
}
    1f72:	60aa                	ld	ra,136(sp)
    1f74:	640a                	ld	s0,128(sp)
    1f76:	74e6                	ld	s1,120(sp)
    1f78:	7946                	ld	s2,112(sp)
    1f7a:	79a6                	ld	s3,104(sp)
    1f7c:	7a06                	ld	s4,96(sp)
    1f7e:	6ae6                	ld	s5,88(sp)
    1f80:	6b46                	ld	s6,80(sp)
    1f82:	6ba6                	ld	s7,72(sp)
    1f84:	6c06                	ld	s8,64(sp)
    1f86:	7ce2                	ld	s9,56(sp)
    1f88:	6149                	addi	sp,sp,144
    1f8a:	8082                	ret

0000000000001f8c <linkunlink>:
{
    1f8c:	711d                	addi	sp,sp,-96
    1f8e:	ec86                	sd	ra,88(sp)
    1f90:	e8a2                	sd	s0,80(sp)
    1f92:	e4a6                	sd	s1,72(sp)
    1f94:	e0ca                	sd	s2,64(sp)
    1f96:	fc4e                	sd	s3,56(sp)
    1f98:	f852                	sd	s4,48(sp)
    1f9a:	f456                	sd	s5,40(sp)
    1f9c:	f05a                	sd	s6,32(sp)
    1f9e:	ec5e                	sd	s7,24(sp)
    1fa0:	e862                	sd	s8,16(sp)
    1fa2:	e466                	sd	s9,8(sp)
    1fa4:	1080                	addi	s0,sp,96
    1fa6:	84aa                	mv	s1,a0
  unlink("x");
    1fa8:	00004517          	auipc	a0,0x4
    1fac:	3e050513          	addi	a0,a0,992 # 6388 <malloc+0x18e>
    1fb0:	00004097          	auipc	ra,0x4
    1fb4:	e62080e7          	jalr	-414(ra) # 5e12 <unlink>
  pid = fork();
    1fb8:	00004097          	auipc	ra,0x4
    1fbc:	e02080e7          	jalr	-510(ra) # 5dba <fork>
  if(pid < 0){
    1fc0:	02054b63          	bltz	a0,1ff6 <linkunlink+0x6a>
    1fc4:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1fc6:	06100c93          	li	s9,97
    1fca:	c111                	beqz	a0,1fce <linkunlink+0x42>
    1fcc:	4c85                	li	s9,1
    1fce:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1fd2:	41c659b7          	lui	s3,0x41c65
    1fd6:	e6d9899b          	addiw	s3,s3,-403 # 41c64e6d <base+0x41c551f5>
    1fda:	690d                	lui	s2,0x3
    1fdc:	0399091b          	addiw	s2,s2,57 # 3039 <fourteen+0x1b>
    if((x % 3) == 0){
    1fe0:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1fe2:	4b05                	li	s6,1
      unlink("x");
    1fe4:	00004a97          	auipc	s5,0x4
    1fe8:	3a4a8a93          	addi	s5,s5,932 # 6388 <malloc+0x18e>
      link("cat", "x");
    1fec:	00005b97          	auipc	s7,0x5
    1ff0:	e0cb8b93          	addi	s7,s7,-500 # 6df8 <malloc+0xbfe>
    1ff4:	a825                	j	202c <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1ff6:	85a6                	mv	a1,s1
    1ff8:	00005517          	auipc	a0,0x5
    1ffc:	ba850513          	addi	a0,a0,-1112 # 6ba0 <malloc+0x9a6>
    2000:	00004097          	auipc	ra,0x4
    2004:	142080e7          	jalr	322(ra) # 6142 <printf>
    exit(1);
    2008:	4505                	li	a0,1
    200a:	00004097          	auipc	ra,0x4
    200e:	db8080e7          	jalr	-584(ra) # 5dc2 <exit>
      close(open("x", O_RDWR | O_CREATE));
    2012:	20200593          	li	a1,514
    2016:	8556                	mv	a0,s5
    2018:	00004097          	auipc	ra,0x4
    201c:	dea080e7          	jalr	-534(ra) # 5e02 <open>
    2020:	00004097          	auipc	ra,0x4
    2024:	dca080e7          	jalr	-566(ra) # 5dea <close>
  for(i = 0; i < 100; i++){
    2028:	34fd                	addiw	s1,s1,-1
    202a:	c88d                	beqz	s1,205c <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    202c:	033c87bb          	mulw	a5,s9,s3
    2030:	012787bb          	addw	a5,a5,s2
    2034:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    2038:	0347f7bb          	remuw	a5,a5,s4
    203c:	dbf9                	beqz	a5,2012 <linkunlink+0x86>
    } else if((x % 3) == 1){
    203e:	01678863          	beq	a5,s6,204e <linkunlink+0xc2>
      unlink("x");
    2042:	8556                	mv	a0,s5
    2044:	00004097          	auipc	ra,0x4
    2048:	dce080e7          	jalr	-562(ra) # 5e12 <unlink>
    204c:	bff1                	j	2028 <linkunlink+0x9c>
      link("cat", "x");
    204e:	85d6                	mv	a1,s5
    2050:	855e                	mv	a0,s7
    2052:	00004097          	auipc	ra,0x4
    2056:	dd0080e7          	jalr	-560(ra) # 5e22 <link>
    205a:	b7f9                	j	2028 <linkunlink+0x9c>
  if(pid)
    205c:	020c0463          	beqz	s8,2084 <linkunlink+0xf8>
    wait(0);
    2060:	4501                	li	a0,0
    2062:	00004097          	auipc	ra,0x4
    2066:	d68080e7          	jalr	-664(ra) # 5dca <wait>
}
    206a:	60e6                	ld	ra,88(sp)
    206c:	6446                	ld	s0,80(sp)
    206e:	64a6                	ld	s1,72(sp)
    2070:	6906                	ld	s2,64(sp)
    2072:	79e2                	ld	s3,56(sp)
    2074:	7a42                	ld	s4,48(sp)
    2076:	7aa2                	ld	s5,40(sp)
    2078:	7b02                	ld	s6,32(sp)
    207a:	6be2                	ld	s7,24(sp)
    207c:	6c42                	ld	s8,16(sp)
    207e:	6ca2                	ld	s9,8(sp)
    2080:	6125                	addi	sp,sp,96
    2082:	8082                	ret
    exit(0);
    2084:	4501                	li	a0,0
    2086:	00004097          	auipc	ra,0x4
    208a:	d3c080e7          	jalr	-708(ra) # 5dc2 <exit>

000000000000208e <forktest>:
{
    208e:	7179                	addi	sp,sp,-48
    2090:	f406                	sd	ra,40(sp)
    2092:	f022                	sd	s0,32(sp)
    2094:	ec26                	sd	s1,24(sp)
    2096:	e84a                	sd	s2,16(sp)
    2098:	e44e                	sd	s3,8(sp)
    209a:	1800                	addi	s0,sp,48
    209c:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    209e:	4481                	li	s1,0
    20a0:	3e800913          	li	s2,1000
    pid = fork();
    20a4:	00004097          	auipc	ra,0x4
    20a8:	d16080e7          	jalr	-746(ra) # 5dba <fork>
    if(pid < 0)
    20ac:	02054863          	bltz	a0,20dc <forktest+0x4e>
    if(pid == 0)
    20b0:	c115                	beqz	a0,20d4 <forktest+0x46>
  for(n=0; n<N; n++){
    20b2:	2485                	addiw	s1,s1,1
    20b4:	ff2498e3          	bne	s1,s2,20a4 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    20b8:	85ce                	mv	a1,s3
    20ba:	00005517          	auipc	a0,0x5
    20be:	d5e50513          	addi	a0,a0,-674 # 6e18 <malloc+0xc1e>
    20c2:	00004097          	auipc	ra,0x4
    20c6:	080080e7          	jalr	128(ra) # 6142 <printf>
    exit(1);
    20ca:	4505                	li	a0,1
    20cc:	00004097          	auipc	ra,0x4
    20d0:	cf6080e7          	jalr	-778(ra) # 5dc2 <exit>
      exit(0);
    20d4:	00004097          	auipc	ra,0x4
    20d8:	cee080e7          	jalr	-786(ra) # 5dc2 <exit>
  if (n == 0) {
    20dc:	cc9d                	beqz	s1,211a <forktest+0x8c>
  if(n == N){
    20de:	3e800793          	li	a5,1000
    20e2:	fcf48be3          	beq	s1,a5,20b8 <forktest+0x2a>
  for(; n > 0; n--){
    20e6:	00905b63          	blez	s1,20fc <forktest+0x6e>
    if(wait(0) < 0){
    20ea:	4501                	li	a0,0
    20ec:	00004097          	auipc	ra,0x4
    20f0:	cde080e7          	jalr	-802(ra) # 5dca <wait>
    20f4:	04054163          	bltz	a0,2136 <forktest+0xa8>
  for(; n > 0; n--){
    20f8:	34fd                	addiw	s1,s1,-1
    20fa:	f8e5                	bnez	s1,20ea <forktest+0x5c>
  if(wait(0) != -1){
    20fc:	4501                	li	a0,0
    20fe:	00004097          	auipc	ra,0x4
    2102:	ccc080e7          	jalr	-820(ra) # 5dca <wait>
    2106:	57fd                	li	a5,-1
    2108:	04f51563          	bne	a0,a5,2152 <forktest+0xc4>
}
    210c:	70a2                	ld	ra,40(sp)
    210e:	7402                	ld	s0,32(sp)
    2110:	64e2                	ld	s1,24(sp)
    2112:	6942                	ld	s2,16(sp)
    2114:	69a2                	ld	s3,8(sp)
    2116:	6145                	addi	sp,sp,48
    2118:	8082                	ret
    printf("%s: no fork at all!\n", s);
    211a:	85ce                	mv	a1,s3
    211c:	00005517          	auipc	a0,0x5
    2120:	ce450513          	addi	a0,a0,-796 # 6e00 <malloc+0xc06>
    2124:	00004097          	auipc	ra,0x4
    2128:	01e080e7          	jalr	30(ra) # 6142 <printf>
    exit(1);
    212c:	4505                	li	a0,1
    212e:	00004097          	auipc	ra,0x4
    2132:	c94080e7          	jalr	-876(ra) # 5dc2 <exit>
      printf("%s: wait stopped early\n", s);
    2136:	85ce                	mv	a1,s3
    2138:	00005517          	auipc	a0,0x5
    213c:	d0850513          	addi	a0,a0,-760 # 6e40 <malloc+0xc46>
    2140:	00004097          	auipc	ra,0x4
    2144:	002080e7          	jalr	2(ra) # 6142 <printf>
      exit(1);
    2148:	4505                	li	a0,1
    214a:	00004097          	auipc	ra,0x4
    214e:	c78080e7          	jalr	-904(ra) # 5dc2 <exit>
    printf("%s: wait got too many\n", s);
    2152:	85ce                	mv	a1,s3
    2154:	00005517          	auipc	a0,0x5
    2158:	d0450513          	addi	a0,a0,-764 # 6e58 <malloc+0xc5e>
    215c:	00004097          	auipc	ra,0x4
    2160:	fe6080e7          	jalr	-26(ra) # 6142 <printf>
    exit(1);
    2164:	4505                	li	a0,1
    2166:	00004097          	auipc	ra,0x4
    216a:	c5c080e7          	jalr	-932(ra) # 5dc2 <exit>

000000000000216e <kernmem>:
{
    216e:	715d                	addi	sp,sp,-80
    2170:	e486                	sd	ra,72(sp)
    2172:	e0a2                	sd	s0,64(sp)
    2174:	fc26                	sd	s1,56(sp)
    2176:	f84a                	sd	s2,48(sp)
    2178:	f44e                	sd	s3,40(sp)
    217a:	f052                	sd	s4,32(sp)
    217c:	ec56                	sd	s5,24(sp)
    217e:	0880                	addi	s0,sp,80
    2180:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2182:	4485                	li	s1,1
    2184:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    2186:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2188:	69b1                	lui	s3,0xc
    218a:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    218e:	1003d937          	lui	s2,0x1003d
    2192:	090e                	slli	s2,s2,0x3
    2194:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    2198:	00004097          	auipc	ra,0x4
    219c:	c22080e7          	jalr	-990(ra) # 5dba <fork>
    if(pid < 0){
    21a0:	02054963          	bltz	a0,21d2 <kernmem+0x64>
    if(pid == 0){
    21a4:	c529                	beqz	a0,21ee <kernmem+0x80>
    wait(&xstatus);
    21a6:	fbc40513          	addi	a0,s0,-68
    21aa:	00004097          	auipc	ra,0x4
    21ae:	c20080e7          	jalr	-992(ra) # 5dca <wait>
    if(xstatus != -1)  // did kernel kill child?
    21b2:	fbc42783          	lw	a5,-68(s0)
    21b6:	05579d63          	bne	a5,s5,2210 <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    21ba:	94ce                	add	s1,s1,s3
    21bc:	fd249ee3          	bne	s1,s2,2198 <kernmem+0x2a>
}
    21c0:	60a6                	ld	ra,72(sp)
    21c2:	6406                	ld	s0,64(sp)
    21c4:	74e2                	ld	s1,56(sp)
    21c6:	7942                	ld	s2,48(sp)
    21c8:	79a2                	ld	s3,40(sp)
    21ca:	7a02                	ld	s4,32(sp)
    21cc:	6ae2                	ld	s5,24(sp)
    21ce:	6161                	addi	sp,sp,80
    21d0:	8082                	ret
      printf("%s: fork failed\n", s);
    21d2:	85d2                	mv	a1,s4
    21d4:	00005517          	auipc	a0,0x5
    21d8:	9cc50513          	addi	a0,a0,-1588 # 6ba0 <malloc+0x9a6>
    21dc:	00004097          	auipc	ra,0x4
    21e0:	f66080e7          	jalr	-154(ra) # 6142 <printf>
      exit(1);
    21e4:	4505                	li	a0,1
    21e6:	00004097          	auipc	ra,0x4
    21ea:	bdc080e7          	jalr	-1060(ra) # 5dc2 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    21ee:	0004c683          	lbu	a3,0(s1)
    21f2:	8626                	mv	a2,s1
    21f4:	85d2                	mv	a1,s4
    21f6:	00005517          	auipc	a0,0x5
    21fa:	c7a50513          	addi	a0,a0,-902 # 6e70 <malloc+0xc76>
    21fe:	00004097          	auipc	ra,0x4
    2202:	f44080e7          	jalr	-188(ra) # 6142 <printf>
      exit(1);
    2206:	4505                	li	a0,1
    2208:	00004097          	auipc	ra,0x4
    220c:	bba080e7          	jalr	-1094(ra) # 5dc2 <exit>
      exit(1);
    2210:	4505                	li	a0,1
    2212:	00004097          	auipc	ra,0x4
    2216:	bb0080e7          	jalr	-1104(ra) # 5dc2 <exit>

000000000000221a <MAXVAplus>:
{
    221a:	7179                	addi	sp,sp,-48
    221c:	f406                	sd	ra,40(sp)
    221e:	f022                	sd	s0,32(sp)
    2220:	ec26                	sd	s1,24(sp)
    2222:	e84a                	sd	s2,16(sp)
    2224:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    2226:	4785                	li	a5,1
    2228:	179a                	slli	a5,a5,0x26
    222a:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    222e:	fd843783          	ld	a5,-40(s0)
    2232:	cf85                	beqz	a5,226a <MAXVAplus+0x50>
    2234:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    2236:	54fd                	li	s1,-1
    pid = fork();
    2238:	00004097          	auipc	ra,0x4
    223c:	b82080e7          	jalr	-1150(ra) # 5dba <fork>
    if(pid < 0){
    2240:	02054b63          	bltz	a0,2276 <MAXVAplus+0x5c>
    if(pid == 0){
    2244:	c539                	beqz	a0,2292 <MAXVAplus+0x78>
    wait(&xstatus);
    2246:	fd440513          	addi	a0,s0,-44
    224a:	00004097          	auipc	ra,0x4
    224e:	b80080e7          	jalr	-1152(ra) # 5dca <wait>
    if(xstatus != -1)  // did kernel kill child?
    2252:	fd442783          	lw	a5,-44(s0)
    2256:	06979463          	bne	a5,s1,22be <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    225a:	fd843783          	ld	a5,-40(s0)
    225e:	0786                	slli	a5,a5,0x1
    2260:	fcf43c23          	sd	a5,-40(s0)
    2264:	fd843783          	ld	a5,-40(s0)
    2268:	fbe1                	bnez	a5,2238 <MAXVAplus+0x1e>
}
    226a:	70a2                	ld	ra,40(sp)
    226c:	7402                	ld	s0,32(sp)
    226e:	64e2                	ld	s1,24(sp)
    2270:	6942                	ld	s2,16(sp)
    2272:	6145                	addi	sp,sp,48
    2274:	8082                	ret
      printf("%s: fork failed\n", s);
    2276:	85ca                	mv	a1,s2
    2278:	00005517          	auipc	a0,0x5
    227c:	92850513          	addi	a0,a0,-1752 # 6ba0 <malloc+0x9a6>
    2280:	00004097          	auipc	ra,0x4
    2284:	ec2080e7          	jalr	-318(ra) # 6142 <printf>
      exit(1);
    2288:	4505                	li	a0,1
    228a:	00004097          	auipc	ra,0x4
    228e:	b38080e7          	jalr	-1224(ra) # 5dc2 <exit>
      *(char*)a = 99;
    2292:	fd843783          	ld	a5,-40(s0)
    2296:	06300713          	li	a4,99
    229a:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    229e:	fd843603          	ld	a2,-40(s0)
    22a2:	85ca                	mv	a1,s2
    22a4:	00005517          	auipc	a0,0x5
    22a8:	bec50513          	addi	a0,a0,-1044 # 6e90 <malloc+0xc96>
    22ac:	00004097          	auipc	ra,0x4
    22b0:	e96080e7          	jalr	-362(ra) # 6142 <printf>
      exit(1);
    22b4:	4505                	li	a0,1
    22b6:	00004097          	auipc	ra,0x4
    22ba:	b0c080e7          	jalr	-1268(ra) # 5dc2 <exit>
      exit(1);
    22be:	4505                	li	a0,1
    22c0:	00004097          	auipc	ra,0x4
    22c4:	b02080e7          	jalr	-1278(ra) # 5dc2 <exit>

00000000000022c8 <bigargtest>:
{
    22c8:	7179                	addi	sp,sp,-48
    22ca:	f406                	sd	ra,40(sp)
    22cc:	f022                	sd	s0,32(sp)
    22ce:	ec26                	sd	s1,24(sp)
    22d0:	1800                	addi	s0,sp,48
    22d2:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    22d4:	00005517          	auipc	a0,0x5
    22d8:	bd450513          	addi	a0,a0,-1068 # 6ea8 <malloc+0xcae>
    22dc:	00004097          	auipc	ra,0x4
    22e0:	b36080e7          	jalr	-1226(ra) # 5e12 <unlink>
  pid = fork();
    22e4:	00004097          	auipc	ra,0x4
    22e8:	ad6080e7          	jalr	-1322(ra) # 5dba <fork>
  if(pid == 0){
    22ec:	c121                	beqz	a0,232c <bigargtest+0x64>
  } else if(pid < 0){
    22ee:	0a054063          	bltz	a0,238e <bigargtest+0xc6>
  wait(&xstatus);
    22f2:	fdc40513          	addi	a0,s0,-36
    22f6:	00004097          	auipc	ra,0x4
    22fa:	ad4080e7          	jalr	-1324(ra) # 5dca <wait>
  if(xstatus != 0)
    22fe:	fdc42503          	lw	a0,-36(s0)
    2302:	e545                	bnez	a0,23aa <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    2304:	4581                	li	a1,0
    2306:	00005517          	auipc	a0,0x5
    230a:	ba250513          	addi	a0,a0,-1118 # 6ea8 <malloc+0xcae>
    230e:	00004097          	auipc	ra,0x4
    2312:	af4080e7          	jalr	-1292(ra) # 5e02 <open>
  if(fd < 0){
    2316:	08054e63          	bltz	a0,23b2 <bigargtest+0xea>
  close(fd);
    231a:	00004097          	auipc	ra,0x4
    231e:	ad0080e7          	jalr	-1328(ra) # 5dea <close>
}
    2322:	70a2                	ld	ra,40(sp)
    2324:	7402                	ld	s0,32(sp)
    2326:	64e2                	ld	s1,24(sp)
    2328:	6145                	addi	sp,sp,48
    232a:	8082                	ret
    232c:	00007797          	auipc	a5,0x7
    2330:	13478793          	addi	a5,a5,308 # 9460 <args.1>
    2334:	00007697          	auipc	a3,0x7
    2338:	22468693          	addi	a3,a3,548 # 9558 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    233c:	00005717          	auipc	a4,0x5
    2340:	b7c70713          	addi	a4,a4,-1156 # 6eb8 <malloc+0xcbe>
    2344:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    2346:	07a1                	addi	a5,a5,8
    2348:	fed79ee3          	bne	a5,a3,2344 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    234c:	00007597          	auipc	a1,0x7
    2350:	11458593          	addi	a1,a1,276 # 9460 <args.1>
    2354:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    2358:	00004517          	auipc	a0,0x4
    235c:	fc050513          	addi	a0,a0,-64 # 6318 <malloc+0x11e>
    2360:	00004097          	auipc	ra,0x4
    2364:	a9a080e7          	jalr	-1382(ra) # 5dfa <exec>
    fd = open("bigarg-ok", O_CREATE);
    2368:	20000593          	li	a1,512
    236c:	00005517          	auipc	a0,0x5
    2370:	b3c50513          	addi	a0,a0,-1220 # 6ea8 <malloc+0xcae>
    2374:	00004097          	auipc	ra,0x4
    2378:	a8e080e7          	jalr	-1394(ra) # 5e02 <open>
    close(fd);
    237c:	00004097          	auipc	ra,0x4
    2380:	a6e080e7          	jalr	-1426(ra) # 5dea <close>
    exit(0);
    2384:	4501                	li	a0,0
    2386:	00004097          	auipc	ra,0x4
    238a:	a3c080e7          	jalr	-1476(ra) # 5dc2 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    238e:	85a6                	mv	a1,s1
    2390:	00005517          	auipc	a0,0x5
    2394:	c0850513          	addi	a0,a0,-1016 # 6f98 <malloc+0xd9e>
    2398:	00004097          	auipc	ra,0x4
    239c:	daa080e7          	jalr	-598(ra) # 6142 <printf>
    exit(1);
    23a0:	4505                	li	a0,1
    23a2:	00004097          	auipc	ra,0x4
    23a6:	a20080e7          	jalr	-1504(ra) # 5dc2 <exit>
    exit(xstatus);
    23aa:	00004097          	auipc	ra,0x4
    23ae:	a18080e7          	jalr	-1512(ra) # 5dc2 <exit>
    printf("%s: bigarg test failed!\n", s);
    23b2:	85a6                	mv	a1,s1
    23b4:	00005517          	auipc	a0,0x5
    23b8:	c0450513          	addi	a0,a0,-1020 # 6fb8 <malloc+0xdbe>
    23bc:	00004097          	auipc	ra,0x4
    23c0:	d86080e7          	jalr	-634(ra) # 6142 <printf>
    exit(1);
    23c4:	4505                	li	a0,1
    23c6:	00004097          	auipc	ra,0x4
    23ca:	9fc080e7          	jalr	-1540(ra) # 5dc2 <exit>

00000000000023ce <stacktest>:
{
    23ce:	7179                	addi	sp,sp,-48
    23d0:	f406                	sd	ra,40(sp)
    23d2:	f022                	sd	s0,32(sp)
    23d4:	ec26                	sd	s1,24(sp)
    23d6:	1800                	addi	s0,sp,48
    23d8:	84aa                	mv	s1,a0
  pid = fork();
    23da:	00004097          	auipc	ra,0x4
    23de:	9e0080e7          	jalr	-1568(ra) # 5dba <fork>
  if(pid == 0) {
    23e2:	c115                	beqz	a0,2406 <stacktest+0x38>
  } else if(pid < 0){
    23e4:	04054463          	bltz	a0,242c <stacktest+0x5e>
  wait(&xstatus);
    23e8:	fdc40513          	addi	a0,s0,-36
    23ec:	00004097          	auipc	ra,0x4
    23f0:	9de080e7          	jalr	-1570(ra) # 5dca <wait>
  if(xstatus == -1)  // kernel killed child?
    23f4:	fdc42503          	lw	a0,-36(s0)
    23f8:	57fd                	li	a5,-1
    23fa:	04f50763          	beq	a0,a5,2448 <stacktest+0x7a>
    exit(xstatus);
    23fe:	00004097          	auipc	ra,0x4
    2402:	9c4080e7          	jalr	-1596(ra) # 5dc2 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    2406:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2408:	77fd                	lui	a5,0xfffff
    240a:	97ba                	add	a5,a5,a4
    240c:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    2410:	85a6                	mv	a1,s1
    2412:	00005517          	auipc	a0,0x5
    2416:	bc650513          	addi	a0,a0,-1082 # 6fd8 <malloc+0xdde>
    241a:	00004097          	auipc	ra,0x4
    241e:	d28080e7          	jalr	-728(ra) # 6142 <printf>
    exit(1);
    2422:	4505                	li	a0,1
    2424:	00004097          	auipc	ra,0x4
    2428:	99e080e7          	jalr	-1634(ra) # 5dc2 <exit>
    printf("%s: fork failed\n", s);
    242c:	85a6                	mv	a1,s1
    242e:	00004517          	auipc	a0,0x4
    2432:	77250513          	addi	a0,a0,1906 # 6ba0 <malloc+0x9a6>
    2436:	00004097          	auipc	ra,0x4
    243a:	d0c080e7          	jalr	-756(ra) # 6142 <printf>
    exit(1);
    243e:	4505                	li	a0,1
    2440:	00004097          	auipc	ra,0x4
    2444:	982080e7          	jalr	-1662(ra) # 5dc2 <exit>
    exit(0);
    2448:	4501                	li	a0,0
    244a:	00004097          	auipc	ra,0x4
    244e:	978080e7          	jalr	-1672(ra) # 5dc2 <exit>

0000000000002452 <textwrite>:
{
    2452:	7179                	addi	sp,sp,-48
    2454:	f406                	sd	ra,40(sp)
    2456:	f022                	sd	s0,32(sp)
    2458:	ec26                	sd	s1,24(sp)
    245a:	1800                	addi	s0,sp,48
    245c:	84aa                	mv	s1,a0
  pid = fork();
    245e:	00004097          	auipc	ra,0x4
    2462:	95c080e7          	jalr	-1700(ra) # 5dba <fork>
  if(pid == 0) {
    2466:	c115                	beqz	a0,248a <textwrite+0x38>
  } else if(pid < 0){
    2468:	02054963          	bltz	a0,249a <textwrite+0x48>
  wait(&xstatus);
    246c:	fdc40513          	addi	a0,s0,-36
    2470:	00004097          	auipc	ra,0x4
    2474:	95a080e7          	jalr	-1702(ra) # 5dca <wait>
  if(xstatus == -1)  // kernel killed child?
    2478:	fdc42503          	lw	a0,-36(s0)
    247c:	57fd                	li	a5,-1
    247e:	02f50c63          	beq	a0,a5,24b6 <textwrite+0x64>
    exit(xstatus);
    2482:	00004097          	auipc	ra,0x4
    2486:	940080e7          	jalr	-1728(ra) # 5dc2 <exit>
    *addr = 10;
    248a:	47a9                	li	a5,10
    248c:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1>
    exit(1);
    2490:	4505                	li	a0,1
    2492:	00004097          	auipc	ra,0x4
    2496:	930080e7          	jalr	-1744(ra) # 5dc2 <exit>
    printf("%s: fork failed\n", s);
    249a:	85a6                	mv	a1,s1
    249c:	00004517          	auipc	a0,0x4
    24a0:	70450513          	addi	a0,a0,1796 # 6ba0 <malloc+0x9a6>
    24a4:	00004097          	auipc	ra,0x4
    24a8:	c9e080e7          	jalr	-866(ra) # 6142 <printf>
    exit(1);
    24ac:	4505                	li	a0,1
    24ae:	00004097          	auipc	ra,0x4
    24b2:	914080e7          	jalr	-1772(ra) # 5dc2 <exit>
    exit(0);
    24b6:	4501                	li	a0,0
    24b8:	00004097          	auipc	ra,0x4
    24bc:	90a080e7          	jalr	-1782(ra) # 5dc2 <exit>

00000000000024c0 <manywrites>:
{
    24c0:	711d                	addi	sp,sp,-96
    24c2:	ec86                	sd	ra,88(sp)
    24c4:	e8a2                	sd	s0,80(sp)
    24c6:	e4a6                	sd	s1,72(sp)
    24c8:	e0ca                	sd	s2,64(sp)
    24ca:	fc4e                	sd	s3,56(sp)
    24cc:	f852                	sd	s4,48(sp)
    24ce:	f456                	sd	s5,40(sp)
    24d0:	f05a                	sd	s6,32(sp)
    24d2:	ec5e                	sd	s7,24(sp)
    24d4:	1080                	addi	s0,sp,96
    24d6:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    24d8:	4981                	li	s3,0
    24da:	4911                	li	s2,4
    int pid = fork();
    24dc:	00004097          	auipc	ra,0x4
    24e0:	8de080e7          	jalr	-1826(ra) # 5dba <fork>
    24e4:	84aa                	mv	s1,a0
    if(pid < 0){
    24e6:	02054963          	bltz	a0,2518 <manywrites+0x58>
    if(pid == 0){
    24ea:	c521                	beqz	a0,2532 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    24ec:	2985                	addiw	s3,s3,1
    24ee:	ff2997e3          	bne	s3,s2,24dc <manywrites+0x1c>
    24f2:	4491                	li	s1,4
    int st = 0;
    24f4:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    24f8:	fa840513          	addi	a0,s0,-88
    24fc:	00004097          	auipc	ra,0x4
    2500:	8ce080e7          	jalr	-1842(ra) # 5dca <wait>
    if(st != 0)
    2504:	fa842503          	lw	a0,-88(s0)
    2508:	ed6d                	bnez	a0,2602 <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    250a:	34fd                	addiw	s1,s1,-1
    250c:	f4e5                	bnez	s1,24f4 <manywrites+0x34>
  exit(0);
    250e:	4501                	li	a0,0
    2510:	00004097          	auipc	ra,0x4
    2514:	8b2080e7          	jalr	-1870(ra) # 5dc2 <exit>
      printf("fork failed\n");
    2518:	00005517          	auipc	a0,0x5
    251c:	a9050513          	addi	a0,a0,-1392 # 6fa8 <malloc+0xdae>
    2520:	00004097          	auipc	ra,0x4
    2524:	c22080e7          	jalr	-990(ra) # 6142 <printf>
      exit(1);
    2528:	4505                	li	a0,1
    252a:	00004097          	auipc	ra,0x4
    252e:	898080e7          	jalr	-1896(ra) # 5dc2 <exit>
      name[0] = 'b';
    2532:	06200793          	li	a5,98
    2536:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    253a:	0619879b          	addiw	a5,s3,97
    253e:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    2542:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    2546:	fa840513          	addi	a0,s0,-88
    254a:	00004097          	auipc	ra,0x4
    254e:	8c8080e7          	jalr	-1848(ra) # 5e12 <unlink>
    2552:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    2554:	0000ab17          	auipc	s6,0xa
    2558:	724b0b13          	addi	s6,s6,1828 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    255c:	8a26                	mv	s4,s1
    255e:	0209ce63          	bltz	s3,259a <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    2562:	20200593          	li	a1,514
    2566:	fa840513          	addi	a0,s0,-88
    256a:	00004097          	auipc	ra,0x4
    256e:	898080e7          	jalr	-1896(ra) # 5e02 <open>
    2572:	892a                	mv	s2,a0
          if(fd < 0){
    2574:	04054763          	bltz	a0,25c2 <manywrites+0x102>
          int cc = write(fd, buf, sz);
    2578:	660d                	lui	a2,0x3
    257a:	85da                	mv	a1,s6
    257c:	00004097          	auipc	ra,0x4
    2580:	866080e7          	jalr	-1946(ra) # 5de2 <write>
          if(cc != sz){
    2584:	678d                	lui	a5,0x3
    2586:	04f51e63          	bne	a0,a5,25e2 <manywrites+0x122>
          close(fd);
    258a:	854a                	mv	a0,s2
    258c:	00004097          	auipc	ra,0x4
    2590:	85e080e7          	jalr	-1954(ra) # 5dea <close>
        for(int i = 0; i < ci+1; i++){
    2594:	2a05                	addiw	s4,s4,1
    2596:	fd49d6e3          	bge	s3,s4,2562 <manywrites+0xa2>
        unlink(name);
    259a:	fa840513          	addi	a0,s0,-88
    259e:	00004097          	auipc	ra,0x4
    25a2:	874080e7          	jalr	-1932(ra) # 5e12 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    25a6:	3bfd                	addiw	s7,s7,-1
    25a8:	fa0b9ae3          	bnez	s7,255c <manywrites+0x9c>
      unlink(name);
    25ac:	fa840513          	addi	a0,s0,-88
    25b0:	00004097          	auipc	ra,0x4
    25b4:	862080e7          	jalr	-1950(ra) # 5e12 <unlink>
      exit(0);
    25b8:	4501                	li	a0,0
    25ba:	00004097          	auipc	ra,0x4
    25be:	808080e7          	jalr	-2040(ra) # 5dc2 <exit>
            printf("%s: cannot create %s\n", s, name);
    25c2:	fa840613          	addi	a2,s0,-88
    25c6:	85d6                	mv	a1,s5
    25c8:	00005517          	auipc	a0,0x5
    25cc:	a3850513          	addi	a0,a0,-1480 # 7000 <malloc+0xe06>
    25d0:	00004097          	auipc	ra,0x4
    25d4:	b72080e7          	jalr	-1166(ra) # 6142 <printf>
            exit(1);
    25d8:	4505                	li	a0,1
    25da:	00003097          	auipc	ra,0x3
    25de:	7e8080e7          	jalr	2024(ra) # 5dc2 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    25e2:	86aa                	mv	a3,a0
    25e4:	660d                	lui	a2,0x3
    25e6:	85d6                	mv	a1,s5
    25e8:	00004517          	auipc	a0,0x4
    25ec:	e0050513          	addi	a0,a0,-512 # 63e8 <malloc+0x1ee>
    25f0:	00004097          	auipc	ra,0x4
    25f4:	b52080e7          	jalr	-1198(ra) # 6142 <printf>
            exit(1);
    25f8:	4505                	li	a0,1
    25fa:	00003097          	auipc	ra,0x3
    25fe:	7c8080e7          	jalr	1992(ra) # 5dc2 <exit>
      exit(st);
    2602:	00003097          	auipc	ra,0x3
    2606:	7c0080e7          	jalr	1984(ra) # 5dc2 <exit>

000000000000260a <copyinstr3>:
{
    260a:	7179                	addi	sp,sp,-48
    260c:	f406                	sd	ra,40(sp)
    260e:	f022                	sd	s0,32(sp)
    2610:	ec26                	sd	s1,24(sp)
    2612:	1800                	addi	s0,sp,48
  sbrk(8192);
    2614:	6509                	lui	a0,0x2
    2616:	00004097          	auipc	ra,0x4
    261a:	834080e7          	jalr	-1996(ra) # 5e4a <sbrk>
  uint64 top = (uint64) sbrk(0);
    261e:	4501                	li	a0,0
    2620:	00004097          	auipc	ra,0x4
    2624:	82a080e7          	jalr	-2006(ra) # 5e4a <sbrk>
  if((top % PGSIZE) != 0){
    2628:	03451793          	slli	a5,a0,0x34
    262c:	e3c9                	bnez	a5,26ae <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    262e:	4501                	li	a0,0
    2630:	00004097          	auipc	ra,0x4
    2634:	81a080e7          	jalr	-2022(ra) # 5e4a <sbrk>
  if(top % PGSIZE){
    2638:	03451793          	slli	a5,a0,0x34
    263c:	e3d9                	bnez	a5,26c2 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    263e:	fff50493          	addi	s1,a0,-1 # 1fff <linkunlink+0x73>
  *b = 'x';
    2642:	07800793          	li	a5,120
    2646:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    264a:	8526                	mv	a0,s1
    264c:	00003097          	auipc	ra,0x3
    2650:	7c6080e7          	jalr	1990(ra) # 5e12 <unlink>
  if(ret != -1){
    2654:	57fd                	li	a5,-1
    2656:	08f51363          	bne	a0,a5,26dc <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    265a:	20100593          	li	a1,513
    265e:	8526                	mv	a0,s1
    2660:	00003097          	auipc	ra,0x3
    2664:	7a2080e7          	jalr	1954(ra) # 5e02 <open>
  if(fd != -1){
    2668:	57fd                	li	a5,-1
    266a:	08f51863          	bne	a0,a5,26fa <copyinstr3+0xf0>
  ret = link(b, b);
    266e:	85a6                	mv	a1,s1
    2670:	8526                	mv	a0,s1
    2672:	00003097          	auipc	ra,0x3
    2676:	7b0080e7          	jalr	1968(ra) # 5e22 <link>
  if(ret != -1){
    267a:	57fd                	li	a5,-1
    267c:	08f51e63          	bne	a0,a5,2718 <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2680:	00005797          	auipc	a5,0x5
    2684:	67878793          	addi	a5,a5,1656 # 7cf8 <malloc+0x1afe>
    2688:	fcf43823          	sd	a5,-48(s0)
    268c:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2690:	fd040593          	addi	a1,s0,-48
    2694:	8526                	mv	a0,s1
    2696:	00003097          	auipc	ra,0x3
    269a:	764080e7          	jalr	1892(ra) # 5dfa <exec>
  if(ret != -1){
    269e:	57fd                	li	a5,-1
    26a0:	08f51c63          	bne	a0,a5,2738 <copyinstr3+0x12e>
}
    26a4:	70a2                	ld	ra,40(sp)
    26a6:	7402                	ld	s0,32(sp)
    26a8:	64e2                	ld	s1,24(sp)
    26aa:	6145                	addi	sp,sp,48
    26ac:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    26ae:	0347d513          	srli	a0,a5,0x34
    26b2:	6785                	lui	a5,0x1
    26b4:	40a7853b          	subw	a0,a5,a0
    26b8:	00003097          	auipc	ra,0x3
    26bc:	792080e7          	jalr	1938(ra) # 5e4a <sbrk>
    26c0:	b7bd                	j	262e <copyinstr3+0x24>
    printf("oops\n");
    26c2:	00005517          	auipc	a0,0x5
    26c6:	95650513          	addi	a0,a0,-1706 # 7018 <malloc+0xe1e>
    26ca:	00004097          	auipc	ra,0x4
    26ce:	a78080e7          	jalr	-1416(ra) # 6142 <printf>
    exit(1);
    26d2:	4505                	li	a0,1
    26d4:	00003097          	auipc	ra,0x3
    26d8:	6ee080e7          	jalr	1774(ra) # 5dc2 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    26dc:	862a                	mv	a2,a0
    26de:	85a6                	mv	a1,s1
    26e0:	00004517          	auipc	a0,0x4
    26e4:	3e050513          	addi	a0,a0,992 # 6ac0 <malloc+0x8c6>
    26e8:	00004097          	auipc	ra,0x4
    26ec:	a5a080e7          	jalr	-1446(ra) # 6142 <printf>
    exit(1);
    26f0:	4505                	li	a0,1
    26f2:	00003097          	auipc	ra,0x3
    26f6:	6d0080e7          	jalr	1744(ra) # 5dc2 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    26fa:	862a                	mv	a2,a0
    26fc:	85a6                	mv	a1,s1
    26fe:	00004517          	auipc	a0,0x4
    2702:	3e250513          	addi	a0,a0,994 # 6ae0 <malloc+0x8e6>
    2706:	00004097          	auipc	ra,0x4
    270a:	a3c080e7          	jalr	-1476(ra) # 6142 <printf>
    exit(1);
    270e:	4505                	li	a0,1
    2710:	00003097          	auipc	ra,0x3
    2714:	6b2080e7          	jalr	1714(ra) # 5dc2 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    2718:	86aa                	mv	a3,a0
    271a:	8626                	mv	a2,s1
    271c:	85a6                	mv	a1,s1
    271e:	00004517          	auipc	a0,0x4
    2722:	3e250513          	addi	a0,a0,994 # 6b00 <malloc+0x906>
    2726:	00004097          	auipc	ra,0x4
    272a:	a1c080e7          	jalr	-1508(ra) # 6142 <printf>
    exit(1);
    272e:	4505                	li	a0,1
    2730:	00003097          	auipc	ra,0x3
    2734:	692080e7          	jalr	1682(ra) # 5dc2 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    2738:	567d                	li	a2,-1
    273a:	85a6                	mv	a1,s1
    273c:	00004517          	auipc	a0,0x4
    2740:	3ec50513          	addi	a0,a0,1004 # 6b28 <malloc+0x92e>
    2744:	00004097          	auipc	ra,0x4
    2748:	9fe080e7          	jalr	-1538(ra) # 6142 <printf>
    exit(1);
    274c:	4505                	li	a0,1
    274e:	00003097          	auipc	ra,0x3
    2752:	674080e7          	jalr	1652(ra) # 5dc2 <exit>

0000000000002756 <rwsbrk>:
{
    2756:	1101                	addi	sp,sp,-32
    2758:	ec06                	sd	ra,24(sp)
    275a:	e822                	sd	s0,16(sp)
    275c:	e426                	sd	s1,8(sp)
    275e:	e04a                	sd	s2,0(sp)
    2760:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    2762:	6509                	lui	a0,0x2
    2764:	00003097          	auipc	ra,0x3
    2768:	6e6080e7          	jalr	1766(ra) # 5e4a <sbrk>
  if(a == 0xffffffffffffffffLL) {
    276c:	57fd                	li	a5,-1
    276e:	06f50263          	beq	a0,a5,27d2 <rwsbrk+0x7c>
    2772:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    2774:	7579                	lui	a0,0xffffe
    2776:	00003097          	auipc	ra,0x3
    277a:	6d4080e7          	jalr	1748(ra) # 5e4a <sbrk>
    277e:	57fd                	li	a5,-1
    2780:	06f50663          	beq	a0,a5,27ec <rwsbrk+0x96>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    2784:	20100593          	li	a1,513
    2788:	00005517          	auipc	a0,0x5
    278c:	8d050513          	addi	a0,a0,-1840 # 7058 <malloc+0xe5e>
    2790:	00003097          	auipc	ra,0x3
    2794:	672080e7          	jalr	1650(ra) # 5e02 <open>
    2798:	892a                	mv	s2,a0
  if(fd < 0){
    279a:	06054663          	bltz	a0,2806 <rwsbrk+0xb0>
  n = write(fd, (void*)(a+4096), 1024);
    279e:	6785                	lui	a5,0x1
    27a0:	94be                	add	s1,s1,a5
    27a2:	40000613          	li	a2,1024
    27a6:	85a6                	mv	a1,s1
    27a8:	00003097          	auipc	ra,0x3
    27ac:	63a080e7          	jalr	1594(ra) # 5de2 <write>
    27b0:	862a                	mv	a2,a0
  if(n >= 0){
    27b2:	06054763          	bltz	a0,2820 <rwsbrk+0xca>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    27b6:	85a6                	mv	a1,s1
    27b8:	00005517          	auipc	a0,0x5
    27bc:	8c050513          	addi	a0,a0,-1856 # 7078 <malloc+0xe7e>
    27c0:	00004097          	auipc	ra,0x4
    27c4:	982080e7          	jalr	-1662(ra) # 6142 <printf>
    exit(1);
    27c8:	4505                	li	a0,1
    27ca:	00003097          	auipc	ra,0x3
    27ce:	5f8080e7          	jalr	1528(ra) # 5dc2 <exit>
    printf("sbrk(rwsbrk) failed\n");
    27d2:	00005517          	auipc	a0,0x5
    27d6:	84e50513          	addi	a0,a0,-1970 # 7020 <malloc+0xe26>
    27da:	00004097          	auipc	ra,0x4
    27de:	968080e7          	jalr	-1688(ra) # 6142 <printf>
    exit(1);
    27e2:	4505                	li	a0,1
    27e4:	00003097          	auipc	ra,0x3
    27e8:	5de080e7          	jalr	1502(ra) # 5dc2 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    27ec:	00005517          	auipc	a0,0x5
    27f0:	84c50513          	addi	a0,a0,-1972 # 7038 <malloc+0xe3e>
    27f4:	00004097          	auipc	ra,0x4
    27f8:	94e080e7          	jalr	-1714(ra) # 6142 <printf>
    exit(1);
    27fc:	4505                	li	a0,1
    27fe:	00003097          	auipc	ra,0x3
    2802:	5c4080e7          	jalr	1476(ra) # 5dc2 <exit>
    printf("open(rwsbrk) failed\n");
    2806:	00005517          	auipc	a0,0x5
    280a:	85a50513          	addi	a0,a0,-1958 # 7060 <malloc+0xe66>
    280e:	00004097          	auipc	ra,0x4
    2812:	934080e7          	jalr	-1740(ra) # 6142 <printf>
    exit(1);
    2816:	4505                	li	a0,1
    2818:	00003097          	auipc	ra,0x3
    281c:	5aa080e7          	jalr	1450(ra) # 5dc2 <exit>
  close(fd);
    2820:	854a                	mv	a0,s2
    2822:	00003097          	auipc	ra,0x3
    2826:	5c8080e7          	jalr	1480(ra) # 5dea <close>
  unlink("rwsbrk");
    282a:	00005517          	auipc	a0,0x5
    282e:	82e50513          	addi	a0,a0,-2002 # 7058 <malloc+0xe5e>
    2832:	00003097          	auipc	ra,0x3
    2836:	5e0080e7          	jalr	1504(ra) # 5e12 <unlink>
  fd = open("README", O_RDONLY);
    283a:	4581                	li	a1,0
    283c:	00004517          	auipc	a0,0x4
    2840:	cb450513          	addi	a0,a0,-844 # 64f0 <malloc+0x2f6>
    2844:	00003097          	auipc	ra,0x3
    2848:	5be080e7          	jalr	1470(ra) # 5e02 <open>
    284c:	892a                	mv	s2,a0
  if(fd < 0){
    284e:	02054963          	bltz	a0,2880 <rwsbrk+0x12a>
  n = read(fd, (void*)(a+4096), 10);
    2852:	4629                	li	a2,10
    2854:	85a6                	mv	a1,s1
    2856:	00003097          	auipc	ra,0x3
    285a:	584080e7          	jalr	1412(ra) # 5dda <read>
    285e:	862a                	mv	a2,a0
  if(n >= 0){
    2860:	02054d63          	bltz	a0,289a <rwsbrk+0x144>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    2864:	85a6                	mv	a1,s1
    2866:	00005517          	auipc	a0,0x5
    286a:	84250513          	addi	a0,a0,-1982 # 70a8 <malloc+0xeae>
    286e:	00004097          	auipc	ra,0x4
    2872:	8d4080e7          	jalr	-1836(ra) # 6142 <printf>
    exit(1);
    2876:	4505                	li	a0,1
    2878:	00003097          	auipc	ra,0x3
    287c:	54a080e7          	jalr	1354(ra) # 5dc2 <exit>
    printf("open(rwsbrk) failed\n");
    2880:	00004517          	auipc	a0,0x4
    2884:	7e050513          	addi	a0,a0,2016 # 7060 <malloc+0xe66>
    2888:	00004097          	auipc	ra,0x4
    288c:	8ba080e7          	jalr	-1862(ra) # 6142 <printf>
    exit(1);
    2890:	4505                	li	a0,1
    2892:	00003097          	auipc	ra,0x3
    2896:	530080e7          	jalr	1328(ra) # 5dc2 <exit>
  close(fd);
    289a:	854a                	mv	a0,s2
    289c:	00003097          	auipc	ra,0x3
    28a0:	54e080e7          	jalr	1358(ra) # 5dea <close>
  exit(0);
    28a4:	4501                	li	a0,0
    28a6:	00003097          	auipc	ra,0x3
    28aa:	51c080e7          	jalr	1308(ra) # 5dc2 <exit>

00000000000028ae <sbrkbasic>:
{
    28ae:	7139                	addi	sp,sp,-64
    28b0:	fc06                	sd	ra,56(sp)
    28b2:	f822                	sd	s0,48(sp)
    28b4:	f426                	sd	s1,40(sp)
    28b6:	f04a                	sd	s2,32(sp)
    28b8:	ec4e                	sd	s3,24(sp)
    28ba:	e852                	sd	s4,16(sp)
    28bc:	0080                	addi	s0,sp,64
    28be:	8a2a                	mv	s4,a0
  pid = fork();
    28c0:	00003097          	auipc	ra,0x3
    28c4:	4fa080e7          	jalr	1274(ra) # 5dba <fork>
  if(pid < 0){
    28c8:	02054c63          	bltz	a0,2900 <sbrkbasic+0x52>
  if(pid == 0){
    28cc:	ed21                	bnez	a0,2924 <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    28ce:	40000537          	lui	a0,0x40000
    28d2:	00003097          	auipc	ra,0x3
    28d6:	578080e7          	jalr	1400(ra) # 5e4a <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    28da:	57fd                	li	a5,-1
    28dc:	02f50f63          	beq	a0,a5,291a <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28e0:	400007b7          	lui	a5,0x40000
    28e4:	97aa                	add	a5,a5,a0
      *b = 99;
    28e6:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    28ea:	6705                	lui	a4,0x1
      *b = 99;
    28ec:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28f0:	953a                	add	a0,a0,a4
    28f2:	fef51de3          	bne	a0,a5,28ec <sbrkbasic+0x3e>
    exit(1);
    28f6:	4505                	li	a0,1
    28f8:	00003097          	auipc	ra,0x3
    28fc:	4ca080e7          	jalr	1226(ra) # 5dc2 <exit>
    printf("fork failed in sbrkbasic\n");
    2900:	00004517          	auipc	a0,0x4
    2904:	7d050513          	addi	a0,a0,2000 # 70d0 <malloc+0xed6>
    2908:	00004097          	auipc	ra,0x4
    290c:	83a080e7          	jalr	-1990(ra) # 6142 <printf>
    exit(1);
    2910:	4505                	li	a0,1
    2912:	00003097          	auipc	ra,0x3
    2916:	4b0080e7          	jalr	1200(ra) # 5dc2 <exit>
      exit(0);
    291a:	4501                	li	a0,0
    291c:	00003097          	auipc	ra,0x3
    2920:	4a6080e7          	jalr	1190(ra) # 5dc2 <exit>
  wait(&xstatus);
    2924:	fcc40513          	addi	a0,s0,-52
    2928:	00003097          	auipc	ra,0x3
    292c:	4a2080e7          	jalr	1186(ra) # 5dca <wait>
  if(xstatus == 1){
    2930:	fcc42703          	lw	a4,-52(s0)
    2934:	4785                	li	a5,1
    2936:	00f70d63          	beq	a4,a5,2950 <sbrkbasic+0xa2>
  a = sbrk(0);
    293a:	4501                	li	a0,0
    293c:	00003097          	auipc	ra,0x3
    2940:	50e080e7          	jalr	1294(ra) # 5e4a <sbrk>
    2944:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2946:	4901                	li	s2,0
    2948:	6985                	lui	s3,0x1
    294a:	38898993          	addi	s3,s3,904 # 1388 <badarg+0x3e>
    294e:	a005                	j	296e <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    2950:	85d2                	mv	a1,s4
    2952:	00004517          	auipc	a0,0x4
    2956:	79e50513          	addi	a0,a0,1950 # 70f0 <malloc+0xef6>
    295a:	00003097          	auipc	ra,0x3
    295e:	7e8080e7          	jalr	2024(ra) # 6142 <printf>
    exit(1);
    2962:	4505                	li	a0,1
    2964:	00003097          	auipc	ra,0x3
    2968:	45e080e7          	jalr	1118(ra) # 5dc2 <exit>
    a = b + 1;
    296c:	84be                	mv	s1,a5
    b = sbrk(1);
    296e:	4505                	li	a0,1
    2970:	00003097          	auipc	ra,0x3
    2974:	4da080e7          	jalr	1242(ra) # 5e4a <sbrk>
    if(b != a){
    2978:	04951c63          	bne	a0,s1,29d0 <sbrkbasic+0x122>
    *b = 1;
    297c:	4785                	li	a5,1
    297e:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    2982:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    2986:	2905                	addiw	s2,s2,1
    2988:	ff3912e3          	bne	s2,s3,296c <sbrkbasic+0xbe>
  pid = fork();
    298c:	00003097          	auipc	ra,0x3
    2990:	42e080e7          	jalr	1070(ra) # 5dba <fork>
    2994:	892a                	mv	s2,a0
  if(pid < 0){
    2996:	04054e63          	bltz	a0,29f2 <sbrkbasic+0x144>
  c = sbrk(1);
    299a:	4505                	li	a0,1
    299c:	00003097          	auipc	ra,0x3
    29a0:	4ae080e7          	jalr	1198(ra) # 5e4a <sbrk>
  c = sbrk(1);
    29a4:	4505                	li	a0,1
    29a6:	00003097          	auipc	ra,0x3
    29aa:	4a4080e7          	jalr	1188(ra) # 5e4a <sbrk>
  if(c != a + 1){
    29ae:	0489                	addi	s1,s1,2
    29b0:	04a48f63          	beq	s1,a0,2a0e <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    29b4:	85d2                	mv	a1,s4
    29b6:	00004517          	auipc	a0,0x4
    29ba:	79a50513          	addi	a0,a0,1946 # 7150 <malloc+0xf56>
    29be:	00003097          	auipc	ra,0x3
    29c2:	784080e7          	jalr	1924(ra) # 6142 <printf>
    exit(1);
    29c6:	4505                	li	a0,1
    29c8:	00003097          	auipc	ra,0x3
    29cc:	3fa080e7          	jalr	1018(ra) # 5dc2 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    29d0:	872a                	mv	a4,a0
    29d2:	86a6                	mv	a3,s1
    29d4:	864a                	mv	a2,s2
    29d6:	85d2                	mv	a1,s4
    29d8:	00004517          	auipc	a0,0x4
    29dc:	73850513          	addi	a0,a0,1848 # 7110 <malloc+0xf16>
    29e0:	00003097          	auipc	ra,0x3
    29e4:	762080e7          	jalr	1890(ra) # 6142 <printf>
      exit(1);
    29e8:	4505                	li	a0,1
    29ea:	00003097          	auipc	ra,0x3
    29ee:	3d8080e7          	jalr	984(ra) # 5dc2 <exit>
    printf("%s: sbrk test fork failed\n", s);
    29f2:	85d2                	mv	a1,s4
    29f4:	00004517          	auipc	a0,0x4
    29f8:	73c50513          	addi	a0,a0,1852 # 7130 <malloc+0xf36>
    29fc:	00003097          	auipc	ra,0x3
    2a00:	746080e7          	jalr	1862(ra) # 6142 <printf>
    exit(1);
    2a04:	4505                	li	a0,1
    2a06:	00003097          	auipc	ra,0x3
    2a0a:	3bc080e7          	jalr	956(ra) # 5dc2 <exit>
  if(pid == 0)
    2a0e:	00091763          	bnez	s2,2a1c <sbrkbasic+0x16e>
    exit(0);
    2a12:	4501                	li	a0,0
    2a14:	00003097          	auipc	ra,0x3
    2a18:	3ae080e7          	jalr	942(ra) # 5dc2 <exit>
  wait(&xstatus);
    2a1c:	fcc40513          	addi	a0,s0,-52
    2a20:	00003097          	auipc	ra,0x3
    2a24:	3aa080e7          	jalr	938(ra) # 5dca <wait>
  exit(xstatus);
    2a28:	fcc42503          	lw	a0,-52(s0)
    2a2c:	00003097          	auipc	ra,0x3
    2a30:	396080e7          	jalr	918(ra) # 5dc2 <exit>

0000000000002a34 <sbrkmuch>:
{
    2a34:	7179                	addi	sp,sp,-48
    2a36:	f406                	sd	ra,40(sp)
    2a38:	f022                	sd	s0,32(sp)
    2a3a:	ec26                	sd	s1,24(sp)
    2a3c:	e84a                	sd	s2,16(sp)
    2a3e:	e44e                	sd	s3,8(sp)
    2a40:	e052                	sd	s4,0(sp)
    2a42:	1800                	addi	s0,sp,48
    2a44:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2a46:	4501                	li	a0,0
    2a48:	00003097          	auipc	ra,0x3
    2a4c:	402080e7          	jalr	1026(ra) # 5e4a <sbrk>
    2a50:	892a                	mv	s2,a0
  a = sbrk(0);
    2a52:	4501                	li	a0,0
    2a54:	00003097          	auipc	ra,0x3
    2a58:	3f6080e7          	jalr	1014(ra) # 5e4a <sbrk>
    2a5c:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2a5e:	06400537          	lui	a0,0x6400
    2a62:	9d05                	subw	a0,a0,s1
    2a64:	00003097          	auipc	ra,0x3
    2a68:	3e6080e7          	jalr	998(ra) # 5e4a <sbrk>
  if (p != a) {
    2a6c:	0ca49863          	bne	s1,a0,2b3c <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2a70:	4501                	li	a0,0
    2a72:	00003097          	auipc	ra,0x3
    2a76:	3d8080e7          	jalr	984(ra) # 5e4a <sbrk>
    2a7a:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2a7c:	00a4f963          	bgeu	s1,a0,2a8e <sbrkmuch+0x5a>
    *pp = 1;
    2a80:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2a82:	6705                	lui	a4,0x1
    *pp = 1;
    2a84:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2a88:	94ba                	add	s1,s1,a4
    2a8a:	fef4ede3          	bltu	s1,a5,2a84 <sbrkmuch+0x50>
  *lastaddr = 99;
    2a8e:	064007b7          	lui	a5,0x6400
    2a92:	06300713          	li	a4,99
    2a96:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2a9a:	4501                	li	a0,0
    2a9c:	00003097          	auipc	ra,0x3
    2aa0:	3ae080e7          	jalr	942(ra) # 5e4a <sbrk>
    2aa4:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2aa6:	757d                	lui	a0,0xfffff
    2aa8:	00003097          	auipc	ra,0x3
    2aac:	3a2080e7          	jalr	930(ra) # 5e4a <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2ab0:	57fd                	li	a5,-1
    2ab2:	0af50363          	beq	a0,a5,2b58 <sbrkmuch+0x124>
  c = sbrk(0);
    2ab6:	4501                	li	a0,0
    2ab8:	00003097          	auipc	ra,0x3
    2abc:	392080e7          	jalr	914(ra) # 5e4a <sbrk>
  if(c != a - PGSIZE){
    2ac0:	77fd                	lui	a5,0xfffff
    2ac2:	97a6                	add	a5,a5,s1
    2ac4:	0af51863          	bne	a0,a5,2b74 <sbrkmuch+0x140>
  a = sbrk(0);
    2ac8:	4501                	li	a0,0
    2aca:	00003097          	auipc	ra,0x3
    2ace:	380080e7          	jalr	896(ra) # 5e4a <sbrk>
    2ad2:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2ad4:	6505                	lui	a0,0x1
    2ad6:	00003097          	auipc	ra,0x3
    2ada:	374080e7          	jalr	884(ra) # 5e4a <sbrk>
    2ade:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2ae0:	0aa49a63          	bne	s1,a0,2b94 <sbrkmuch+0x160>
    2ae4:	4501                	li	a0,0
    2ae6:	00003097          	auipc	ra,0x3
    2aea:	364080e7          	jalr	868(ra) # 5e4a <sbrk>
    2aee:	6785                	lui	a5,0x1
    2af0:	97a6                	add	a5,a5,s1
    2af2:	0af51163          	bne	a0,a5,2b94 <sbrkmuch+0x160>
  if(*lastaddr == 99){
    2af6:	064007b7          	lui	a5,0x6400
    2afa:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    2afe:	06300793          	li	a5,99
    2b02:	0af70963          	beq	a4,a5,2bb4 <sbrkmuch+0x180>
  a = sbrk(0);
    2b06:	4501                	li	a0,0
    2b08:	00003097          	auipc	ra,0x3
    2b0c:	342080e7          	jalr	834(ra) # 5e4a <sbrk>
    2b10:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2b12:	4501                	li	a0,0
    2b14:	00003097          	auipc	ra,0x3
    2b18:	336080e7          	jalr	822(ra) # 5e4a <sbrk>
    2b1c:	40a9053b          	subw	a0,s2,a0
    2b20:	00003097          	auipc	ra,0x3
    2b24:	32a080e7          	jalr	810(ra) # 5e4a <sbrk>
  if(c != a){
    2b28:	0aa49463          	bne	s1,a0,2bd0 <sbrkmuch+0x19c>
}
    2b2c:	70a2                	ld	ra,40(sp)
    2b2e:	7402                	ld	s0,32(sp)
    2b30:	64e2                	ld	s1,24(sp)
    2b32:	6942                	ld	s2,16(sp)
    2b34:	69a2                	ld	s3,8(sp)
    2b36:	6a02                	ld	s4,0(sp)
    2b38:	6145                	addi	sp,sp,48
    2b3a:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2b3c:	85ce                	mv	a1,s3
    2b3e:	00004517          	auipc	a0,0x4
    2b42:	63250513          	addi	a0,a0,1586 # 7170 <malloc+0xf76>
    2b46:	00003097          	auipc	ra,0x3
    2b4a:	5fc080e7          	jalr	1532(ra) # 6142 <printf>
    exit(1);
    2b4e:	4505                	li	a0,1
    2b50:	00003097          	auipc	ra,0x3
    2b54:	272080e7          	jalr	626(ra) # 5dc2 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2b58:	85ce                	mv	a1,s3
    2b5a:	00004517          	auipc	a0,0x4
    2b5e:	65e50513          	addi	a0,a0,1630 # 71b8 <malloc+0xfbe>
    2b62:	00003097          	auipc	ra,0x3
    2b66:	5e0080e7          	jalr	1504(ra) # 6142 <printf>
    exit(1);
    2b6a:	4505                	li	a0,1
    2b6c:	00003097          	auipc	ra,0x3
    2b70:	256080e7          	jalr	598(ra) # 5dc2 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2b74:	86aa                	mv	a3,a0
    2b76:	8626                	mv	a2,s1
    2b78:	85ce                	mv	a1,s3
    2b7a:	00004517          	auipc	a0,0x4
    2b7e:	65e50513          	addi	a0,a0,1630 # 71d8 <malloc+0xfde>
    2b82:	00003097          	auipc	ra,0x3
    2b86:	5c0080e7          	jalr	1472(ra) # 6142 <printf>
    exit(1);
    2b8a:	4505                	li	a0,1
    2b8c:	00003097          	auipc	ra,0x3
    2b90:	236080e7          	jalr	566(ra) # 5dc2 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2b94:	86d2                	mv	a3,s4
    2b96:	8626                	mv	a2,s1
    2b98:	85ce                	mv	a1,s3
    2b9a:	00004517          	auipc	a0,0x4
    2b9e:	67e50513          	addi	a0,a0,1662 # 7218 <malloc+0x101e>
    2ba2:	00003097          	auipc	ra,0x3
    2ba6:	5a0080e7          	jalr	1440(ra) # 6142 <printf>
    exit(1);
    2baa:	4505                	li	a0,1
    2bac:	00003097          	auipc	ra,0x3
    2bb0:	216080e7          	jalr	534(ra) # 5dc2 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2bb4:	85ce                	mv	a1,s3
    2bb6:	00004517          	auipc	a0,0x4
    2bba:	69250513          	addi	a0,a0,1682 # 7248 <malloc+0x104e>
    2bbe:	00003097          	auipc	ra,0x3
    2bc2:	584080e7          	jalr	1412(ra) # 6142 <printf>
    exit(1);
    2bc6:	4505                	li	a0,1
    2bc8:	00003097          	auipc	ra,0x3
    2bcc:	1fa080e7          	jalr	506(ra) # 5dc2 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2bd0:	86aa                	mv	a3,a0
    2bd2:	8626                	mv	a2,s1
    2bd4:	85ce                	mv	a1,s3
    2bd6:	00004517          	auipc	a0,0x4
    2bda:	6aa50513          	addi	a0,a0,1706 # 7280 <malloc+0x1086>
    2bde:	00003097          	auipc	ra,0x3
    2be2:	564080e7          	jalr	1380(ra) # 6142 <printf>
    exit(1);
    2be6:	4505                	li	a0,1
    2be8:	00003097          	auipc	ra,0x3
    2bec:	1da080e7          	jalr	474(ra) # 5dc2 <exit>

0000000000002bf0 <sbrkarg>:
{
    2bf0:	7179                	addi	sp,sp,-48
    2bf2:	f406                	sd	ra,40(sp)
    2bf4:	f022                	sd	s0,32(sp)
    2bf6:	ec26                	sd	s1,24(sp)
    2bf8:	e84a                	sd	s2,16(sp)
    2bfa:	e44e                	sd	s3,8(sp)
    2bfc:	1800                	addi	s0,sp,48
    2bfe:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2c00:	6505                	lui	a0,0x1
    2c02:	00003097          	auipc	ra,0x3
    2c06:	248080e7          	jalr	584(ra) # 5e4a <sbrk>
    2c0a:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2c0c:	20100593          	li	a1,513
    2c10:	00004517          	auipc	a0,0x4
    2c14:	69850513          	addi	a0,a0,1688 # 72a8 <malloc+0x10ae>
    2c18:	00003097          	auipc	ra,0x3
    2c1c:	1ea080e7          	jalr	490(ra) # 5e02 <open>
    2c20:	84aa                	mv	s1,a0
  unlink("sbrk");
    2c22:	00004517          	auipc	a0,0x4
    2c26:	68650513          	addi	a0,a0,1670 # 72a8 <malloc+0x10ae>
    2c2a:	00003097          	auipc	ra,0x3
    2c2e:	1e8080e7          	jalr	488(ra) # 5e12 <unlink>
  if(fd < 0)  {
    2c32:	0404c163          	bltz	s1,2c74 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2c36:	6605                	lui	a2,0x1
    2c38:	85ca                	mv	a1,s2
    2c3a:	8526                	mv	a0,s1
    2c3c:	00003097          	auipc	ra,0x3
    2c40:	1a6080e7          	jalr	422(ra) # 5de2 <write>
    2c44:	04054663          	bltz	a0,2c90 <sbrkarg+0xa0>
  close(fd);
    2c48:	8526                	mv	a0,s1
    2c4a:	00003097          	auipc	ra,0x3
    2c4e:	1a0080e7          	jalr	416(ra) # 5dea <close>
  a = sbrk(PGSIZE);
    2c52:	6505                	lui	a0,0x1
    2c54:	00003097          	auipc	ra,0x3
    2c58:	1f6080e7          	jalr	502(ra) # 5e4a <sbrk>
  if(pipe((int *) a) != 0){
    2c5c:	00003097          	auipc	ra,0x3
    2c60:	176080e7          	jalr	374(ra) # 5dd2 <pipe>
    2c64:	e521                	bnez	a0,2cac <sbrkarg+0xbc>
}
    2c66:	70a2                	ld	ra,40(sp)
    2c68:	7402                	ld	s0,32(sp)
    2c6a:	64e2                	ld	s1,24(sp)
    2c6c:	6942                	ld	s2,16(sp)
    2c6e:	69a2                	ld	s3,8(sp)
    2c70:	6145                	addi	sp,sp,48
    2c72:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2c74:	85ce                	mv	a1,s3
    2c76:	00004517          	auipc	a0,0x4
    2c7a:	63a50513          	addi	a0,a0,1594 # 72b0 <malloc+0x10b6>
    2c7e:	00003097          	auipc	ra,0x3
    2c82:	4c4080e7          	jalr	1220(ra) # 6142 <printf>
    exit(1);
    2c86:	4505                	li	a0,1
    2c88:	00003097          	auipc	ra,0x3
    2c8c:	13a080e7          	jalr	314(ra) # 5dc2 <exit>
    printf("%s: write sbrk failed\n", s);
    2c90:	85ce                	mv	a1,s3
    2c92:	00004517          	auipc	a0,0x4
    2c96:	63650513          	addi	a0,a0,1590 # 72c8 <malloc+0x10ce>
    2c9a:	00003097          	auipc	ra,0x3
    2c9e:	4a8080e7          	jalr	1192(ra) # 6142 <printf>
    exit(1);
    2ca2:	4505                	li	a0,1
    2ca4:	00003097          	auipc	ra,0x3
    2ca8:	11e080e7          	jalr	286(ra) # 5dc2 <exit>
    printf("%s: pipe() failed\n", s);
    2cac:	85ce                	mv	a1,s3
    2cae:	00004517          	auipc	a0,0x4
    2cb2:	ffa50513          	addi	a0,a0,-6 # 6ca8 <malloc+0xaae>
    2cb6:	00003097          	auipc	ra,0x3
    2cba:	48c080e7          	jalr	1164(ra) # 6142 <printf>
    exit(1);
    2cbe:	4505                	li	a0,1
    2cc0:	00003097          	auipc	ra,0x3
    2cc4:	102080e7          	jalr	258(ra) # 5dc2 <exit>

0000000000002cc8 <argptest>:
{
    2cc8:	1101                	addi	sp,sp,-32
    2cca:	ec06                	sd	ra,24(sp)
    2ccc:	e822                	sd	s0,16(sp)
    2cce:	e426                	sd	s1,8(sp)
    2cd0:	e04a                	sd	s2,0(sp)
    2cd2:	1000                	addi	s0,sp,32
    2cd4:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2cd6:	4581                	li	a1,0
    2cd8:	00004517          	auipc	a0,0x4
    2cdc:	60850513          	addi	a0,a0,1544 # 72e0 <malloc+0x10e6>
    2ce0:	00003097          	auipc	ra,0x3
    2ce4:	122080e7          	jalr	290(ra) # 5e02 <open>
  if (fd < 0) {
    2ce8:	02054b63          	bltz	a0,2d1e <argptest+0x56>
    2cec:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2cee:	4501                	li	a0,0
    2cf0:	00003097          	auipc	ra,0x3
    2cf4:	15a080e7          	jalr	346(ra) # 5e4a <sbrk>
    2cf8:	567d                	li	a2,-1
    2cfa:	fff50593          	addi	a1,a0,-1
    2cfe:	8526                	mv	a0,s1
    2d00:	00003097          	auipc	ra,0x3
    2d04:	0da080e7          	jalr	218(ra) # 5dda <read>
  close(fd);
    2d08:	8526                	mv	a0,s1
    2d0a:	00003097          	auipc	ra,0x3
    2d0e:	0e0080e7          	jalr	224(ra) # 5dea <close>
}
    2d12:	60e2                	ld	ra,24(sp)
    2d14:	6442                	ld	s0,16(sp)
    2d16:	64a2                	ld	s1,8(sp)
    2d18:	6902                	ld	s2,0(sp)
    2d1a:	6105                	addi	sp,sp,32
    2d1c:	8082                	ret
    printf("%s: open failed\n", s);
    2d1e:	85ca                	mv	a1,s2
    2d20:	00004517          	auipc	a0,0x4
    2d24:	e9850513          	addi	a0,a0,-360 # 6bb8 <malloc+0x9be>
    2d28:	00003097          	auipc	ra,0x3
    2d2c:	41a080e7          	jalr	1050(ra) # 6142 <printf>
    exit(1);
    2d30:	4505                	li	a0,1
    2d32:	00003097          	auipc	ra,0x3
    2d36:	090080e7          	jalr	144(ra) # 5dc2 <exit>

0000000000002d3a <sbrkbugs>:
{
    2d3a:	1141                	addi	sp,sp,-16
    2d3c:	e406                	sd	ra,8(sp)
    2d3e:	e022                	sd	s0,0(sp)
    2d40:	0800                	addi	s0,sp,16
  int pid = fork();
    2d42:	00003097          	auipc	ra,0x3
    2d46:	078080e7          	jalr	120(ra) # 5dba <fork>
  if(pid < 0){
    2d4a:	02054263          	bltz	a0,2d6e <sbrkbugs+0x34>
  if(pid == 0){
    2d4e:	ed0d                	bnez	a0,2d88 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2d50:	00003097          	auipc	ra,0x3
    2d54:	0fa080e7          	jalr	250(ra) # 5e4a <sbrk>
    sbrk(-sz);
    2d58:	40a0053b          	negw	a0,a0
    2d5c:	00003097          	auipc	ra,0x3
    2d60:	0ee080e7          	jalr	238(ra) # 5e4a <sbrk>
    exit(0);
    2d64:	4501                	li	a0,0
    2d66:	00003097          	auipc	ra,0x3
    2d6a:	05c080e7          	jalr	92(ra) # 5dc2 <exit>
    printf("fork failed\n");
    2d6e:	00004517          	auipc	a0,0x4
    2d72:	23a50513          	addi	a0,a0,570 # 6fa8 <malloc+0xdae>
    2d76:	00003097          	auipc	ra,0x3
    2d7a:	3cc080e7          	jalr	972(ra) # 6142 <printf>
    exit(1);
    2d7e:	4505                	li	a0,1
    2d80:	00003097          	auipc	ra,0x3
    2d84:	042080e7          	jalr	66(ra) # 5dc2 <exit>
  wait(0);
    2d88:	4501                	li	a0,0
    2d8a:	00003097          	auipc	ra,0x3
    2d8e:	040080e7          	jalr	64(ra) # 5dca <wait>
  pid = fork();
    2d92:	00003097          	auipc	ra,0x3
    2d96:	028080e7          	jalr	40(ra) # 5dba <fork>
  if(pid < 0){
    2d9a:	02054563          	bltz	a0,2dc4 <sbrkbugs+0x8a>
  if(pid == 0){
    2d9e:	e121                	bnez	a0,2dde <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2da0:	00003097          	auipc	ra,0x3
    2da4:	0aa080e7          	jalr	170(ra) # 5e4a <sbrk>
    sbrk(-(sz - 3500));
    2da8:	6785                	lui	a5,0x1
    2daa:	dac7879b          	addiw	a5,a5,-596 # dac <unlinkread+0x6e>
    2dae:	40a7853b          	subw	a0,a5,a0
    2db2:	00003097          	auipc	ra,0x3
    2db6:	098080e7          	jalr	152(ra) # 5e4a <sbrk>
    exit(0);
    2dba:	4501                	li	a0,0
    2dbc:	00003097          	auipc	ra,0x3
    2dc0:	006080e7          	jalr	6(ra) # 5dc2 <exit>
    printf("fork failed\n");
    2dc4:	00004517          	auipc	a0,0x4
    2dc8:	1e450513          	addi	a0,a0,484 # 6fa8 <malloc+0xdae>
    2dcc:	00003097          	auipc	ra,0x3
    2dd0:	376080e7          	jalr	886(ra) # 6142 <printf>
    exit(1);
    2dd4:	4505                	li	a0,1
    2dd6:	00003097          	auipc	ra,0x3
    2dda:	fec080e7          	jalr	-20(ra) # 5dc2 <exit>
  wait(0);
    2dde:	4501                	li	a0,0
    2de0:	00003097          	auipc	ra,0x3
    2de4:	fea080e7          	jalr	-22(ra) # 5dca <wait>
  pid = fork();
    2de8:	00003097          	auipc	ra,0x3
    2dec:	fd2080e7          	jalr	-46(ra) # 5dba <fork>
  if(pid < 0){
    2df0:	02054a63          	bltz	a0,2e24 <sbrkbugs+0xea>
  if(pid == 0){
    2df4:	e529                	bnez	a0,2e3e <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2df6:	00003097          	auipc	ra,0x3
    2dfa:	054080e7          	jalr	84(ra) # 5e4a <sbrk>
    2dfe:	67ad                	lui	a5,0xb
    2e00:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x298>
    2e04:	40a7853b          	subw	a0,a5,a0
    2e08:	00003097          	auipc	ra,0x3
    2e0c:	042080e7          	jalr	66(ra) # 5e4a <sbrk>
    sbrk(-10);
    2e10:	5559                	li	a0,-10
    2e12:	00003097          	auipc	ra,0x3
    2e16:	038080e7          	jalr	56(ra) # 5e4a <sbrk>
    exit(0);
    2e1a:	4501                	li	a0,0
    2e1c:	00003097          	auipc	ra,0x3
    2e20:	fa6080e7          	jalr	-90(ra) # 5dc2 <exit>
    printf("fork failed\n");
    2e24:	00004517          	auipc	a0,0x4
    2e28:	18450513          	addi	a0,a0,388 # 6fa8 <malloc+0xdae>
    2e2c:	00003097          	auipc	ra,0x3
    2e30:	316080e7          	jalr	790(ra) # 6142 <printf>
    exit(1);
    2e34:	4505                	li	a0,1
    2e36:	00003097          	auipc	ra,0x3
    2e3a:	f8c080e7          	jalr	-116(ra) # 5dc2 <exit>
  wait(0);
    2e3e:	4501                	li	a0,0
    2e40:	00003097          	auipc	ra,0x3
    2e44:	f8a080e7          	jalr	-118(ra) # 5dca <wait>
  exit(0);
    2e48:	4501                	li	a0,0
    2e4a:	00003097          	auipc	ra,0x3
    2e4e:	f78080e7          	jalr	-136(ra) # 5dc2 <exit>

0000000000002e52 <sbrklast>:
{
    2e52:	7179                	addi	sp,sp,-48
    2e54:	f406                	sd	ra,40(sp)
    2e56:	f022                	sd	s0,32(sp)
    2e58:	ec26                	sd	s1,24(sp)
    2e5a:	e84a                	sd	s2,16(sp)
    2e5c:	e44e                	sd	s3,8(sp)
    2e5e:	e052                	sd	s4,0(sp)
    2e60:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2e62:	4501                	li	a0,0
    2e64:	00003097          	auipc	ra,0x3
    2e68:	fe6080e7          	jalr	-26(ra) # 5e4a <sbrk>
  if((top % 4096) != 0)
    2e6c:	03451793          	slli	a5,a0,0x34
    2e70:	ebd9                	bnez	a5,2f06 <sbrklast+0xb4>
  sbrk(4096);
    2e72:	6505                	lui	a0,0x1
    2e74:	00003097          	auipc	ra,0x3
    2e78:	fd6080e7          	jalr	-42(ra) # 5e4a <sbrk>
  sbrk(10);
    2e7c:	4529                	li	a0,10
    2e7e:	00003097          	auipc	ra,0x3
    2e82:	fcc080e7          	jalr	-52(ra) # 5e4a <sbrk>
  sbrk(-20);
    2e86:	5531                	li	a0,-20
    2e88:	00003097          	auipc	ra,0x3
    2e8c:	fc2080e7          	jalr	-62(ra) # 5e4a <sbrk>
  top = (uint64) sbrk(0);
    2e90:	4501                	li	a0,0
    2e92:	00003097          	auipc	ra,0x3
    2e96:	fb8080e7          	jalr	-72(ra) # 5e4a <sbrk>
    2e9a:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2e9c:	fc050913          	addi	s2,a0,-64 # fc0 <linktest+0xcc>
  p[0] = 'x';
    2ea0:	07800a13          	li	s4,120
    2ea4:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2ea8:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2eac:	20200593          	li	a1,514
    2eb0:	854a                	mv	a0,s2
    2eb2:	00003097          	auipc	ra,0x3
    2eb6:	f50080e7          	jalr	-176(ra) # 5e02 <open>
    2eba:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2ebc:	4605                	li	a2,1
    2ebe:	85ca                	mv	a1,s2
    2ec0:	00003097          	auipc	ra,0x3
    2ec4:	f22080e7          	jalr	-222(ra) # 5de2 <write>
  close(fd);
    2ec8:	854e                	mv	a0,s3
    2eca:	00003097          	auipc	ra,0x3
    2ece:	f20080e7          	jalr	-224(ra) # 5dea <close>
  fd = open(p, O_RDWR);
    2ed2:	4589                	li	a1,2
    2ed4:	854a                	mv	a0,s2
    2ed6:	00003097          	auipc	ra,0x3
    2eda:	f2c080e7          	jalr	-212(ra) # 5e02 <open>
  p[0] = '\0';
    2ede:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2ee2:	4605                	li	a2,1
    2ee4:	85ca                	mv	a1,s2
    2ee6:	00003097          	auipc	ra,0x3
    2eea:	ef4080e7          	jalr	-268(ra) # 5dda <read>
  if(p[0] != 'x')
    2eee:	fc04c783          	lbu	a5,-64(s1)
    2ef2:	03479463          	bne	a5,s4,2f1a <sbrklast+0xc8>
}
    2ef6:	70a2                	ld	ra,40(sp)
    2ef8:	7402                	ld	s0,32(sp)
    2efa:	64e2                	ld	s1,24(sp)
    2efc:	6942                	ld	s2,16(sp)
    2efe:	69a2                	ld	s3,8(sp)
    2f00:	6a02                	ld	s4,0(sp)
    2f02:	6145                	addi	sp,sp,48
    2f04:	8082                	ret
    sbrk(4096 - (top % 4096));
    2f06:	0347d513          	srli	a0,a5,0x34
    2f0a:	6785                	lui	a5,0x1
    2f0c:	40a7853b          	subw	a0,a5,a0
    2f10:	00003097          	auipc	ra,0x3
    2f14:	f3a080e7          	jalr	-198(ra) # 5e4a <sbrk>
    2f18:	bfa9                	j	2e72 <sbrklast+0x20>
    exit(1);
    2f1a:	4505                	li	a0,1
    2f1c:	00003097          	auipc	ra,0x3
    2f20:	ea6080e7          	jalr	-346(ra) # 5dc2 <exit>

0000000000002f24 <sbrk8000>:
{
    2f24:	1141                	addi	sp,sp,-16
    2f26:	e406                	sd	ra,8(sp)
    2f28:	e022                	sd	s0,0(sp)
    2f2a:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2f2c:	80000537          	lui	a0,0x80000
    2f30:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff038c>
    2f32:	00003097          	auipc	ra,0x3
    2f36:	f18080e7          	jalr	-232(ra) # 5e4a <sbrk>
  volatile char *top = sbrk(0);
    2f3a:	4501                	li	a0,0
    2f3c:	00003097          	auipc	ra,0x3
    2f40:	f0e080e7          	jalr	-242(ra) # 5e4a <sbrk>
  *(top-1) = *(top-1) + 1;
    2f44:	fff54783          	lbu	a5,-1(a0)
    2f48:	2785                	addiw	a5,a5,1 # 1001 <linktest+0x10d>
    2f4a:	0ff7f793          	zext.b	a5,a5
    2f4e:	fef50fa3          	sb	a5,-1(a0)
}
    2f52:	60a2                	ld	ra,8(sp)
    2f54:	6402                	ld	s0,0(sp)
    2f56:	0141                	addi	sp,sp,16
    2f58:	8082                	ret

0000000000002f5a <execout>:
{
    2f5a:	715d                	addi	sp,sp,-80
    2f5c:	e486                	sd	ra,72(sp)
    2f5e:	e0a2                	sd	s0,64(sp)
    2f60:	fc26                	sd	s1,56(sp)
    2f62:	f84a                	sd	s2,48(sp)
    2f64:	f44e                	sd	s3,40(sp)
    2f66:	f052                	sd	s4,32(sp)
    2f68:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2f6a:	4901                	li	s2,0
    2f6c:	49bd                	li	s3,15
    int pid = fork();
    2f6e:	00003097          	auipc	ra,0x3
    2f72:	e4c080e7          	jalr	-436(ra) # 5dba <fork>
    2f76:	84aa                	mv	s1,a0
    if(pid < 0){
    2f78:	02054063          	bltz	a0,2f98 <execout+0x3e>
    } else if(pid == 0){
    2f7c:	c91d                	beqz	a0,2fb2 <execout+0x58>
      wait((int*)0);
    2f7e:	4501                	li	a0,0
    2f80:	00003097          	auipc	ra,0x3
    2f84:	e4a080e7          	jalr	-438(ra) # 5dca <wait>
  for(int avail = 0; avail < 15; avail++){
    2f88:	2905                	addiw	s2,s2,1
    2f8a:	ff3912e3          	bne	s2,s3,2f6e <execout+0x14>
  exit(0);
    2f8e:	4501                	li	a0,0
    2f90:	00003097          	auipc	ra,0x3
    2f94:	e32080e7          	jalr	-462(ra) # 5dc2 <exit>
      printf("fork failed\n");
    2f98:	00004517          	auipc	a0,0x4
    2f9c:	01050513          	addi	a0,a0,16 # 6fa8 <malloc+0xdae>
    2fa0:	00003097          	auipc	ra,0x3
    2fa4:	1a2080e7          	jalr	418(ra) # 6142 <printf>
      exit(1);
    2fa8:	4505                	li	a0,1
    2faa:	00003097          	auipc	ra,0x3
    2fae:	e18080e7          	jalr	-488(ra) # 5dc2 <exit>
        if(a == 0xffffffffffffffffLL)
    2fb2:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2fb4:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2fb6:	6505                	lui	a0,0x1
    2fb8:	00003097          	auipc	ra,0x3
    2fbc:	e92080e7          	jalr	-366(ra) # 5e4a <sbrk>
        if(a == 0xffffffffffffffffLL)
    2fc0:	01350763          	beq	a0,s3,2fce <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2fc4:	6785                	lui	a5,0x1
    2fc6:	97aa                	add	a5,a5,a0
    2fc8:	ff478fa3          	sb	s4,-1(a5) # fff <linktest+0x10b>
      while(1){
    2fcc:	b7ed                	j	2fb6 <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2fce:	01205a63          	blez	s2,2fe2 <execout+0x88>
        sbrk(-4096);
    2fd2:	757d                	lui	a0,0xfffff
    2fd4:	00003097          	auipc	ra,0x3
    2fd8:	e76080e7          	jalr	-394(ra) # 5e4a <sbrk>
      for(int i = 0; i < avail; i++)
    2fdc:	2485                	addiw	s1,s1,1
    2fde:	ff249ae3          	bne	s1,s2,2fd2 <execout+0x78>
      close(1);
    2fe2:	4505                	li	a0,1
    2fe4:	00003097          	auipc	ra,0x3
    2fe8:	e06080e7          	jalr	-506(ra) # 5dea <close>
      char *args[] = { "echo", "x", 0 };
    2fec:	00003517          	auipc	a0,0x3
    2ff0:	32c50513          	addi	a0,a0,812 # 6318 <malloc+0x11e>
    2ff4:	faa43c23          	sd	a0,-72(s0)
    2ff8:	00003797          	auipc	a5,0x3
    2ffc:	39078793          	addi	a5,a5,912 # 6388 <malloc+0x18e>
    3000:	fcf43023          	sd	a5,-64(s0)
    3004:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    3008:	fb840593          	addi	a1,s0,-72
    300c:	00003097          	auipc	ra,0x3
    3010:	dee080e7          	jalr	-530(ra) # 5dfa <exec>
      exit(0);
    3014:	4501                	li	a0,0
    3016:	00003097          	auipc	ra,0x3
    301a:	dac080e7          	jalr	-596(ra) # 5dc2 <exit>

000000000000301e <fourteen>:
{
    301e:	1101                	addi	sp,sp,-32
    3020:	ec06                	sd	ra,24(sp)
    3022:	e822                	sd	s0,16(sp)
    3024:	e426                	sd	s1,8(sp)
    3026:	1000                	addi	s0,sp,32
    3028:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    302a:	00004517          	auipc	a0,0x4
    302e:	48e50513          	addi	a0,a0,1166 # 74b8 <malloc+0x12be>
    3032:	00003097          	auipc	ra,0x3
    3036:	df8080e7          	jalr	-520(ra) # 5e2a <mkdir>
    303a:	e165                	bnez	a0,311a <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    303c:	00004517          	auipc	a0,0x4
    3040:	2d450513          	addi	a0,a0,724 # 7310 <malloc+0x1116>
    3044:	00003097          	auipc	ra,0x3
    3048:	de6080e7          	jalr	-538(ra) # 5e2a <mkdir>
    304c:	e56d                	bnez	a0,3136 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    304e:	20000593          	li	a1,512
    3052:	00004517          	auipc	a0,0x4
    3056:	31650513          	addi	a0,a0,790 # 7368 <malloc+0x116e>
    305a:	00003097          	auipc	ra,0x3
    305e:	da8080e7          	jalr	-600(ra) # 5e02 <open>
  if(fd < 0){
    3062:	0e054863          	bltz	a0,3152 <fourteen+0x134>
  close(fd);
    3066:	00003097          	auipc	ra,0x3
    306a:	d84080e7          	jalr	-636(ra) # 5dea <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    306e:	4581                	li	a1,0
    3070:	00004517          	auipc	a0,0x4
    3074:	37050513          	addi	a0,a0,880 # 73e0 <malloc+0x11e6>
    3078:	00003097          	auipc	ra,0x3
    307c:	d8a080e7          	jalr	-630(ra) # 5e02 <open>
  if(fd < 0){
    3080:	0e054763          	bltz	a0,316e <fourteen+0x150>
  close(fd);
    3084:	00003097          	auipc	ra,0x3
    3088:	d66080e7          	jalr	-666(ra) # 5dea <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    308c:	00004517          	auipc	a0,0x4
    3090:	3c450513          	addi	a0,a0,964 # 7450 <malloc+0x1256>
    3094:	00003097          	auipc	ra,0x3
    3098:	d96080e7          	jalr	-618(ra) # 5e2a <mkdir>
    309c:	c57d                	beqz	a0,318a <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    309e:	00004517          	auipc	a0,0x4
    30a2:	40a50513          	addi	a0,a0,1034 # 74a8 <malloc+0x12ae>
    30a6:	00003097          	auipc	ra,0x3
    30aa:	d84080e7          	jalr	-636(ra) # 5e2a <mkdir>
    30ae:	cd65                	beqz	a0,31a6 <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    30b0:	00004517          	auipc	a0,0x4
    30b4:	3f850513          	addi	a0,a0,1016 # 74a8 <malloc+0x12ae>
    30b8:	00003097          	auipc	ra,0x3
    30bc:	d5a080e7          	jalr	-678(ra) # 5e12 <unlink>
  unlink("12345678901234/12345678901234");
    30c0:	00004517          	auipc	a0,0x4
    30c4:	39050513          	addi	a0,a0,912 # 7450 <malloc+0x1256>
    30c8:	00003097          	auipc	ra,0x3
    30cc:	d4a080e7          	jalr	-694(ra) # 5e12 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    30d0:	00004517          	auipc	a0,0x4
    30d4:	31050513          	addi	a0,a0,784 # 73e0 <malloc+0x11e6>
    30d8:	00003097          	auipc	ra,0x3
    30dc:	d3a080e7          	jalr	-710(ra) # 5e12 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    30e0:	00004517          	auipc	a0,0x4
    30e4:	28850513          	addi	a0,a0,648 # 7368 <malloc+0x116e>
    30e8:	00003097          	auipc	ra,0x3
    30ec:	d2a080e7          	jalr	-726(ra) # 5e12 <unlink>
  unlink("12345678901234/123456789012345");
    30f0:	00004517          	auipc	a0,0x4
    30f4:	22050513          	addi	a0,a0,544 # 7310 <malloc+0x1116>
    30f8:	00003097          	auipc	ra,0x3
    30fc:	d1a080e7          	jalr	-742(ra) # 5e12 <unlink>
  unlink("12345678901234");
    3100:	00004517          	auipc	a0,0x4
    3104:	3b850513          	addi	a0,a0,952 # 74b8 <malloc+0x12be>
    3108:	00003097          	auipc	ra,0x3
    310c:	d0a080e7          	jalr	-758(ra) # 5e12 <unlink>
}
    3110:	60e2                	ld	ra,24(sp)
    3112:	6442                	ld	s0,16(sp)
    3114:	64a2                	ld	s1,8(sp)
    3116:	6105                	addi	sp,sp,32
    3118:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    311a:	85a6                	mv	a1,s1
    311c:	00004517          	auipc	a0,0x4
    3120:	1cc50513          	addi	a0,a0,460 # 72e8 <malloc+0x10ee>
    3124:	00003097          	auipc	ra,0x3
    3128:	01e080e7          	jalr	30(ra) # 6142 <printf>
    exit(1);
    312c:	4505                	li	a0,1
    312e:	00003097          	auipc	ra,0x3
    3132:	c94080e7          	jalr	-876(ra) # 5dc2 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    3136:	85a6                	mv	a1,s1
    3138:	00004517          	auipc	a0,0x4
    313c:	1f850513          	addi	a0,a0,504 # 7330 <malloc+0x1136>
    3140:	00003097          	auipc	ra,0x3
    3144:	002080e7          	jalr	2(ra) # 6142 <printf>
    exit(1);
    3148:	4505                	li	a0,1
    314a:	00003097          	auipc	ra,0x3
    314e:	c78080e7          	jalr	-904(ra) # 5dc2 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    3152:	85a6                	mv	a1,s1
    3154:	00004517          	auipc	a0,0x4
    3158:	24450513          	addi	a0,a0,580 # 7398 <malloc+0x119e>
    315c:	00003097          	auipc	ra,0x3
    3160:	fe6080e7          	jalr	-26(ra) # 6142 <printf>
    exit(1);
    3164:	4505                	li	a0,1
    3166:	00003097          	auipc	ra,0x3
    316a:	c5c080e7          	jalr	-932(ra) # 5dc2 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    316e:	85a6                	mv	a1,s1
    3170:	00004517          	auipc	a0,0x4
    3174:	2a050513          	addi	a0,a0,672 # 7410 <malloc+0x1216>
    3178:	00003097          	auipc	ra,0x3
    317c:	fca080e7          	jalr	-54(ra) # 6142 <printf>
    exit(1);
    3180:	4505                	li	a0,1
    3182:	00003097          	auipc	ra,0x3
    3186:	c40080e7          	jalr	-960(ra) # 5dc2 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    318a:	85a6                	mv	a1,s1
    318c:	00004517          	auipc	a0,0x4
    3190:	2e450513          	addi	a0,a0,740 # 7470 <malloc+0x1276>
    3194:	00003097          	auipc	ra,0x3
    3198:	fae080e7          	jalr	-82(ra) # 6142 <printf>
    exit(1);
    319c:	4505                	li	a0,1
    319e:	00003097          	auipc	ra,0x3
    31a2:	c24080e7          	jalr	-988(ra) # 5dc2 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    31a6:	85a6                	mv	a1,s1
    31a8:	00004517          	auipc	a0,0x4
    31ac:	32050513          	addi	a0,a0,800 # 74c8 <malloc+0x12ce>
    31b0:	00003097          	auipc	ra,0x3
    31b4:	f92080e7          	jalr	-110(ra) # 6142 <printf>
    exit(1);
    31b8:	4505                	li	a0,1
    31ba:	00003097          	auipc	ra,0x3
    31be:	c08080e7          	jalr	-1016(ra) # 5dc2 <exit>

00000000000031c2 <diskfull>:
{
    31c2:	b9010113          	addi	sp,sp,-1136
    31c6:	46113423          	sd	ra,1128(sp)
    31ca:	46813023          	sd	s0,1120(sp)
    31ce:	44913c23          	sd	s1,1112(sp)
    31d2:	45213823          	sd	s2,1104(sp)
    31d6:	45313423          	sd	s3,1096(sp)
    31da:	45413023          	sd	s4,1088(sp)
    31de:	43513c23          	sd	s5,1080(sp)
    31e2:	43613823          	sd	s6,1072(sp)
    31e6:	43713423          	sd	s7,1064(sp)
    31ea:	43813023          	sd	s8,1056(sp)
    31ee:	47010413          	addi	s0,sp,1136
    31f2:	8c2a                	mv	s8,a0
  unlink("diskfulldir");
    31f4:	00004517          	auipc	a0,0x4
    31f8:	30c50513          	addi	a0,a0,780 # 7500 <malloc+0x1306>
    31fc:	00003097          	auipc	ra,0x3
    3200:	c16080e7          	jalr	-1002(ra) # 5e12 <unlink>
  for(fi = 0; done == 0; fi++){
    3204:	4a01                	li	s4,0
    name[0] = 'b';
    3206:	06200b13          	li	s6,98
    name[1] = 'i';
    320a:	06900a93          	li	s5,105
    name[2] = 'g';
    320e:	06700993          	li	s3,103
    3212:	10c00b93          	li	s7,268
    3216:	aabd                	j	3394 <diskfull+0x1d2>
      printf("%s: could not create file %s\n", s, name);
    3218:	b9040613          	addi	a2,s0,-1136
    321c:	85e2                	mv	a1,s8
    321e:	00004517          	auipc	a0,0x4
    3222:	2f250513          	addi	a0,a0,754 # 7510 <malloc+0x1316>
    3226:	00003097          	auipc	ra,0x3
    322a:	f1c080e7          	jalr	-228(ra) # 6142 <printf>
      break;
    322e:	a821                	j	3246 <diskfull+0x84>
        close(fd);
    3230:	854a                	mv	a0,s2
    3232:	00003097          	auipc	ra,0x3
    3236:	bb8080e7          	jalr	-1096(ra) # 5dea <close>
    close(fd);
    323a:	854a                	mv	a0,s2
    323c:	00003097          	auipc	ra,0x3
    3240:	bae080e7          	jalr	-1106(ra) # 5dea <close>
  for(fi = 0; done == 0; fi++){
    3244:	2a05                	addiw	s4,s4,1
  for(int i = 0; i < nzz; i++){
    3246:	4481                	li	s1,0
    name[0] = 'z';
    3248:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    324c:	08000993          	li	s3,128
    name[0] = 'z';
    3250:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    3254:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    3258:	41f4d71b          	sraiw	a4,s1,0x1f
    325c:	01b7571b          	srliw	a4,a4,0x1b
    3260:	009707bb          	addw	a5,a4,s1
    3264:	4057d69b          	sraiw	a3,a5,0x5
    3268:	0306869b          	addiw	a3,a3,48
    326c:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    3270:	8bfd                	andi	a5,a5,31
    3272:	9f99                	subw	a5,a5,a4
    3274:	0307879b          	addiw	a5,a5,48
    3278:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    327c:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3280:	bb040513          	addi	a0,s0,-1104
    3284:	00003097          	auipc	ra,0x3
    3288:	b8e080e7          	jalr	-1138(ra) # 5e12 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    328c:	60200593          	li	a1,1538
    3290:	bb040513          	addi	a0,s0,-1104
    3294:	00003097          	auipc	ra,0x3
    3298:	b6e080e7          	jalr	-1170(ra) # 5e02 <open>
    if(fd < 0)
    329c:	00054963          	bltz	a0,32ae <diskfull+0xec>
    close(fd);
    32a0:	00003097          	auipc	ra,0x3
    32a4:	b4a080e7          	jalr	-1206(ra) # 5dea <close>
  for(int i = 0; i < nzz; i++){
    32a8:	2485                	addiw	s1,s1,1
    32aa:	fb3493e3          	bne	s1,s3,3250 <diskfull+0x8e>
  if(mkdir("diskfulldir") == 0)
    32ae:	00004517          	auipc	a0,0x4
    32b2:	25250513          	addi	a0,a0,594 # 7500 <malloc+0x1306>
    32b6:	00003097          	auipc	ra,0x3
    32ba:	b74080e7          	jalr	-1164(ra) # 5e2a <mkdir>
    32be:	12050963          	beqz	a0,33f0 <diskfull+0x22e>
  unlink("diskfulldir");
    32c2:	00004517          	auipc	a0,0x4
    32c6:	23e50513          	addi	a0,a0,574 # 7500 <malloc+0x1306>
    32ca:	00003097          	auipc	ra,0x3
    32ce:	b48080e7          	jalr	-1208(ra) # 5e12 <unlink>
  for(int i = 0; i < nzz; i++){
    32d2:	4481                	li	s1,0
    name[0] = 'z';
    32d4:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    32d8:	08000993          	li	s3,128
    name[0] = 'z';
    32dc:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    32e0:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    32e4:	41f4d71b          	sraiw	a4,s1,0x1f
    32e8:	01b7571b          	srliw	a4,a4,0x1b
    32ec:	009707bb          	addw	a5,a4,s1
    32f0:	4057d69b          	sraiw	a3,a5,0x5
    32f4:	0306869b          	addiw	a3,a3,48
    32f8:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    32fc:	8bfd                	andi	a5,a5,31
    32fe:	9f99                	subw	a5,a5,a4
    3300:	0307879b          	addiw	a5,a5,48
    3304:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3308:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    330c:	bb040513          	addi	a0,s0,-1104
    3310:	00003097          	auipc	ra,0x3
    3314:	b02080e7          	jalr	-1278(ra) # 5e12 <unlink>
  for(int i = 0; i < nzz; i++){
    3318:	2485                	addiw	s1,s1,1
    331a:	fd3491e3          	bne	s1,s3,32dc <diskfull+0x11a>
  for(int i = 0; i < fi; i++){
    331e:	03405e63          	blez	s4,335a <diskfull+0x198>
    3322:	4481                	li	s1,0
    name[0] = 'b';
    3324:	06200a93          	li	s5,98
    name[1] = 'i';
    3328:	06900993          	li	s3,105
    name[2] = 'g';
    332c:	06700913          	li	s2,103
    name[0] = 'b';
    3330:	bb540823          	sb	s5,-1104(s0)
    name[1] = 'i';
    3334:	bb3408a3          	sb	s3,-1103(s0)
    name[2] = 'g';
    3338:	bb240923          	sb	s2,-1102(s0)
    name[3] = '0' + i;
    333c:	0304879b          	addiw	a5,s1,48
    3340:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3344:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3348:	bb040513          	addi	a0,s0,-1104
    334c:	00003097          	auipc	ra,0x3
    3350:	ac6080e7          	jalr	-1338(ra) # 5e12 <unlink>
  for(int i = 0; i < fi; i++){
    3354:	2485                	addiw	s1,s1,1
    3356:	fd449de3          	bne	s1,s4,3330 <diskfull+0x16e>
}
    335a:	46813083          	ld	ra,1128(sp)
    335e:	46013403          	ld	s0,1120(sp)
    3362:	45813483          	ld	s1,1112(sp)
    3366:	45013903          	ld	s2,1104(sp)
    336a:	44813983          	ld	s3,1096(sp)
    336e:	44013a03          	ld	s4,1088(sp)
    3372:	43813a83          	ld	s5,1080(sp)
    3376:	43013b03          	ld	s6,1072(sp)
    337a:	42813b83          	ld	s7,1064(sp)
    337e:	42013c03          	ld	s8,1056(sp)
    3382:	47010113          	addi	sp,sp,1136
    3386:	8082                	ret
    close(fd);
    3388:	854a                	mv	a0,s2
    338a:	00003097          	auipc	ra,0x3
    338e:	a60080e7          	jalr	-1440(ra) # 5dea <close>
  for(fi = 0; done == 0; fi++){
    3392:	2a05                	addiw	s4,s4,1
    name[0] = 'b';
    3394:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    3398:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    339c:	b9340923          	sb	s3,-1134(s0)
    name[3] = '0' + fi;
    33a0:	030a079b          	addiw	a5,s4,48
    33a4:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    33a8:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    33ac:	b9040513          	addi	a0,s0,-1136
    33b0:	00003097          	auipc	ra,0x3
    33b4:	a62080e7          	jalr	-1438(ra) # 5e12 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    33b8:	60200593          	li	a1,1538
    33bc:	b9040513          	addi	a0,s0,-1136
    33c0:	00003097          	auipc	ra,0x3
    33c4:	a42080e7          	jalr	-1470(ra) # 5e02 <open>
    33c8:	892a                	mv	s2,a0
    if(fd < 0){
    33ca:	e40547e3          	bltz	a0,3218 <diskfull+0x56>
    33ce:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    33d0:	40000613          	li	a2,1024
    33d4:	bb040593          	addi	a1,s0,-1104
    33d8:	854a                	mv	a0,s2
    33da:	00003097          	auipc	ra,0x3
    33de:	a08080e7          	jalr	-1528(ra) # 5de2 <write>
    33e2:	40000793          	li	a5,1024
    33e6:	e4f515e3          	bne	a0,a5,3230 <diskfull+0x6e>
    for(int i = 0; i < MAXFILE; i++){
    33ea:	34fd                	addiw	s1,s1,-1
    33ec:	f0f5                	bnez	s1,33d0 <diskfull+0x20e>
    33ee:	bf69                	j	3388 <diskfull+0x1c6>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    33f0:	00004517          	auipc	a0,0x4
    33f4:	14050513          	addi	a0,a0,320 # 7530 <malloc+0x1336>
    33f8:	00003097          	auipc	ra,0x3
    33fc:	d4a080e7          	jalr	-694(ra) # 6142 <printf>
    3400:	b5c9                	j	32c2 <diskfull+0x100>

0000000000003402 <iputtest>:
{
    3402:	1101                	addi	sp,sp,-32
    3404:	ec06                	sd	ra,24(sp)
    3406:	e822                	sd	s0,16(sp)
    3408:	e426                	sd	s1,8(sp)
    340a:	1000                	addi	s0,sp,32
    340c:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    340e:	00004517          	auipc	a0,0x4
    3412:	15250513          	addi	a0,a0,338 # 7560 <malloc+0x1366>
    3416:	00003097          	auipc	ra,0x3
    341a:	a14080e7          	jalr	-1516(ra) # 5e2a <mkdir>
    341e:	04054563          	bltz	a0,3468 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    3422:	00004517          	auipc	a0,0x4
    3426:	13e50513          	addi	a0,a0,318 # 7560 <malloc+0x1366>
    342a:	00003097          	auipc	ra,0x3
    342e:	a08080e7          	jalr	-1528(ra) # 5e32 <chdir>
    3432:	04054963          	bltz	a0,3484 <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    3436:	00004517          	auipc	a0,0x4
    343a:	16a50513          	addi	a0,a0,362 # 75a0 <malloc+0x13a6>
    343e:	00003097          	auipc	ra,0x3
    3442:	9d4080e7          	jalr	-1580(ra) # 5e12 <unlink>
    3446:	04054d63          	bltz	a0,34a0 <iputtest+0x9e>
  if(chdir("/") < 0){
    344a:	00004517          	auipc	a0,0x4
    344e:	18650513          	addi	a0,a0,390 # 75d0 <malloc+0x13d6>
    3452:	00003097          	auipc	ra,0x3
    3456:	9e0080e7          	jalr	-1568(ra) # 5e32 <chdir>
    345a:	06054163          	bltz	a0,34bc <iputtest+0xba>
}
    345e:	60e2                	ld	ra,24(sp)
    3460:	6442                	ld	s0,16(sp)
    3462:	64a2                	ld	s1,8(sp)
    3464:	6105                	addi	sp,sp,32
    3466:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3468:	85a6                	mv	a1,s1
    346a:	00004517          	auipc	a0,0x4
    346e:	0fe50513          	addi	a0,a0,254 # 7568 <malloc+0x136e>
    3472:	00003097          	auipc	ra,0x3
    3476:	cd0080e7          	jalr	-816(ra) # 6142 <printf>
    exit(1);
    347a:	4505                	li	a0,1
    347c:	00003097          	auipc	ra,0x3
    3480:	946080e7          	jalr	-1722(ra) # 5dc2 <exit>
    printf("%s: chdir iputdir failed\n", s);
    3484:	85a6                	mv	a1,s1
    3486:	00004517          	auipc	a0,0x4
    348a:	0fa50513          	addi	a0,a0,250 # 7580 <malloc+0x1386>
    348e:	00003097          	auipc	ra,0x3
    3492:	cb4080e7          	jalr	-844(ra) # 6142 <printf>
    exit(1);
    3496:	4505                	li	a0,1
    3498:	00003097          	auipc	ra,0x3
    349c:	92a080e7          	jalr	-1750(ra) # 5dc2 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    34a0:	85a6                	mv	a1,s1
    34a2:	00004517          	auipc	a0,0x4
    34a6:	10e50513          	addi	a0,a0,270 # 75b0 <malloc+0x13b6>
    34aa:	00003097          	auipc	ra,0x3
    34ae:	c98080e7          	jalr	-872(ra) # 6142 <printf>
    exit(1);
    34b2:	4505                	li	a0,1
    34b4:	00003097          	auipc	ra,0x3
    34b8:	90e080e7          	jalr	-1778(ra) # 5dc2 <exit>
    printf("%s: chdir / failed\n", s);
    34bc:	85a6                	mv	a1,s1
    34be:	00004517          	auipc	a0,0x4
    34c2:	11a50513          	addi	a0,a0,282 # 75d8 <malloc+0x13de>
    34c6:	00003097          	auipc	ra,0x3
    34ca:	c7c080e7          	jalr	-900(ra) # 6142 <printf>
    exit(1);
    34ce:	4505                	li	a0,1
    34d0:	00003097          	auipc	ra,0x3
    34d4:	8f2080e7          	jalr	-1806(ra) # 5dc2 <exit>

00000000000034d8 <exitiputtest>:
{
    34d8:	7179                	addi	sp,sp,-48
    34da:	f406                	sd	ra,40(sp)
    34dc:	f022                	sd	s0,32(sp)
    34de:	ec26                	sd	s1,24(sp)
    34e0:	1800                	addi	s0,sp,48
    34e2:	84aa                	mv	s1,a0
  pid = fork();
    34e4:	00003097          	auipc	ra,0x3
    34e8:	8d6080e7          	jalr	-1834(ra) # 5dba <fork>
  if(pid < 0){
    34ec:	04054663          	bltz	a0,3538 <exitiputtest+0x60>
  if(pid == 0){
    34f0:	ed45                	bnez	a0,35a8 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    34f2:	00004517          	auipc	a0,0x4
    34f6:	06e50513          	addi	a0,a0,110 # 7560 <malloc+0x1366>
    34fa:	00003097          	auipc	ra,0x3
    34fe:	930080e7          	jalr	-1744(ra) # 5e2a <mkdir>
    3502:	04054963          	bltz	a0,3554 <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    3506:	00004517          	auipc	a0,0x4
    350a:	05a50513          	addi	a0,a0,90 # 7560 <malloc+0x1366>
    350e:	00003097          	auipc	ra,0x3
    3512:	924080e7          	jalr	-1756(ra) # 5e32 <chdir>
    3516:	04054d63          	bltz	a0,3570 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    351a:	00004517          	auipc	a0,0x4
    351e:	08650513          	addi	a0,a0,134 # 75a0 <malloc+0x13a6>
    3522:	00003097          	auipc	ra,0x3
    3526:	8f0080e7          	jalr	-1808(ra) # 5e12 <unlink>
    352a:	06054163          	bltz	a0,358c <exitiputtest+0xb4>
    exit(0);
    352e:	4501                	li	a0,0
    3530:	00003097          	auipc	ra,0x3
    3534:	892080e7          	jalr	-1902(ra) # 5dc2 <exit>
    printf("%s: fork failed\n", s);
    3538:	85a6                	mv	a1,s1
    353a:	00003517          	auipc	a0,0x3
    353e:	66650513          	addi	a0,a0,1638 # 6ba0 <malloc+0x9a6>
    3542:	00003097          	auipc	ra,0x3
    3546:	c00080e7          	jalr	-1024(ra) # 6142 <printf>
    exit(1);
    354a:	4505                	li	a0,1
    354c:	00003097          	auipc	ra,0x3
    3550:	876080e7          	jalr	-1930(ra) # 5dc2 <exit>
      printf("%s: mkdir failed\n", s);
    3554:	85a6                	mv	a1,s1
    3556:	00004517          	auipc	a0,0x4
    355a:	01250513          	addi	a0,a0,18 # 7568 <malloc+0x136e>
    355e:	00003097          	auipc	ra,0x3
    3562:	be4080e7          	jalr	-1052(ra) # 6142 <printf>
      exit(1);
    3566:	4505                	li	a0,1
    3568:	00003097          	auipc	ra,0x3
    356c:	85a080e7          	jalr	-1958(ra) # 5dc2 <exit>
      printf("%s: child chdir failed\n", s);
    3570:	85a6                	mv	a1,s1
    3572:	00004517          	auipc	a0,0x4
    3576:	07e50513          	addi	a0,a0,126 # 75f0 <malloc+0x13f6>
    357a:	00003097          	auipc	ra,0x3
    357e:	bc8080e7          	jalr	-1080(ra) # 6142 <printf>
      exit(1);
    3582:	4505                	li	a0,1
    3584:	00003097          	auipc	ra,0x3
    3588:	83e080e7          	jalr	-1986(ra) # 5dc2 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    358c:	85a6                	mv	a1,s1
    358e:	00004517          	auipc	a0,0x4
    3592:	02250513          	addi	a0,a0,34 # 75b0 <malloc+0x13b6>
    3596:	00003097          	auipc	ra,0x3
    359a:	bac080e7          	jalr	-1108(ra) # 6142 <printf>
      exit(1);
    359e:	4505                	li	a0,1
    35a0:	00003097          	auipc	ra,0x3
    35a4:	822080e7          	jalr	-2014(ra) # 5dc2 <exit>
  wait(&xstatus);
    35a8:	fdc40513          	addi	a0,s0,-36
    35ac:	00003097          	auipc	ra,0x3
    35b0:	81e080e7          	jalr	-2018(ra) # 5dca <wait>
  exit(xstatus);
    35b4:	fdc42503          	lw	a0,-36(s0)
    35b8:	00003097          	auipc	ra,0x3
    35bc:	80a080e7          	jalr	-2038(ra) # 5dc2 <exit>

00000000000035c0 <dirtest>:
{
    35c0:	1101                	addi	sp,sp,-32
    35c2:	ec06                	sd	ra,24(sp)
    35c4:	e822                	sd	s0,16(sp)
    35c6:	e426                	sd	s1,8(sp)
    35c8:	1000                	addi	s0,sp,32
    35ca:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    35cc:	00004517          	auipc	a0,0x4
    35d0:	03c50513          	addi	a0,a0,60 # 7608 <malloc+0x140e>
    35d4:	00003097          	auipc	ra,0x3
    35d8:	856080e7          	jalr	-1962(ra) # 5e2a <mkdir>
    35dc:	04054563          	bltz	a0,3626 <dirtest+0x66>
  if(chdir("dir0") < 0){
    35e0:	00004517          	auipc	a0,0x4
    35e4:	02850513          	addi	a0,a0,40 # 7608 <malloc+0x140e>
    35e8:	00003097          	auipc	ra,0x3
    35ec:	84a080e7          	jalr	-1974(ra) # 5e32 <chdir>
    35f0:	04054963          	bltz	a0,3642 <dirtest+0x82>
  if(chdir("..") < 0){
    35f4:	00004517          	auipc	a0,0x4
    35f8:	03450513          	addi	a0,a0,52 # 7628 <malloc+0x142e>
    35fc:	00003097          	auipc	ra,0x3
    3600:	836080e7          	jalr	-1994(ra) # 5e32 <chdir>
    3604:	04054d63          	bltz	a0,365e <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3608:	00004517          	auipc	a0,0x4
    360c:	00050513          	mv	a0,a0
    3610:	00003097          	auipc	ra,0x3
    3614:	802080e7          	jalr	-2046(ra) # 5e12 <unlink>
    3618:	06054163          	bltz	a0,367a <dirtest+0xba>
}
    361c:	60e2                	ld	ra,24(sp)
    361e:	6442                	ld	s0,16(sp)
    3620:	64a2                	ld	s1,8(sp)
    3622:	6105                	addi	sp,sp,32
    3624:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3626:	85a6                	mv	a1,s1
    3628:	00004517          	auipc	a0,0x4
    362c:	f4050513          	addi	a0,a0,-192 # 7568 <malloc+0x136e>
    3630:	00003097          	auipc	ra,0x3
    3634:	b12080e7          	jalr	-1262(ra) # 6142 <printf>
    exit(1);
    3638:	4505                	li	a0,1
    363a:	00002097          	auipc	ra,0x2
    363e:	788080e7          	jalr	1928(ra) # 5dc2 <exit>
    printf("%s: chdir dir0 failed\n", s);
    3642:	85a6                	mv	a1,s1
    3644:	00004517          	auipc	a0,0x4
    3648:	fcc50513          	addi	a0,a0,-52 # 7610 <malloc+0x1416>
    364c:	00003097          	auipc	ra,0x3
    3650:	af6080e7          	jalr	-1290(ra) # 6142 <printf>
    exit(1);
    3654:	4505                	li	a0,1
    3656:	00002097          	auipc	ra,0x2
    365a:	76c080e7          	jalr	1900(ra) # 5dc2 <exit>
    printf("%s: chdir .. failed\n", s);
    365e:	85a6                	mv	a1,s1
    3660:	00004517          	auipc	a0,0x4
    3664:	fd050513          	addi	a0,a0,-48 # 7630 <malloc+0x1436>
    3668:	00003097          	auipc	ra,0x3
    366c:	ada080e7          	jalr	-1318(ra) # 6142 <printf>
    exit(1);
    3670:	4505                	li	a0,1
    3672:	00002097          	auipc	ra,0x2
    3676:	750080e7          	jalr	1872(ra) # 5dc2 <exit>
    printf("%s: unlink dir0 failed\n", s);
    367a:	85a6                	mv	a1,s1
    367c:	00004517          	auipc	a0,0x4
    3680:	fcc50513          	addi	a0,a0,-52 # 7648 <malloc+0x144e>
    3684:	00003097          	auipc	ra,0x3
    3688:	abe080e7          	jalr	-1346(ra) # 6142 <printf>
    exit(1);
    368c:	4505                	li	a0,1
    368e:	00002097          	auipc	ra,0x2
    3692:	734080e7          	jalr	1844(ra) # 5dc2 <exit>

0000000000003696 <subdir>:
{
    3696:	1101                	addi	sp,sp,-32
    3698:	ec06                	sd	ra,24(sp)
    369a:	e822                	sd	s0,16(sp)
    369c:	e426                	sd	s1,8(sp)
    369e:	e04a                	sd	s2,0(sp)
    36a0:	1000                	addi	s0,sp,32
    36a2:	892a                	mv	s2,a0
  unlink("ff");
    36a4:	00004517          	auipc	a0,0x4
    36a8:	0ec50513          	addi	a0,a0,236 # 7790 <malloc+0x1596>
    36ac:	00002097          	auipc	ra,0x2
    36b0:	766080e7          	jalr	1894(ra) # 5e12 <unlink>
  if(mkdir("dd") != 0){
    36b4:	00004517          	auipc	a0,0x4
    36b8:	fac50513          	addi	a0,a0,-84 # 7660 <malloc+0x1466>
    36bc:	00002097          	auipc	ra,0x2
    36c0:	76e080e7          	jalr	1902(ra) # 5e2a <mkdir>
    36c4:	38051663          	bnez	a0,3a50 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    36c8:	20200593          	li	a1,514
    36cc:	00004517          	auipc	a0,0x4
    36d0:	fb450513          	addi	a0,a0,-76 # 7680 <malloc+0x1486>
    36d4:	00002097          	auipc	ra,0x2
    36d8:	72e080e7          	jalr	1838(ra) # 5e02 <open>
    36dc:	84aa                	mv	s1,a0
  if(fd < 0){
    36de:	38054763          	bltz	a0,3a6c <subdir+0x3d6>
  write(fd, "ff", 2);
    36e2:	4609                	li	a2,2
    36e4:	00004597          	auipc	a1,0x4
    36e8:	0ac58593          	addi	a1,a1,172 # 7790 <malloc+0x1596>
    36ec:	00002097          	auipc	ra,0x2
    36f0:	6f6080e7          	jalr	1782(ra) # 5de2 <write>
  close(fd);
    36f4:	8526                	mv	a0,s1
    36f6:	00002097          	auipc	ra,0x2
    36fa:	6f4080e7          	jalr	1780(ra) # 5dea <close>
  if(unlink("dd") >= 0){
    36fe:	00004517          	auipc	a0,0x4
    3702:	f6250513          	addi	a0,a0,-158 # 7660 <malloc+0x1466>
    3706:	00002097          	auipc	ra,0x2
    370a:	70c080e7          	jalr	1804(ra) # 5e12 <unlink>
    370e:	36055d63          	bgez	a0,3a88 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    3712:	00004517          	auipc	a0,0x4
    3716:	fc650513          	addi	a0,a0,-58 # 76d8 <malloc+0x14de>
    371a:	00002097          	auipc	ra,0x2
    371e:	710080e7          	jalr	1808(ra) # 5e2a <mkdir>
    3722:	38051163          	bnez	a0,3aa4 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3726:	20200593          	li	a1,514
    372a:	00004517          	auipc	a0,0x4
    372e:	fd650513          	addi	a0,a0,-42 # 7700 <malloc+0x1506>
    3732:	00002097          	auipc	ra,0x2
    3736:	6d0080e7          	jalr	1744(ra) # 5e02 <open>
    373a:	84aa                	mv	s1,a0
  if(fd < 0){
    373c:	38054263          	bltz	a0,3ac0 <subdir+0x42a>
  write(fd, "FF", 2);
    3740:	4609                	li	a2,2
    3742:	00004597          	auipc	a1,0x4
    3746:	fee58593          	addi	a1,a1,-18 # 7730 <malloc+0x1536>
    374a:	00002097          	auipc	ra,0x2
    374e:	698080e7          	jalr	1688(ra) # 5de2 <write>
  close(fd);
    3752:	8526                	mv	a0,s1
    3754:	00002097          	auipc	ra,0x2
    3758:	696080e7          	jalr	1686(ra) # 5dea <close>
  fd = open("dd/dd/../ff", 0);
    375c:	4581                	li	a1,0
    375e:	00004517          	auipc	a0,0x4
    3762:	fda50513          	addi	a0,a0,-38 # 7738 <malloc+0x153e>
    3766:	00002097          	auipc	ra,0x2
    376a:	69c080e7          	jalr	1692(ra) # 5e02 <open>
    376e:	84aa                	mv	s1,a0
  if(fd < 0){
    3770:	36054663          	bltz	a0,3adc <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    3774:	660d                	lui	a2,0x3
    3776:	00009597          	auipc	a1,0x9
    377a:	50258593          	addi	a1,a1,1282 # cc78 <buf>
    377e:	00002097          	auipc	ra,0x2
    3782:	65c080e7          	jalr	1628(ra) # 5dda <read>
  if(cc != 2 || buf[0] != 'f'){
    3786:	4789                	li	a5,2
    3788:	36f51863          	bne	a0,a5,3af8 <subdir+0x462>
    378c:	00009717          	auipc	a4,0x9
    3790:	4ec74703          	lbu	a4,1260(a4) # cc78 <buf>
    3794:	06600793          	li	a5,102
    3798:	36f71063          	bne	a4,a5,3af8 <subdir+0x462>
  close(fd);
    379c:	8526                	mv	a0,s1
    379e:	00002097          	auipc	ra,0x2
    37a2:	64c080e7          	jalr	1612(ra) # 5dea <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    37a6:	00004597          	auipc	a1,0x4
    37aa:	fe258593          	addi	a1,a1,-30 # 7788 <malloc+0x158e>
    37ae:	00004517          	auipc	a0,0x4
    37b2:	f5250513          	addi	a0,a0,-174 # 7700 <malloc+0x1506>
    37b6:	00002097          	auipc	ra,0x2
    37ba:	66c080e7          	jalr	1644(ra) # 5e22 <link>
    37be:	34051b63          	bnez	a0,3b14 <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    37c2:	00004517          	auipc	a0,0x4
    37c6:	f3e50513          	addi	a0,a0,-194 # 7700 <malloc+0x1506>
    37ca:	00002097          	auipc	ra,0x2
    37ce:	648080e7          	jalr	1608(ra) # 5e12 <unlink>
    37d2:	34051f63          	bnez	a0,3b30 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    37d6:	4581                	li	a1,0
    37d8:	00004517          	auipc	a0,0x4
    37dc:	f2850513          	addi	a0,a0,-216 # 7700 <malloc+0x1506>
    37e0:	00002097          	auipc	ra,0x2
    37e4:	622080e7          	jalr	1570(ra) # 5e02 <open>
    37e8:	36055263          	bgez	a0,3b4c <subdir+0x4b6>
  if(chdir("dd") != 0){
    37ec:	00004517          	auipc	a0,0x4
    37f0:	e7450513          	addi	a0,a0,-396 # 7660 <malloc+0x1466>
    37f4:	00002097          	auipc	ra,0x2
    37f8:	63e080e7          	jalr	1598(ra) # 5e32 <chdir>
    37fc:	36051663          	bnez	a0,3b68 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    3800:	00004517          	auipc	a0,0x4
    3804:	02050513          	addi	a0,a0,32 # 7820 <malloc+0x1626>
    3808:	00002097          	auipc	ra,0x2
    380c:	62a080e7          	jalr	1578(ra) # 5e32 <chdir>
    3810:	36051a63          	bnez	a0,3b84 <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    3814:	00004517          	auipc	a0,0x4
    3818:	03c50513          	addi	a0,a0,60 # 7850 <malloc+0x1656>
    381c:	00002097          	auipc	ra,0x2
    3820:	616080e7          	jalr	1558(ra) # 5e32 <chdir>
    3824:	36051e63          	bnez	a0,3ba0 <subdir+0x50a>
  if(chdir("./..") != 0){
    3828:	00004517          	auipc	a0,0x4
    382c:	05850513          	addi	a0,a0,88 # 7880 <malloc+0x1686>
    3830:	00002097          	auipc	ra,0x2
    3834:	602080e7          	jalr	1538(ra) # 5e32 <chdir>
    3838:	38051263          	bnez	a0,3bbc <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    383c:	4581                	li	a1,0
    383e:	00004517          	auipc	a0,0x4
    3842:	f4a50513          	addi	a0,a0,-182 # 7788 <malloc+0x158e>
    3846:	00002097          	auipc	ra,0x2
    384a:	5bc080e7          	jalr	1468(ra) # 5e02 <open>
    384e:	84aa                	mv	s1,a0
  if(fd < 0){
    3850:	38054463          	bltz	a0,3bd8 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    3854:	660d                	lui	a2,0x3
    3856:	00009597          	auipc	a1,0x9
    385a:	42258593          	addi	a1,a1,1058 # cc78 <buf>
    385e:	00002097          	auipc	ra,0x2
    3862:	57c080e7          	jalr	1404(ra) # 5dda <read>
    3866:	4789                	li	a5,2
    3868:	38f51663          	bne	a0,a5,3bf4 <subdir+0x55e>
  close(fd);
    386c:	8526                	mv	a0,s1
    386e:	00002097          	auipc	ra,0x2
    3872:	57c080e7          	jalr	1404(ra) # 5dea <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3876:	4581                	li	a1,0
    3878:	00004517          	auipc	a0,0x4
    387c:	e8850513          	addi	a0,a0,-376 # 7700 <malloc+0x1506>
    3880:	00002097          	auipc	ra,0x2
    3884:	582080e7          	jalr	1410(ra) # 5e02 <open>
    3888:	38055463          	bgez	a0,3c10 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    388c:	20200593          	li	a1,514
    3890:	00004517          	auipc	a0,0x4
    3894:	08050513          	addi	a0,a0,128 # 7910 <malloc+0x1716>
    3898:	00002097          	auipc	ra,0x2
    389c:	56a080e7          	jalr	1386(ra) # 5e02 <open>
    38a0:	38055663          	bgez	a0,3c2c <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    38a4:	20200593          	li	a1,514
    38a8:	00004517          	auipc	a0,0x4
    38ac:	09850513          	addi	a0,a0,152 # 7940 <malloc+0x1746>
    38b0:	00002097          	auipc	ra,0x2
    38b4:	552080e7          	jalr	1362(ra) # 5e02 <open>
    38b8:	38055863          	bgez	a0,3c48 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    38bc:	20000593          	li	a1,512
    38c0:	00004517          	auipc	a0,0x4
    38c4:	da050513          	addi	a0,a0,-608 # 7660 <malloc+0x1466>
    38c8:	00002097          	auipc	ra,0x2
    38cc:	53a080e7          	jalr	1338(ra) # 5e02 <open>
    38d0:	38055a63          	bgez	a0,3c64 <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    38d4:	4589                	li	a1,2
    38d6:	00004517          	auipc	a0,0x4
    38da:	d8a50513          	addi	a0,a0,-630 # 7660 <malloc+0x1466>
    38de:	00002097          	auipc	ra,0x2
    38e2:	524080e7          	jalr	1316(ra) # 5e02 <open>
    38e6:	38055d63          	bgez	a0,3c80 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    38ea:	4585                	li	a1,1
    38ec:	00004517          	auipc	a0,0x4
    38f0:	d7450513          	addi	a0,a0,-652 # 7660 <malloc+0x1466>
    38f4:	00002097          	auipc	ra,0x2
    38f8:	50e080e7          	jalr	1294(ra) # 5e02 <open>
    38fc:	3a055063          	bgez	a0,3c9c <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3900:	00004597          	auipc	a1,0x4
    3904:	0d058593          	addi	a1,a1,208 # 79d0 <malloc+0x17d6>
    3908:	00004517          	auipc	a0,0x4
    390c:	00850513          	addi	a0,a0,8 # 7910 <malloc+0x1716>
    3910:	00002097          	auipc	ra,0x2
    3914:	512080e7          	jalr	1298(ra) # 5e22 <link>
    3918:	3a050063          	beqz	a0,3cb8 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    391c:	00004597          	auipc	a1,0x4
    3920:	0b458593          	addi	a1,a1,180 # 79d0 <malloc+0x17d6>
    3924:	00004517          	auipc	a0,0x4
    3928:	01c50513          	addi	a0,a0,28 # 7940 <malloc+0x1746>
    392c:	00002097          	auipc	ra,0x2
    3930:	4f6080e7          	jalr	1270(ra) # 5e22 <link>
    3934:	3a050063          	beqz	a0,3cd4 <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3938:	00004597          	auipc	a1,0x4
    393c:	e5058593          	addi	a1,a1,-432 # 7788 <malloc+0x158e>
    3940:	00004517          	auipc	a0,0x4
    3944:	d4050513          	addi	a0,a0,-704 # 7680 <malloc+0x1486>
    3948:	00002097          	auipc	ra,0x2
    394c:	4da080e7          	jalr	1242(ra) # 5e22 <link>
    3950:	3a050063          	beqz	a0,3cf0 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    3954:	00004517          	auipc	a0,0x4
    3958:	fbc50513          	addi	a0,a0,-68 # 7910 <malloc+0x1716>
    395c:	00002097          	auipc	ra,0x2
    3960:	4ce080e7          	jalr	1230(ra) # 5e2a <mkdir>
    3964:	3a050463          	beqz	a0,3d0c <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    3968:	00004517          	auipc	a0,0x4
    396c:	fd850513          	addi	a0,a0,-40 # 7940 <malloc+0x1746>
    3970:	00002097          	auipc	ra,0x2
    3974:	4ba080e7          	jalr	1210(ra) # 5e2a <mkdir>
    3978:	3a050863          	beqz	a0,3d28 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    397c:	00004517          	auipc	a0,0x4
    3980:	e0c50513          	addi	a0,a0,-500 # 7788 <malloc+0x158e>
    3984:	00002097          	auipc	ra,0x2
    3988:	4a6080e7          	jalr	1190(ra) # 5e2a <mkdir>
    398c:	3a050c63          	beqz	a0,3d44 <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    3990:	00004517          	auipc	a0,0x4
    3994:	fb050513          	addi	a0,a0,-80 # 7940 <malloc+0x1746>
    3998:	00002097          	auipc	ra,0x2
    399c:	47a080e7          	jalr	1146(ra) # 5e12 <unlink>
    39a0:	3c050063          	beqz	a0,3d60 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    39a4:	00004517          	auipc	a0,0x4
    39a8:	f6c50513          	addi	a0,a0,-148 # 7910 <malloc+0x1716>
    39ac:	00002097          	auipc	ra,0x2
    39b0:	466080e7          	jalr	1126(ra) # 5e12 <unlink>
    39b4:	3c050463          	beqz	a0,3d7c <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    39b8:	00004517          	auipc	a0,0x4
    39bc:	cc850513          	addi	a0,a0,-824 # 7680 <malloc+0x1486>
    39c0:	00002097          	auipc	ra,0x2
    39c4:	472080e7          	jalr	1138(ra) # 5e32 <chdir>
    39c8:	3c050863          	beqz	a0,3d98 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    39cc:	00004517          	auipc	a0,0x4
    39d0:	15450513          	addi	a0,a0,340 # 7b20 <malloc+0x1926>
    39d4:	00002097          	auipc	ra,0x2
    39d8:	45e080e7          	jalr	1118(ra) # 5e32 <chdir>
    39dc:	3c050c63          	beqz	a0,3db4 <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    39e0:	00004517          	auipc	a0,0x4
    39e4:	da850513          	addi	a0,a0,-600 # 7788 <malloc+0x158e>
    39e8:	00002097          	auipc	ra,0x2
    39ec:	42a080e7          	jalr	1066(ra) # 5e12 <unlink>
    39f0:	3e051063          	bnez	a0,3dd0 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    39f4:	00004517          	auipc	a0,0x4
    39f8:	c8c50513          	addi	a0,a0,-884 # 7680 <malloc+0x1486>
    39fc:	00002097          	auipc	ra,0x2
    3a00:	416080e7          	jalr	1046(ra) # 5e12 <unlink>
    3a04:	3e051463          	bnez	a0,3dec <subdir+0x756>
  if(unlink("dd") == 0){
    3a08:	00004517          	auipc	a0,0x4
    3a0c:	c5850513          	addi	a0,a0,-936 # 7660 <malloc+0x1466>
    3a10:	00002097          	auipc	ra,0x2
    3a14:	402080e7          	jalr	1026(ra) # 5e12 <unlink>
    3a18:	3e050863          	beqz	a0,3e08 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3a1c:	00004517          	auipc	a0,0x4
    3a20:	17450513          	addi	a0,a0,372 # 7b90 <malloc+0x1996>
    3a24:	00002097          	auipc	ra,0x2
    3a28:	3ee080e7          	jalr	1006(ra) # 5e12 <unlink>
    3a2c:	3e054c63          	bltz	a0,3e24 <subdir+0x78e>
  if(unlink("dd") < 0){
    3a30:	00004517          	auipc	a0,0x4
    3a34:	c3050513          	addi	a0,a0,-976 # 7660 <malloc+0x1466>
    3a38:	00002097          	auipc	ra,0x2
    3a3c:	3da080e7          	jalr	986(ra) # 5e12 <unlink>
    3a40:	40054063          	bltz	a0,3e40 <subdir+0x7aa>
}
    3a44:	60e2                	ld	ra,24(sp)
    3a46:	6442                	ld	s0,16(sp)
    3a48:	64a2                	ld	s1,8(sp)
    3a4a:	6902                	ld	s2,0(sp)
    3a4c:	6105                	addi	sp,sp,32
    3a4e:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3a50:	85ca                	mv	a1,s2
    3a52:	00004517          	auipc	a0,0x4
    3a56:	c1650513          	addi	a0,a0,-1002 # 7668 <malloc+0x146e>
    3a5a:	00002097          	auipc	ra,0x2
    3a5e:	6e8080e7          	jalr	1768(ra) # 6142 <printf>
    exit(1);
    3a62:	4505                	li	a0,1
    3a64:	00002097          	auipc	ra,0x2
    3a68:	35e080e7          	jalr	862(ra) # 5dc2 <exit>
    printf("%s: create dd/ff failed\n", s);
    3a6c:	85ca                	mv	a1,s2
    3a6e:	00004517          	auipc	a0,0x4
    3a72:	c1a50513          	addi	a0,a0,-998 # 7688 <malloc+0x148e>
    3a76:	00002097          	auipc	ra,0x2
    3a7a:	6cc080e7          	jalr	1740(ra) # 6142 <printf>
    exit(1);
    3a7e:	4505                	li	a0,1
    3a80:	00002097          	auipc	ra,0x2
    3a84:	342080e7          	jalr	834(ra) # 5dc2 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3a88:	85ca                	mv	a1,s2
    3a8a:	00004517          	auipc	a0,0x4
    3a8e:	c1e50513          	addi	a0,a0,-994 # 76a8 <malloc+0x14ae>
    3a92:	00002097          	auipc	ra,0x2
    3a96:	6b0080e7          	jalr	1712(ra) # 6142 <printf>
    exit(1);
    3a9a:	4505                	li	a0,1
    3a9c:	00002097          	auipc	ra,0x2
    3aa0:	326080e7          	jalr	806(ra) # 5dc2 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3aa4:	85ca                	mv	a1,s2
    3aa6:	00004517          	auipc	a0,0x4
    3aaa:	c3a50513          	addi	a0,a0,-966 # 76e0 <malloc+0x14e6>
    3aae:	00002097          	auipc	ra,0x2
    3ab2:	694080e7          	jalr	1684(ra) # 6142 <printf>
    exit(1);
    3ab6:	4505                	li	a0,1
    3ab8:	00002097          	auipc	ra,0x2
    3abc:	30a080e7          	jalr	778(ra) # 5dc2 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3ac0:	85ca                	mv	a1,s2
    3ac2:	00004517          	auipc	a0,0x4
    3ac6:	c4e50513          	addi	a0,a0,-946 # 7710 <malloc+0x1516>
    3aca:	00002097          	auipc	ra,0x2
    3ace:	678080e7          	jalr	1656(ra) # 6142 <printf>
    exit(1);
    3ad2:	4505                	li	a0,1
    3ad4:	00002097          	auipc	ra,0x2
    3ad8:	2ee080e7          	jalr	750(ra) # 5dc2 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3adc:	85ca                	mv	a1,s2
    3ade:	00004517          	auipc	a0,0x4
    3ae2:	c6a50513          	addi	a0,a0,-918 # 7748 <malloc+0x154e>
    3ae6:	00002097          	auipc	ra,0x2
    3aea:	65c080e7          	jalr	1628(ra) # 6142 <printf>
    exit(1);
    3aee:	4505                	li	a0,1
    3af0:	00002097          	auipc	ra,0x2
    3af4:	2d2080e7          	jalr	722(ra) # 5dc2 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3af8:	85ca                	mv	a1,s2
    3afa:	00004517          	auipc	a0,0x4
    3afe:	c6e50513          	addi	a0,a0,-914 # 7768 <malloc+0x156e>
    3b02:	00002097          	auipc	ra,0x2
    3b06:	640080e7          	jalr	1600(ra) # 6142 <printf>
    exit(1);
    3b0a:	4505                	li	a0,1
    3b0c:	00002097          	auipc	ra,0x2
    3b10:	2b6080e7          	jalr	694(ra) # 5dc2 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3b14:	85ca                	mv	a1,s2
    3b16:	00004517          	auipc	a0,0x4
    3b1a:	c8250513          	addi	a0,a0,-894 # 7798 <malloc+0x159e>
    3b1e:	00002097          	auipc	ra,0x2
    3b22:	624080e7          	jalr	1572(ra) # 6142 <printf>
    exit(1);
    3b26:	4505                	li	a0,1
    3b28:	00002097          	auipc	ra,0x2
    3b2c:	29a080e7          	jalr	666(ra) # 5dc2 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3b30:	85ca                	mv	a1,s2
    3b32:	00004517          	auipc	a0,0x4
    3b36:	c8e50513          	addi	a0,a0,-882 # 77c0 <malloc+0x15c6>
    3b3a:	00002097          	auipc	ra,0x2
    3b3e:	608080e7          	jalr	1544(ra) # 6142 <printf>
    exit(1);
    3b42:	4505                	li	a0,1
    3b44:	00002097          	auipc	ra,0x2
    3b48:	27e080e7          	jalr	638(ra) # 5dc2 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3b4c:	85ca                	mv	a1,s2
    3b4e:	00004517          	auipc	a0,0x4
    3b52:	c9250513          	addi	a0,a0,-878 # 77e0 <malloc+0x15e6>
    3b56:	00002097          	auipc	ra,0x2
    3b5a:	5ec080e7          	jalr	1516(ra) # 6142 <printf>
    exit(1);
    3b5e:	4505                	li	a0,1
    3b60:	00002097          	auipc	ra,0x2
    3b64:	262080e7          	jalr	610(ra) # 5dc2 <exit>
    printf("%s: chdir dd failed\n", s);
    3b68:	85ca                	mv	a1,s2
    3b6a:	00004517          	auipc	a0,0x4
    3b6e:	c9e50513          	addi	a0,a0,-866 # 7808 <malloc+0x160e>
    3b72:	00002097          	auipc	ra,0x2
    3b76:	5d0080e7          	jalr	1488(ra) # 6142 <printf>
    exit(1);
    3b7a:	4505                	li	a0,1
    3b7c:	00002097          	auipc	ra,0x2
    3b80:	246080e7          	jalr	582(ra) # 5dc2 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3b84:	85ca                	mv	a1,s2
    3b86:	00004517          	auipc	a0,0x4
    3b8a:	caa50513          	addi	a0,a0,-854 # 7830 <malloc+0x1636>
    3b8e:	00002097          	auipc	ra,0x2
    3b92:	5b4080e7          	jalr	1460(ra) # 6142 <printf>
    exit(1);
    3b96:	4505                	li	a0,1
    3b98:	00002097          	auipc	ra,0x2
    3b9c:	22a080e7          	jalr	554(ra) # 5dc2 <exit>
    printf("chdir dd/../../dd failed\n", s);
    3ba0:	85ca                	mv	a1,s2
    3ba2:	00004517          	auipc	a0,0x4
    3ba6:	cbe50513          	addi	a0,a0,-834 # 7860 <malloc+0x1666>
    3baa:	00002097          	auipc	ra,0x2
    3bae:	598080e7          	jalr	1432(ra) # 6142 <printf>
    exit(1);
    3bb2:	4505                	li	a0,1
    3bb4:	00002097          	auipc	ra,0x2
    3bb8:	20e080e7          	jalr	526(ra) # 5dc2 <exit>
    printf("%s: chdir ./.. failed\n", s);
    3bbc:	85ca                	mv	a1,s2
    3bbe:	00004517          	auipc	a0,0x4
    3bc2:	cca50513          	addi	a0,a0,-822 # 7888 <malloc+0x168e>
    3bc6:	00002097          	auipc	ra,0x2
    3bca:	57c080e7          	jalr	1404(ra) # 6142 <printf>
    exit(1);
    3bce:	4505                	li	a0,1
    3bd0:	00002097          	auipc	ra,0x2
    3bd4:	1f2080e7          	jalr	498(ra) # 5dc2 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3bd8:	85ca                	mv	a1,s2
    3bda:	00004517          	auipc	a0,0x4
    3bde:	cc650513          	addi	a0,a0,-826 # 78a0 <malloc+0x16a6>
    3be2:	00002097          	auipc	ra,0x2
    3be6:	560080e7          	jalr	1376(ra) # 6142 <printf>
    exit(1);
    3bea:	4505                	li	a0,1
    3bec:	00002097          	auipc	ra,0x2
    3bf0:	1d6080e7          	jalr	470(ra) # 5dc2 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3bf4:	85ca                	mv	a1,s2
    3bf6:	00004517          	auipc	a0,0x4
    3bfa:	cca50513          	addi	a0,a0,-822 # 78c0 <malloc+0x16c6>
    3bfe:	00002097          	auipc	ra,0x2
    3c02:	544080e7          	jalr	1348(ra) # 6142 <printf>
    exit(1);
    3c06:	4505                	li	a0,1
    3c08:	00002097          	auipc	ra,0x2
    3c0c:	1ba080e7          	jalr	442(ra) # 5dc2 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3c10:	85ca                	mv	a1,s2
    3c12:	00004517          	auipc	a0,0x4
    3c16:	cce50513          	addi	a0,a0,-818 # 78e0 <malloc+0x16e6>
    3c1a:	00002097          	auipc	ra,0x2
    3c1e:	528080e7          	jalr	1320(ra) # 6142 <printf>
    exit(1);
    3c22:	4505                	li	a0,1
    3c24:	00002097          	auipc	ra,0x2
    3c28:	19e080e7          	jalr	414(ra) # 5dc2 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3c2c:	85ca                	mv	a1,s2
    3c2e:	00004517          	auipc	a0,0x4
    3c32:	cf250513          	addi	a0,a0,-782 # 7920 <malloc+0x1726>
    3c36:	00002097          	auipc	ra,0x2
    3c3a:	50c080e7          	jalr	1292(ra) # 6142 <printf>
    exit(1);
    3c3e:	4505                	li	a0,1
    3c40:	00002097          	auipc	ra,0x2
    3c44:	182080e7          	jalr	386(ra) # 5dc2 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3c48:	85ca                	mv	a1,s2
    3c4a:	00004517          	auipc	a0,0x4
    3c4e:	d0650513          	addi	a0,a0,-762 # 7950 <malloc+0x1756>
    3c52:	00002097          	auipc	ra,0x2
    3c56:	4f0080e7          	jalr	1264(ra) # 6142 <printf>
    exit(1);
    3c5a:	4505                	li	a0,1
    3c5c:	00002097          	auipc	ra,0x2
    3c60:	166080e7          	jalr	358(ra) # 5dc2 <exit>
    printf("%s: create dd succeeded!\n", s);
    3c64:	85ca                	mv	a1,s2
    3c66:	00004517          	auipc	a0,0x4
    3c6a:	d0a50513          	addi	a0,a0,-758 # 7970 <malloc+0x1776>
    3c6e:	00002097          	auipc	ra,0x2
    3c72:	4d4080e7          	jalr	1236(ra) # 6142 <printf>
    exit(1);
    3c76:	4505                	li	a0,1
    3c78:	00002097          	auipc	ra,0x2
    3c7c:	14a080e7          	jalr	330(ra) # 5dc2 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3c80:	85ca                	mv	a1,s2
    3c82:	00004517          	auipc	a0,0x4
    3c86:	d0e50513          	addi	a0,a0,-754 # 7990 <malloc+0x1796>
    3c8a:	00002097          	auipc	ra,0x2
    3c8e:	4b8080e7          	jalr	1208(ra) # 6142 <printf>
    exit(1);
    3c92:	4505                	li	a0,1
    3c94:	00002097          	auipc	ra,0x2
    3c98:	12e080e7          	jalr	302(ra) # 5dc2 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3c9c:	85ca                	mv	a1,s2
    3c9e:	00004517          	auipc	a0,0x4
    3ca2:	d1250513          	addi	a0,a0,-750 # 79b0 <malloc+0x17b6>
    3ca6:	00002097          	auipc	ra,0x2
    3caa:	49c080e7          	jalr	1180(ra) # 6142 <printf>
    exit(1);
    3cae:	4505                	li	a0,1
    3cb0:	00002097          	auipc	ra,0x2
    3cb4:	112080e7          	jalr	274(ra) # 5dc2 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3cb8:	85ca                	mv	a1,s2
    3cba:	00004517          	auipc	a0,0x4
    3cbe:	d2650513          	addi	a0,a0,-730 # 79e0 <malloc+0x17e6>
    3cc2:	00002097          	auipc	ra,0x2
    3cc6:	480080e7          	jalr	1152(ra) # 6142 <printf>
    exit(1);
    3cca:	4505                	li	a0,1
    3ccc:	00002097          	auipc	ra,0x2
    3cd0:	0f6080e7          	jalr	246(ra) # 5dc2 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3cd4:	85ca                	mv	a1,s2
    3cd6:	00004517          	auipc	a0,0x4
    3cda:	d3250513          	addi	a0,a0,-718 # 7a08 <malloc+0x180e>
    3cde:	00002097          	auipc	ra,0x2
    3ce2:	464080e7          	jalr	1124(ra) # 6142 <printf>
    exit(1);
    3ce6:	4505                	li	a0,1
    3ce8:	00002097          	auipc	ra,0x2
    3cec:	0da080e7          	jalr	218(ra) # 5dc2 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3cf0:	85ca                	mv	a1,s2
    3cf2:	00004517          	auipc	a0,0x4
    3cf6:	d3e50513          	addi	a0,a0,-706 # 7a30 <malloc+0x1836>
    3cfa:	00002097          	auipc	ra,0x2
    3cfe:	448080e7          	jalr	1096(ra) # 6142 <printf>
    exit(1);
    3d02:	4505                	li	a0,1
    3d04:	00002097          	auipc	ra,0x2
    3d08:	0be080e7          	jalr	190(ra) # 5dc2 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3d0c:	85ca                	mv	a1,s2
    3d0e:	00004517          	auipc	a0,0x4
    3d12:	d4a50513          	addi	a0,a0,-694 # 7a58 <malloc+0x185e>
    3d16:	00002097          	auipc	ra,0x2
    3d1a:	42c080e7          	jalr	1068(ra) # 6142 <printf>
    exit(1);
    3d1e:	4505                	li	a0,1
    3d20:	00002097          	auipc	ra,0x2
    3d24:	0a2080e7          	jalr	162(ra) # 5dc2 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3d28:	85ca                	mv	a1,s2
    3d2a:	00004517          	auipc	a0,0x4
    3d2e:	d4e50513          	addi	a0,a0,-690 # 7a78 <malloc+0x187e>
    3d32:	00002097          	auipc	ra,0x2
    3d36:	410080e7          	jalr	1040(ra) # 6142 <printf>
    exit(1);
    3d3a:	4505                	li	a0,1
    3d3c:	00002097          	auipc	ra,0x2
    3d40:	086080e7          	jalr	134(ra) # 5dc2 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3d44:	85ca                	mv	a1,s2
    3d46:	00004517          	auipc	a0,0x4
    3d4a:	d5250513          	addi	a0,a0,-686 # 7a98 <malloc+0x189e>
    3d4e:	00002097          	auipc	ra,0x2
    3d52:	3f4080e7          	jalr	1012(ra) # 6142 <printf>
    exit(1);
    3d56:	4505                	li	a0,1
    3d58:	00002097          	auipc	ra,0x2
    3d5c:	06a080e7          	jalr	106(ra) # 5dc2 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3d60:	85ca                	mv	a1,s2
    3d62:	00004517          	auipc	a0,0x4
    3d66:	d5e50513          	addi	a0,a0,-674 # 7ac0 <malloc+0x18c6>
    3d6a:	00002097          	auipc	ra,0x2
    3d6e:	3d8080e7          	jalr	984(ra) # 6142 <printf>
    exit(1);
    3d72:	4505                	li	a0,1
    3d74:	00002097          	auipc	ra,0x2
    3d78:	04e080e7          	jalr	78(ra) # 5dc2 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3d7c:	85ca                	mv	a1,s2
    3d7e:	00004517          	auipc	a0,0x4
    3d82:	d6250513          	addi	a0,a0,-670 # 7ae0 <malloc+0x18e6>
    3d86:	00002097          	auipc	ra,0x2
    3d8a:	3bc080e7          	jalr	956(ra) # 6142 <printf>
    exit(1);
    3d8e:	4505                	li	a0,1
    3d90:	00002097          	auipc	ra,0x2
    3d94:	032080e7          	jalr	50(ra) # 5dc2 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3d98:	85ca                	mv	a1,s2
    3d9a:	00004517          	auipc	a0,0x4
    3d9e:	d6650513          	addi	a0,a0,-666 # 7b00 <malloc+0x1906>
    3da2:	00002097          	auipc	ra,0x2
    3da6:	3a0080e7          	jalr	928(ra) # 6142 <printf>
    exit(1);
    3daa:	4505                	li	a0,1
    3dac:	00002097          	auipc	ra,0x2
    3db0:	016080e7          	jalr	22(ra) # 5dc2 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3db4:	85ca                	mv	a1,s2
    3db6:	00004517          	auipc	a0,0x4
    3dba:	d7250513          	addi	a0,a0,-654 # 7b28 <malloc+0x192e>
    3dbe:	00002097          	auipc	ra,0x2
    3dc2:	384080e7          	jalr	900(ra) # 6142 <printf>
    exit(1);
    3dc6:	4505                	li	a0,1
    3dc8:	00002097          	auipc	ra,0x2
    3dcc:	ffa080e7          	jalr	-6(ra) # 5dc2 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3dd0:	85ca                	mv	a1,s2
    3dd2:	00004517          	auipc	a0,0x4
    3dd6:	9ee50513          	addi	a0,a0,-1554 # 77c0 <malloc+0x15c6>
    3dda:	00002097          	auipc	ra,0x2
    3dde:	368080e7          	jalr	872(ra) # 6142 <printf>
    exit(1);
    3de2:	4505                	li	a0,1
    3de4:	00002097          	auipc	ra,0x2
    3de8:	fde080e7          	jalr	-34(ra) # 5dc2 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3dec:	85ca                	mv	a1,s2
    3dee:	00004517          	auipc	a0,0x4
    3df2:	d5a50513          	addi	a0,a0,-678 # 7b48 <malloc+0x194e>
    3df6:	00002097          	auipc	ra,0x2
    3dfa:	34c080e7          	jalr	844(ra) # 6142 <printf>
    exit(1);
    3dfe:	4505                	li	a0,1
    3e00:	00002097          	auipc	ra,0x2
    3e04:	fc2080e7          	jalr	-62(ra) # 5dc2 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3e08:	85ca                	mv	a1,s2
    3e0a:	00004517          	auipc	a0,0x4
    3e0e:	d5e50513          	addi	a0,a0,-674 # 7b68 <malloc+0x196e>
    3e12:	00002097          	auipc	ra,0x2
    3e16:	330080e7          	jalr	816(ra) # 6142 <printf>
    exit(1);
    3e1a:	4505                	li	a0,1
    3e1c:	00002097          	auipc	ra,0x2
    3e20:	fa6080e7          	jalr	-90(ra) # 5dc2 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3e24:	85ca                	mv	a1,s2
    3e26:	00004517          	auipc	a0,0x4
    3e2a:	d7250513          	addi	a0,a0,-654 # 7b98 <malloc+0x199e>
    3e2e:	00002097          	auipc	ra,0x2
    3e32:	314080e7          	jalr	788(ra) # 6142 <printf>
    exit(1);
    3e36:	4505                	li	a0,1
    3e38:	00002097          	auipc	ra,0x2
    3e3c:	f8a080e7          	jalr	-118(ra) # 5dc2 <exit>
    printf("%s: unlink dd failed\n", s);
    3e40:	85ca                	mv	a1,s2
    3e42:	00004517          	auipc	a0,0x4
    3e46:	d7650513          	addi	a0,a0,-650 # 7bb8 <malloc+0x19be>
    3e4a:	00002097          	auipc	ra,0x2
    3e4e:	2f8080e7          	jalr	760(ra) # 6142 <printf>
    exit(1);
    3e52:	4505                	li	a0,1
    3e54:	00002097          	auipc	ra,0x2
    3e58:	f6e080e7          	jalr	-146(ra) # 5dc2 <exit>

0000000000003e5c <rmdot>:
{
    3e5c:	1101                	addi	sp,sp,-32
    3e5e:	ec06                	sd	ra,24(sp)
    3e60:	e822                	sd	s0,16(sp)
    3e62:	e426                	sd	s1,8(sp)
    3e64:	1000                	addi	s0,sp,32
    3e66:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3e68:	00004517          	auipc	a0,0x4
    3e6c:	d6850513          	addi	a0,a0,-664 # 7bd0 <malloc+0x19d6>
    3e70:	00002097          	auipc	ra,0x2
    3e74:	fba080e7          	jalr	-70(ra) # 5e2a <mkdir>
    3e78:	e549                	bnez	a0,3f02 <rmdot+0xa6>
  if(chdir("dots") != 0){
    3e7a:	00004517          	auipc	a0,0x4
    3e7e:	d5650513          	addi	a0,a0,-682 # 7bd0 <malloc+0x19d6>
    3e82:	00002097          	auipc	ra,0x2
    3e86:	fb0080e7          	jalr	-80(ra) # 5e32 <chdir>
    3e8a:	e951                	bnez	a0,3f1e <rmdot+0xc2>
  if(unlink(".") == 0){
    3e8c:	00003517          	auipc	a0,0x3
    3e90:	b7450513          	addi	a0,a0,-1164 # 6a00 <malloc+0x806>
    3e94:	00002097          	auipc	ra,0x2
    3e98:	f7e080e7          	jalr	-130(ra) # 5e12 <unlink>
    3e9c:	cd59                	beqz	a0,3f3a <rmdot+0xde>
  if(unlink("..") == 0){
    3e9e:	00003517          	auipc	a0,0x3
    3ea2:	78a50513          	addi	a0,a0,1930 # 7628 <malloc+0x142e>
    3ea6:	00002097          	auipc	ra,0x2
    3eaa:	f6c080e7          	jalr	-148(ra) # 5e12 <unlink>
    3eae:	c545                	beqz	a0,3f56 <rmdot+0xfa>
  if(chdir("/") != 0){
    3eb0:	00003517          	auipc	a0,0x3
    3eb4:	72050513          	addi	a0,a0,1824 # 75d0 <malloc+0x13d6>
    3eb8:	00002097          	auipc	ra,0x2
    3ebc:	f7a080e7          	jalr	-134(ra) # 5e32 <chdir>
    3ec0:	e94d                	bnez	a0,3f72 <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3ec2:	00004517          	auipc	a0,0x4
    3ec6:	d7650513          	addi	a0,a0,-650 # 7c38 <malloc+0x1a3e>
    3eca:	00002097          	auipc	ra,0x2
    3ece:	f48080e7          	jalr	-184(ra) # 5e12 <unlink>
    3ed2:	cd55                	beqz	a0,3f8e <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3ed4:	00004517          	auipc	a0,0x4
    3ed8:	d8c50513          	addi	a0,a0,-628 # 7c60 <malloc+0x1a66>
    3edc:	00002097          	auipc	ra,0x2
    3ee0:	f36080e7          	jalr	-202(ra) # 5e12 <unlink>
    3ee4:	c179                	beqz	a0,3faa <rmdot+0x14e>
  if(unlink("dots") != 0){
    3ee6:	00004517          	auipc	a0,0x4
    3eea:	cea50513          	addi	a0,a0,-790 # 7bd0 <malloc+0x19d6>
    3eee:	00002097          	auipc	ra,0x2
    3ef2:	f24080e7          	jalr	-220(ra) # 5e12 <unlink>
    3ef6:	e961                	bnez	a0,3fc6 <rmdot+0x16a>
}
    3ef8:	60e2                	ld	ra,24(sp)
    3efa:	6442                	ld	s0,16(sp)
    3efc:	64a2                	ld	s1,8(sp)
    3efe:	6105                	addi	sp,sp,32
    3f00:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3f02:	85a6                	mv	a1,s1
    3f04:	00004517          	auipc	a0,0x4
    3f08:	cd450513          	addi	a0,a0,-812 # 7bd8 <malloc+0x19de>
    3f0c:	00002097          	auipc	ra,0x2
    3f10:	236080e7          	jalr	566(ra) # 6142 <printf>
    exit(1);
    3f14:	4505                	li	a0,1
    3f16:	00002097          	auipc	ra,0x2
    3f1a:	eac080e7          	jalr	-340(ra) # 5dc2 <exit>
    printf("%s: chdir dots failed\n", s);
    3f1e:	85a6                	mv	a1,s1
    3f20:	00004517          	auipc	a0,0x4
    3f24:	cd050513          	addi	a0,a0,-816 # 7bf0 <malloc+0x19f6>
    3f28:	00002097          	auipc	ra,0x2
    3f2c:	21a080e7          	jalr	538(ra) # 6142 <printf>
    exit(1);
    3f30:	4505                	li	a0,1
    3f32:	00002097          	auipc	ra,0x2
    3f36:	e90080e7          	jalr	-368(ra) # 5dc2 <exit>
    printf("%s: rm . worked!\n", s);
    3f3a:	85a6                	mv	a1,s1
    3f3c:	00004517          	auipc	a0,0x4
    3f40:	ccc50513          	addi	a0,a0,-820 # 7c08 <malloc+0x1a0e>
    3f44:	00002097          	auipc	ra,0x2
    3f48:	1fe080e7          	jalr	510(ra) # 6142 <printf>
    exit(1);
    3f4c:	4505                	li	a0,1
    3f4e:	00002097          	auipc	ra,0x2
    3f52:	e74080e7          	jalr	-396(ra) # 5dc2 <exit>
    printf("%s: rm .. worked!\n", s);
    3f56:	85a6                	mv	a1,s1
    3f58:	00004517          	auipc	a0,0x4
    3f5c:	cc850513          	addi	a0,a0,-824 # 7c20 <malloc+0x1a26>
    3f60:	00002097          	auipc	ra,0x2
    3f64:	1e2080e7          	jalr	482(ra) # 6142 <printf>
    exit(1);
    3f68:	4505                	li	a0,1
    3f6a:	00002097          	auipc	ra,0x2
    3f6e:	e58080e7          	jalr	-424(ra) # 5dc2 <exit>
    printf("%s: chdir / failed\n", s);
    3f72:	85a6                	mv	a1,s1
    3f74:	00003517          	auipc	a0,0x3
    3f78:	66450513          	addi	a0,a0,1636 # 75d8 <malloc+0x13de>
    3f7c:	00002097          	auipc	ra,0x2
    3f80:	1c6080e7          	jalr	454(ra) # 6142 <printf>
    exit(1);
    3f84:	4505                	li	a0,1
    3f86:	00002097          	auipc	ra,0x2
    3f8a:	e3c080e7          	jalr	-452(ra) # 5dc2 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3f8e:	85a6                	mv	a1,s1
    3f90:	00004517          	auipc	a0,0x4
    3f94:	cb050513          	addi	a0,a0,-848 # 7c40 <malloc+0x1a46>
    3f98:	00002097          	auipc	ra,0x2
    3f9c:	1aa080e7          	jalr	426(ra) # 6142 <printf>
    exit(1);
    3fa0:	4505                	li	a0,1
    3fa2:	00002097          	auipc	ra,0x2
    3fa6:	e20080e7          	jalr	-480(ra) # 5dc2 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3faa:	85a6                	mv	a1,s1
    3fac:	00004517          	auipc	a0,0x4
    3fb0:	cbc50513          	addi	a0,a0,-836 # 7c68 <malloc+0x1a6e>
    3fb4:	00002097          	auipc	ra,0x2
    3fb8:	18e080e7          	jalr	398(ra) # 6142 <printf>
    exit(1);
    3fbc:	4505                	li	a0,1
    3fbe:	00002097          	auipc	ra,0x2
    3fc2:	e04080e7          	jalr	-508(ra) # 5dc2 <exit>
    printf("%s: unlink dots failed!\n", s);
    3fc6:	85a6                	mv	a1,s1
    3fc8:	00004517          	auipc	a0,0x4
    3fcc:	cc050513          	addi	a0,a0,-832 # 7c88 <malloc+0x1a8e>
    3fd0:	00002097          	auipc	ra,0x2
    3fd4:	172080e7          	jalr	370(ra) # 6142 <printf>
    exit(1);
    3fd8:	4505                	li	a0,1
    3fda:	00002097          	auipc	ra,0x2
    3fde:	de8080e7          	jalr	-536(ra) # 5dc2 <exit>

0000000000003fe2 <dirfile>:
{
    3fe2:	1101                	addi	sp,sp,-32
    3fe4:	ec06                	sd	ra,24(sp)
    3fe6:	e822                	sd	s0,16(sp)
    3fe8:	e426                	sd	s1,8(sp)
    3fea:	e04a                	sd	s2,0(sp)
    3fec:	1000                	addi	s0,sp,32
    3fee:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3ff0:	20000593          	li	a1,512
    3ff4:	00004517          	auipc	a0,0x4
    3ff8:	cb450513          	addi	a0,a0,-844 # 7ca8 <malloc+0x1aae>
    3ffc:	00002097          	auipc	ra,0x2
    4000:	e06080e7          	jalr	-506(ra) # 5e02 <open>
  if(fd < 0){
    4004:	0e054d63          	bltz	a0,40fe <dirfile+0x11c>
  close(fd);
    4008:	00002097          	auipc	ra,0x2
    400c:	de2080e7          	jalr	-542(ra) # 5dea <close>
  if(chdir("dirfile") == 0){
    4010:	00004517          	auipc	a0,0x4
    4014:	c9850513          	addi	a0,a0,-872 # 7ca8 <malloc+0x1aae>
    4018:	00002097          	auipc	ra,0x2
    401c:	e1a080e7          	jalr	-486(ra) # 5e32 <chdir>
    4020:	cd6d                	beqz	a0,411a <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    4022:	4581                	li	a1,0
    4024:	00004517          	auipc	a0,0x4
    4028:	ccc50513          	addi	a0,a0,-820 # 7cf0 <malloc+0x1af6>
    402c:	00002097          	auipc	ra,0x2
    4030:	dd6080e7          	jalr	-554(ra) # 5e02 <open>
  if(fd >= 0){
    4034:	10055163          	bgez	a0,4136 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    4038:	20000593          	li	a1,512
    403c:	00004517          	auipc	a0,0x4
    4040:	cb450513          	addi	a0,a0,-844 # 7cf0 <malloc+0x1af6>
    4044:	00002097          	auipc	ra,0x2
    4048:	dbe080e7          	jalr	-578(ra) # 5e02 <open>
  if(fd >= 0){
    404c:	10055363          	bgez	a0,4152 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    4050:	00004517          	auipc	a0,0x4
    4054:	ca050513          	addi	a0,a0,-864 # 7cf0 <malloc+0x1af6>
    4058:	00002097          	auipc	ra,0x2
    405c:	dd2080e7          	jalr	-558(ra) # 5e2a <mkdir>
    4060:	10050763          	beqz	a0,416e <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    4064:	00004517          	auipc	a0,0x4
    4068:	c8c50513          	addi	a0,a0,-884 # 7cf0 <malloc+0x1af6>
    406c:	00002097          	auipc	ra,0x2
    4070:	da6080e7          	jalr	-602(ra) # 5e12 <unlink>
    4074:	10050b63          	beqz	a0,418a <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    4078:	00004597          	auipc	a1,0x4
    407c:	c7858593          	addi	a1,a1,-904 # 7cf0 <malloc+0x1af6>
    4080:	00002517          	auipc	a0,0x2
    4084:	47050513          	addi	a0,a0,1136 # 64f0 <malloc+0x2f6>
    4088:	00002097          	auipc	ra,0x2
    408c:	d9a080e7          	jalr	-614(ra) # 5e22 <link>
    4090:	10050b63          	beqz	a0,41a6 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    4094:	00004517          	auipc	a0,0x4
    4098:	c1450513          	addi	a0,a0,-1004 # 7ca8 <malloc+0x1aae>
    409c:	00002097          	auipc	ra,0x2
    40a0:	d76080e7          	jalr	-650(ra) # 5e12 <unlink>
    40a4:	10051f63          	bnez	a0,41c2 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    40a8:	4589                	li	a1,2
    40aa:	00003517          	auipc	a0,0x3
    40ae:	95650513          	addi	a0,a0,-1706 # 6a00 <malloc+0x806>
    40b2:	00002097          	auipc	ra,0x2
    40b6:	d50080e7          	jalr	-688(ra) # 5e02 <open>
  if(fd >= 0){
    40ba:	12055263          	bgez	a0,41de <dirfile+0x1fc>
  fd = open(".", 0);
    40be:	4581                	li	a1,0
    40c0:	00003517          	auipc	a0,0x3
    40c4:	94050513          	addi	a0,a0,-1728 # 6a00 <malloc+0x806>
    40c8:	00002097          	auipc	ra,0x2
    40cc:	d3a080e7          	jalr	-710(ra) # 5e02 <open>
    40d0:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    40d2:	4605                	li	a2,1
    40d4:	00002597          	auipc	a1,0x2
    40d8:	2b458593          	addi	a1,a1,692 # 6388 <malloc+0x18e>
    40dc:	00002097          	auipc	ra,0x2
    40e0:	d06080e7          	jalr	-762(ra) # 5de2 <write>
    40e4:	10a04b63          	bgtz	a0,41fa <dirfile+0x218>
  close(fd);
    40e8:	8526                	mv	a0,s1
    40ea:	00002097          	auipc	ra,0x2
    40ee:	d00080e7          	jalr	-768(ra) # 5dea <close>
}
    40f2:	60e2                	ld	ra,24(sp)
    40f4:	6442                	ld	s0,16(sp)
    40f6:	64a2                	ld	s1,8(sp)
    40f8:	6902                	ld	s2,0(sp)
    40fa:	6105                	addi	sp,sp,32
    40fc:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    40fe:	85ca                	mv	a1,s2
    4100:	00004517          	auipc	a0,0x4
    4104:	bb050513          	addi	a0,a0,-1104 # 7cb0 <malloc+0x1ab6>
    4108:	00002097          	auipc	ra,0x2
    410c:	03a080e7          	jalr	58(ra) # 6142 <printf>
    exit(1);
    4110:	4505                	li	a0,1
    4112:	00002097          	auipc	ra,0x2
    4116:	cb0080e7          	jalr	-848(ra) # 5dc2 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    411a:	85ca                	mv	a1,s2
    411c:	00004517          	auipc	a0,0x4
    4120:	bb450513          	addi	a0,a0,-1100 # 7cd0 <malloc+0x1ad6>
    4124:	00002097          	auipc	ra,0x2
    4128:	01e080e7          	jalr	30(ra) # 6142 <printf>
    exit(1);
    412c:	4505                	li	a0,1
    412e:	00002097          	auipc	ra,0x2
    4132:	c94080e7          	jalr	-876(ra) # 5dc2 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4136:	85ca                	mv	a1,s2
    4138:	00004517          	auipc	a0,0x4
    413c:	bc850513          	addi	a0,a0,-1080 # 7d00 <malloc+0x1b06>
    4140:	00002097          	auipc	ra,0x2
    4144:	002080e7          	jalr	2(ra) # 6142 <printf>
    exit(1);
    4148:	4505                	li	a0,1
    414a:	00002097          	auipc	ra,0x2
    414e:	c78080e7          	jalr	-904(ra) # 5dc2 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4152:	85ca                	mv	a1,s2
    4154:	00004517          	auipc	a0,0x4
    4158:	bac50513          	addi	a0,a0,-1108 # 7d00 <malloc+0x1b06>
    415c:	00002097          	auipc	ra,0x2
    4160:	fe6080e7          	jalr	-26(ra) # 6142 <printf>
    exit(1);
    4164:	4505                	li	a0,1
    4166:	00002097          	auipc	ra,0x2
    416a:	c5c080e7          	jalr	-932(ra) # 5dc2 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    416e:	85ca                	mv	a1,s2
    4170:	00004517          	auipc	a0,0x4
    4174:	bb850513          	addi	a0,a0,-1096 # 7d28 <malloc+0x1b2e>
    4178:	00002097          	auipc	ra,0x2
    417c:	fca080e7          	jalr	-54(ra) # 6142 <printf>
    exit(1);
    4180:	4505                	li	a0,1
    4182:	00002097          	auipc	ra,0x2
    4186:	c40080e7          	jalr	-960(ra) # 5dc2 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    418a:	85ca                	mv	a1,s2
    418c:	00004517          	auipc	a0,0x4
    4190:	bc450513          	addi	a0,a0,-1084 # 7d50 <malloc+0x1b56>
    4194:	00002097          	auipc	ra,0x2
    4198:	fae080e7          	jalr	-82(ra) # 6142 <printf>
    exit(1);
    419c:	4505                	li	a0,1
    419e:	00002097          	auipc	ra,0x2
    41a2:	c24080e7          	jalr	-988(ra) # 5dc2 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    41a6:	85ca                	mv	a1,s2
    41a8:	00004517          	auipc	a0,0x4
    41ac:	bd050513          	addi	a0,a0,-1072 # 7d78 <malloc+0x1b7e>
    41b0:	00002097          	auipc	ra,0x2
    41b4:	f92080e7          	jalr	-110(ra) # 6142 <printf>
    exit(1);
    41b8:	4505                	li	a0,1
    41ba:	00002097          	auipc	ra,0x2
    41be:	c08080e7          	jalr	-1016(ra) # 5dc2 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    41c2:	85ca                	mv	a1,s2
    41c4:	00004517          	auipc	a0,0x4
    41c8:	bdc50513          	addi	a0,a0,-1060 # 7da0 <malloc+0x1ba6>
    41cc:	00002097          	auipc	ra,0x2
    41d0:	f76080e7          	jalr	-138(ra) # 6142 <printf>
    exit(1);
    41d4:	4505                	li	a0,1
    41d6:	00002097          	auipc	ra,0x2
    41da:	bec080e7          	jalr	-1044(ra) # 5dc2 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    41de:	85ca                	mv	a1,s2
    41e0:	00004517          	auipc	a0,0x4
    41e4:	be050513          	addi	a0,a0,-1056 # 7dc0 <malloc+0x1bc6>
    41e8:	00002097          	auipc	ra,0x2
    41ec:	f5a080e7          	jalr	-166(ra) # 6142 <printf>
    exit(1);
    41f0:	4505                	li	a0,1
    41f2:	00002097          	auipc	ra,0x2
    41f6:	bd0080e7          	jalr	-1072(ra) # 5dc2 <exit>
    printf("%s: write . succeeded!\n", s);
    41fa:	85ca                	mv	a1,s2
    41fc:	00004517          	auipc	a0,0x4
    4200:	bec50513          	addi	a0,a0,-1044 # 7de8 <malloc+0x1bee>
    4204:	00002097          	auipc	ra,0x2
    4208:	f3e080e7          	jalr	-194(ra) # 6142 <printf>
    exit(1);
    420c:	4505                	li	a0,1
    420e:	00002097          	auipc	ra,0x2
    4212:	bb4080e7          	jalr	-1100(ra) # 5dc2 <exit>

0000000000004216 <iref>:
{
    4216:	7139                	addi	sp,sp,-64
    4218:	fc06                	sd	ra,56(sp)
    421a:	f822                	sd	s0,48(sp)
    421c:	f426                	sd	s1,40(sp)
    421e:	f04a                	sd	s2,32(sp)
    4220:	ec4e                	sd	s3,24(sp)
    4222:	e852                	sd	s4,16(sp)
    4224:	e456                	sd	s5,8(sp)
    4226:	e05a                	sd	s6,0(sp)
    4228:	0080                	addi	s0,sp,64
    422a:	8b2a                	mv	s6,a0
    422c:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    4230:	00004a17          	auipc	s4,0x4
    4234:	bd0a0a13          	addi	s4,s4,-1072 # 7e00 <malloc+0x1c06>
    mkdir("");
    4238:	00003497          	auipc	s1,0x3
    423c:	6d048493          	addi	s1,s1,1744 # 7908 <malloc+0x170e>
    link("README", "");
    4240:	00002a97          	auipc	s5,0x2
    4244:	2b0a8a93          	addi	s5,s5,688 # 64f0 <malloc+0x2f6>
    fd = open("xx", O_CREATE);
    4248:	00004997          	auipc	s3,0x4
    424c:	ab098993          	addi	s3,s3,-1360 # 7cf8 <malloc+0x1afe>
    4250:	a891                	j	42a4 <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    4252:	85da                	mv	a1,s6
    4254:	00004517          	auipc	a0,0x4
    4258:	bb450513          	addi	a0,a0,-1100 # 7e08 <malloc+0x1c0e>
    425c:	00002097          	auipc	ra,0x2
    4260:	ee6080e7          	jalr	-282(ra) # 6142 <printf>
      exit(1);
    4264:	4505                	li	a0,1
    4266:	00002097          	auipc	ra,0x2
    426a:	b5c080e7          	jalr	-1188(ra) # 5dc2 <exit>
      printf("%s: chdir irefd failed\n", s);
    426e:	85da                	mv	a1,s6
    4270:	00004517          	auipc	a0,0x4
    4274:	bb050513          	addi	a0,a0,-1104 # 7e20 <malloc+0x1c26>
    4278:	00002097          	auipc	ra,0x2
    427c:	eca080e7          	jalr	-310(ra) # 6142 <printf>
      exit(1);
    4280:	4505                	li	a0,1
    4282:	00002097          	auipc	ra,0x2
    4286:	b40080e7          	jalr	-1216(ra) # 5dc2 <exit>
      close(fd);
    428a:	00002097          	auipc	ra,0x2
    428e:	b60080e7          	jalr	-1184(ra) # 5dea <close>
    4292:	a889                	j	42e4 <iref+0xce>
    unlink("xx");
    4294:	854e                	mv	a0,s3
    4296:	00002097          	auipc	ra,0x2
    429a:	b7c080e7          	jalr	-1156(ra) # 5e12 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    429e:	397d                	addiw	s2,s2,-1
    42a0:	06090063          	beqz	s2,4300 <iref+0xea>
    if(mkdir("irefd") != 0){
    42a4:	8552                	mv	a0,s4
    42a6:	00002097          	auipc	ra,0x2
    42aa:	b84080e7          	jalr	-1148(ra) # 5e2a <mkdir>
    42ae:	f155                	bnez	a0,4252 <iref+0x3c>
    if(chdir("irefd") != 0){
    42b0:	8552                	mv	a0,s4
    42b2:	00002097          	auipc	ra,0x2
    42b6:	b80080e7          	jalr	-1152(ra) # 5e32 <chdir>
    42ba:	f955                	bnez	a0,426e <iref+0x58>
    mkdir("");
    42bc:	8526                	mv	a0,s1
    42be:	00002097          	auipc	ra,0x2
    42c2:	b6c080e7          	jalr	-1172(ra) # 5e2a <mkdir>
    link("README", "");
    42c6:	85a6                	mv	a1,s1
    42c8:	8556                	mv	a0,s5
    42ca:	00002097          	auipc	ra,0x2
    42ce:	b58080e7          	jalr	-1192(ra) # 5e22 <link>
    fd = open("", O_CREATE);
    42d2:	20000593          	li	a1,512
    42d6:	8526                	mv	a0,s1
    42d8:	00002097          	auipc	ra,0x2
    42dc:	b2a080e7          	jalr	-1238(ra) # 5e02 <open>
    if(fd >= 0)
    42e0:	fa0555e3          	bgez	a0,428a <iref+0x74>
    fd = open("xx", O_CREATE);
    42e4:	20000593          	li	a1,512
    42e8:	854e                	mv	a0,s3
    42ea:	00002097          	auipc	ra,0x2
    42ee:	b18080e7          	jalr	-1256(ra) # 5e02 <open>
    if(fd >= 0)
    42f2:	fa0541e3          	bltz	a0,4294 <iref+0x7e>
      close(fd);
    42f6:	00002097          	auipc	ra,0x2
    42fa:	af4080e7          	jalr	-1292(ra) # 5dea <close>
    42fe:	bf59                	j	4294 <iref+0x7e>
    4300:	03300493          	li	s1,51
    chdir("..");
    4304:	00003997          	auipc	s3,0x3
    4308:	32498993          	addi	s3,s3,804 # 7628 <malloc+0x142e>
    unlink("irefd");
    430c:	00004917          	auipc	s2,0x4
    4310:	af490913          	addi	s2,s2,-1292 # 7e00 <malloc+0x1c06>
    chdir("..");
    4314:	854e                	mv	a0,s3
    4316:	00002097          	auipc	ra,0x2
    431a:	b1c080e7          	jalr	-1252(ra) # 5e32 <chdir>
    unlink("irefd");
    431e:	854a                	mv	a0,s2
    4320:	00002097          	auipc	ra,0x2
    4324:	af2080e7          	jalr	-1294(ra) # 5e12 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4328:	34fd                	addiw	s1,s1,-1
    432a:	f4ed                	bnez	s1,4314 <iref+0xfe>
  chdir("/");
    432c:	00003517          	auipc	a0,0x3
    4330:	2a450513          	addi	a0,a0,676 # 75d0 <malloc+0x13d6>
    4334:	00002097          	auipc	ra,0x2
    4338:	afe080e7          	jalr	-1282(ra) # 5e32 <chdir>
}
    433c:	70e2                	ld	ra,56(sp)
    433e:	7442                	ld	s0,48(sp)
    4340:	74a2                	ld	s1,40(sp)
    4342:	7902                	ld	s2,32(sp)
    4344:	69e2                	ld	s3,24(sp)
    4346:	6a42                	ld	s4,16(sp)
    4348:	6aa2                	ld	s5,8(sp)
    434a:	6b02                	ld	s6,0(sp)
    434c:	6121                	addi	sp,sp,64
    434e:	8082                	ret

0000000000004350 <openiputtest>:
{
    4350:	7179                	addi	sp,sp,-48
    4352:	f406                	sd	ra,40(sp)
    4354:	f022                	sd	s0,32(sp)
    4356:	ec26                	sd	s1,24(sp)
    4358:	1800                	addi	s0,sp,48
    435a:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    435c:	00004517          	auipc	a0,0x4
    4360:	adc50513          	addi	a0,a0,-1316 # 7e38 <malloc+0x1c3e>
    4364:	00002097          	auipc	ra,0x2
    4368:	ac6080e7          	jalr	-1338(ra) # 5e2a <mkdir>
    436c:	04054263          	bltz	a0,43b0 <openiputtest+0x60>
  pid = fork();
    4370:	00002097          	auipc	ra,0x2
    4374:	a4a080e7          	jalr	-1462(ra) # 5dba <fork>
  if(pid < 0){
    4378:	04054a63          	bltz	a0,43cc <openiputtest+0x7c>
  if(pid == 0){
    437c:	e93d                	bnez	a0,43f2 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    437e:	4589                	li	a1,2
    4380:	00004517          	auipc	a0,0x4
    4384:	ab850513          	addi	a0,a0,-1352 # 7e38 <malloc+0x1c3e>
    4388:	00002097          	auipc	ra,0x2
    438c:	a7a080e7          	jalr	-1414(ra) # 5e02 <open>
    if(fd >= 0){
    4390:	04054c63          	bltz	a0,43e8 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    4394:	85a6                	mv	a1,s1
    4396:	00004517          	auipc	a0,0x4
    439a:	ac250513          	addi	a0,a0,-1342 # 7e58 <malloc+0x1c5e>
    439e:	00002097          	auipc	ra,0x2
    43a2:	da4080e7          	jalr	-604(ra) # 6142 <printf>
      exit(1);
    43a6:	4505                	li	a0,1
    43a8:	00002097          	auipc	ra,0x2
    43ac:	a1a080e7          	jalr	-1510(ra) # 5dc2 <exit>
    printf("%s: mkdir oidir failed\n", s);
    43b0:	85a6                	mv	a1,s1
    43b2:	00004517          	auipc	a0,0x4
    43b6:	a8e50513          	addi	a0,a0,-1394 # 7e40 <malloc+0x1c46>
    43ba:	00002097          	auipc	ra,0x2
    43be:	d88080e7          	jalr	-632(ra) # 6142 <printf>
    exit(1);
    43c2:	4505                	li	a0,1
    43c4:	00002097          	auipc	ra,0x2
    43c8:	9fe080e7          	jalr	-1538(ra) # 5dc2 <exit>
    printf("%s: fork failed\n", s);
    43cc:	85a6                	mv	a1,s1
    43ce:	00002517          	auipc	a0,0x2
    43d2:	7d250513          	addi	a0,a0,2002 # 6ba0 <malloc+0x9a6>
    43d6:	00002097          	auipc	ra,0x2
    43da:	d6c080e7          	jalr	-660(ra) # 6142 <printf>
    exit(1);
    43de:	4505                	li	a0,1
    43e0:	00002097          	auipc	ra,0x2
    43e4:	9e2080e7          	jalr	-1566(ra) # 5dc2 <exit>
    exit(0);
    43e8:	4501                	li	a0,0
    43ea:	00002097          	auipc	ra,0x2
    43ee:	9d8080e7          	jalr	-1576(ra) # 5dc2 <exit>
  sleep(1);
    43f2:	4505                	li	a0,1
    43f4:	00002097          	auipc	ra,0x2
    43f8:	a5e080e7          	jalr	-1442(ra) # 5e52 <sleep>
  if(unlink("oidir") != 0){
    43fc:	00004517          	auipc	a0,0x4
    4400:	a3c50513          	addi	a0,a0,-1476 # 7e38 <malloc+0x1c3e>
    4404:	00002097          	auipc	ra,0x2
    4408:	a0e080e7          	jalr	-1522(ra) # 5e12 <unlink>
    440c:	cd19                	beqz	a0,442a <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    440e:	85a6                	mv	a1,s1
    4410:	00003517          	auipc	a0,0x3
    4414:	98050513          	addi	a0,a0,-1664 # 6d90 <malloc+0xb96>
    4418:	00002097          	auipc	ra,0x2
    441c:	d2a080e7          	jalr	-726(ra) # 6142 <printf>
    exit(1);
    4420:	4505                	li	a0,1
    4422:	00002097          	auipc	ra,0x2
    4426:	9a0080e7          	jalr	-1632(ra) # 5dc2 <exit>
  wait(&xstatus);
    442a:	fdc40513          	addi	a0,s0,-36
    442e:	00002097          	auipc	ra,0x2
    4432:	99c080e7          	jalr	-1636(ra) # 5dca <wait>
  exit(xstatus);
    4436:	fdc42503          	lw	a0,-36(s0)
    443a:	00002097          	auipc	ra,0x2
    443e:	988080e7          	jalr	-1656(ra) # 5dc2 <exit>

0000000000004442 <forkforkfork>:
{
    4442:	1101                	addi	sp,sp,-32
    4444:	ec06                	sd	ra,24(sp)
    4446:	e822                	sd	s0,16(sp)
    4448:	e426                	sd	s1,8(sp)
    444a:	1000                	addi	s0,sp,32
    444c:	84aa                	mv	s1,a0
  unlink("stopforking");
    444e:	00004517          	auipc	a0,0x4
    4452:	a3250513          	addi	a0,a0,-1486 # 7e80 <malloc+0x1c86>
    4456:	00002097          	auipc	ra,0x2
    445a:	9bc080e7          	jalr	-1604(ra) # 5e12 <unlink>
  int pid = fork();
    445e:	00002097          	auipc	ra,0x2
    4462:	95c080e7          	jalr	-1700(ra) # 5dba <fork>
  if(pid < 0){
    4466:	04054563          	bltz	a0,44b0 <forkforkfork+0x6e>
  if(pid == 0){
    446a:	c12d                	beqz	a0,44cc <forkforkfork+0x8a>
  sleep(20); // two seconds
    446c:	4551                	li	a0,20
    446e:	00002097          	auipc	ra,0x2
    4472:	9e4080e7          	jalr	-1564(ra) # 5e52 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    4476:	20200593          	li	a1,514
    447a:	00004517          	auipc	a0,0x4
    447e:	a0650513          	addi	a0,a0,-1530 # 7e80 <malloc+0x1c86>
    4482:	00002097          	auipc	ra,0x2
    4486:	980080e7          	jalr	-1664(ra) # 5e02 <open>
    448a:	00002097          	auipc	ra,0x2
    448e:	960080e7          	jalr	-1696(ra) # 5dea <close>
  wait(0);
    4492:	4501                	li	a0,0
    4494:	00002097          	auipc	ra,0x2
    4498:	936080e7          	jalr	-1738(ra) # 5dca <wait>
  sleep(10); // one second
    449c:	4529                	li	a0,10
    449e:	00002097          	auipc	ra,0x2
    44a2:	9b4080e7          	jalr	-1612(ra) # 5e52 <sleep>
}
    44a6:	60e2                	ld	ra,24(sp)
    44a8:	6442                	ld	s0,16(sp)
    44aa:	64a2                	ld	s1,8(sp)
    44ac:	6105                	addi	sp,sp,32
    44ae:	8082                	ret
    printf("%s: fork failed", s);
    44b0:	85a6                	mv	a1,s1
    44b2:	00003517          	auipc	a0,0x3
    44b6:	8ae50513          	addi	a0,a0,-1874 # 6d60 <malloc+0xb66>
    44ba:	00002097          	auipc	ra,0x2
    44be:	c88080e7          	jalr	-888(ra) # 6142 <printf>
    exit(1);
    44c2:	4505                	li	a0,1
    44c4:	00002097          	auipc	ra,0x2
    44c8:	8fe080e7          	jalr	-1794(ra) # 5dc2 <exit>
      int fd = open("stopforking", 0);
    44cc:	00004497          	auipc	s1,0x4
    44d0:	9b448493          	addi	s1,s1,-1612 # 7e80 <malloc+0x1c86>
    44d4:	4581                	li	a1,0
    44d6:	8526                	mv	a0,s1
    44d8:	00002097          	auipc	ra,0x2
    44dc:	92a080e7          	jalr	-1750(ra) # 5e02 <open>
      if(fd >= 0){
    44e0:	02055763          	bgez	a0,450e <forkforkfork+0xcc>
      if(fork() < 0){
    44e4:	00002097          	auipc	ra,0x2
    44e8:	8d6080e7          	jalr	-1834(ra) # 5dba <fork>
    44ec:	fe0554e3          	bgez	a0,44d4 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    44f0:	20200593          	li	a1,514
    44f4:	00004517          	auipc	a0,0x4
    44f8:	98c50513          	addi	a0,a0,-1652 # 7e80 <malloc+0x1c86>
    44fc:	00002097          	auipc	ra,0x2
    4500:	906080e7          	jalr	-1786(ra) # 5e02 <open>
    4504:	00002097          	auipc	ra,0x2
    4508:	8e6080e7          	jalr	-1818(ra) # 5dea <close>
    450c:	b7e1                	j	44d4 <forkforkfork+0x92>
        exit(0);
    450e:	4501                	li	a0,0
    4510:	00002097          	auipc	ra,0x2
    4514:	8b2080e7          	jalr	-1870(ra) # 5dc2 <exit>

0000000000004518 <killstatus>:
{
    4518:	7139                	addi	sp,sp,-64
    451a:	fc06                	sd	ra,56(sp)
    451c:	f822                	sd	s0,48(sp)
    451e:	f426                	sd	s1,40(sp)
    4520:	f04a                	sd	s2,32(sp)
    4522:	ec4e                	sd	s3,24(sp)
    4524:	e852                	sd	s4,16(sp)
    4526:	0080                	addi	s0,sp,64
    4528:	8a2a                	mv	s4,a0
    452a:	06400913          	li	s2,100
    if(xst != -1) {
    452e:	59fd                	li	s3,-1
    int pid1 = fork();
    4530:	00002097          	auipc	ra,0x2
    4534:	88a080e7          	jalr	-1910(ra) # 5dba <fork>
    4538:	84aa                	mv	s1,a0
    if(pid1 < 0){
    453a:	02054f63          	bltz	a0,4578 <killstatus+0x60>
    if(pid1 == 0){
    453e:	c939                	beqz	a0,4594 <killstatus+0x7c>
    sleep(1);
    4540:	4505                	li	a0,1
    4542:	00002097          	auipc	ra,0x2
    4546:	910080e7          	jalr	-1776(ra) # 5e52 <sleep>
    kill(pid1);
    454a:	8526                	mv	a0,s1
    454c:	00002097          	auipc	ra,0x2
    4550:	8a6080e7          	jalr	-1882(ra) # 5df2 <kill>
    wait(&xst);
    4554:	fcc40513          	addi	a0,s0,-52
    4558:	00002097          	auipc	ra,0x2
    455c:	872080e7          	jalr	-1934(ra) # 5dca <wait>
    if(xst != -1) {
    4560:	fcc42783          	lw	a5,-52(s0)
    4564:	03379d63          	bne	a5,s3,459e <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    4568:	397d                	addiw	s2,s2,-1
    456a:	fc0913e3          	bnez	s2,4530 <killstatus+0x18>
  exit(0);
    456e:	4501                	li	a0,0
    4570:	00002097          	auipc	ra,0x2
    4574:	852080e7          	jalr	-1966(ra) # 5dc2 <exit>
      printf("%s: fork failed\n", s);
    4578:	85d2                	mv	a1,s4
    457a:	00002517          	auipc	a0,0x2
    457e:	62650513          	addi	a0,a0,1574 # 6ba0 <malloc+0x9a6>
    4582:	00002097          	auipc	ra,0x2
    4586:	bc0080e7          	jalr	-1088(ra) # 6142 <printf>
      exit(1);
    458a:	4505                	li	a0,1
    458c:	00002097          	auipc	ra,0x2
    4590:	836080e7          	jalr	-1994(ra) # 5dc2 <exit>
        getpid();
    4594:	00002097          	auipc	ra,0x2
    4598:	8ae080e7          	jalr	-1874(ra) # 5e42 <getpid>
      while(1) {
    459c:	bfe5                	j	4594 <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    459e:	85d2                	mv	a1,s4
    45a0:	00004517          	auipc	a0,0x4
    45a4:	8f050513          	addi	a0,a0,-1808 # 7e90 <malloc+0x1c96>
    45a8:	00002097          	auipc	ra,0x2
    45ac:	b9a080e7          	jalr	-1126(ra) # 6142 <printf>
       exit(1);
    45b0:	4505                	li	a0,1
    45b2:	00002097          	auipc	ra,0x2
    45b6:	810080e7          	jalr	-2032(ra) # 5dc2 <exit>

00000000000045ba <preempt>:
{
    45ba:	7139                	addi	sp,sp,-64
    45bc:	fc06                	sd	ra,56(sp)
    45be:	f822                	sd	s0,48(sp)
    45c0:	f426                	sd	s1,40(sp)
    45c2:	f04a                	sd	s2,32(sp)
    45c4:	ec4e                	sd	s3,24(sp)
    45c6:	e852                	sd	s4,16(sp)
    45c8:	0080                	addi	s0,sp,64
    45ca:	892a                	mv	s2,a0
  pid1 = fork();
    45cc:	00001097          	auipc	ra,0x1
    45d0:	7ee080e7          	jalr	2030(ra) # 5dba <fork>
  if(pid1 < 0) {
    45d4:	00054563          	bltz	a0,45de <preempt+0x24>
    45d8:	84aa                	mv	s1,a0
  if(pid1 == 0)
    45da:	e105                	bnez	a0,45fa <preempt+0x40>
    for(;;)
    45dc:	a001                	j	45dc <preempt+0x22>
    printf("%s: fork failed", s);
    45de:	85ca                	mv	a1,s2
    45e0:	00002517          	auipc	a0,0x2
    45e4:	78050513          	addi	a0,a0,1920 # 6d60 <malloc+0xb66>
    45e8:	00002097          	auipc	ra,0x2
    45ec:	b5a080e7          	jalr	-1190(ra) # 6142 <printf>
    exit(1);
    45f0:	4505                	li	a0,1
    45f2:	00001097          	auipc	ra,0x1
    45f6:	7d0080e7          	jalr	2000(ra) # 5dc2 <exit>
  pid2 = fork();
    45fa:	00001097          	auipc	ra,0x1
    45fe:	7c0080e7          	jalr	1984(ra) # 5dba <fork>
    4602:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    4604:	00054463          	bltz	a0,460c <preempt+0x52>
  if(pid2 == 0)
    4608:	e105                	bnez	a0,4628 <preempt+0x6e>
    for(;;)
    460a:	a001                	j	460a <preempt+0x50>
    printf("%s: fork failed\n", s);
    460c:	85ca                	mv	a1,s2
    460e:	00002517          	auipc	a0,0x2
    4612:	59250513          	addi	a0,a0,1426 # 6ba0 <malloc+0x9a6>
    4616:	00002097          	auipc	ra,0x2
    461a:	b2c080e7          	jalr	-1236(ra) # 6142 <printf>
    exit(1);
    461e:	4505                	li	a0,1
    4620:	00001097          	auipc	ra,0x1
    4624:	7a2080e7          	jalr	1954(ra) # 5dc2 <exit>
  pipe(pfds);
    4628:	fc840513          	addi	a0,s0,-56
    462c:	00001097          	auipc	ra,0x1
    4630:	7a6080e7          	jalr	1958(ra) # 5dd2 <pipe>
  pid3 = fork();
    4634:	00001097          	auipc	ra,0x1
    4638:	786080e7          	jalr	1926(ra) # 5dba <fork>
    463c:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    463e:	02054e63          	bltz	a0,467a <preempt+0xc0>
  if(pid3 == 0){
    4642:	e525                	bnez	a0,46aa <preempt+0xf0>
    close(pfds[0]);
    4644:	fc842503          	lw	a0,-56(s0)
    4648:	00001097          	auipc	ra,0x1
    464c:	7a2080e7          	jalr	1954(ra) # 5dea <close>
    if(write(pfds[1], "x", 1) != 1)
    4650:	4605                	li	a2,1
    4652:	00002597          	auipc	a1,0x2
    4656:	d3658593          	addi	a1,a1,-714 # 6388 <malloc+0x18e>
    465a:	fcc42503          	lw	a0,-52(s0)
    465e:	00001097          	auipc	ra,0x1
    4662:	784080e7          	jalr	1924(ra) # 5de2 <write>
    4666:	4785                	li	a5,1
    4668:	02f51763          	bne	a0,a5,4696 <preempt+0xdc>
    close(pfds[1]);
    466c:	fcc42503          	lw	a0,-52(s0)
    4670:	00001097          	auipc	ra,0x1
    4674:	77a080e7          	jalr	1914(ra) # 5dea <close>
    for(;;)
    4678:	a001                	j	4678 <preempt+0xbe>
     printf("%s: fork failed\n", s);
    467a:	85ca                	mv	a1,s2
    467c:	00002517          	auipc	a0,0x2
    4680:	52450513          	addi	a0,a0,1316 # 6ba0 <malloc+0x9a6>
    4684:	00002097          	auipc	ra,0x2
    4688:	abe080e7          	jalr	-1346(ra) # 6142 <printf>
     exit(1);
    468c:	4505                	li	a0,1
    468e:	00001097          	auipc	ra,0x1
    4692:	734080e7          	jalr	1844(ra) # 5dc2 <exit>
      printf("%s: preempt write error", s);
    4696:	85ca                	mv	a1,s2
    4698:	00004517          	auipc	a0,0x4
    469c:	81850513          	addi	a0,a0,-2024 # 7eb0 <malloc+0x1cb6>
    46a0:	00002097          	auipc	ra,0x2
    46a4:	aa2080e7          	jalr	-1374(ra) # 6142 <printf>
    46a8:	b7d1                	j	466c <preempt+0xb2>
  close(pfds[1]);
    46aa:	fcc42503          	lw	a0,-52(s0)
    46ae:	00001097          	auipc	ra,0x1
    46b2:	73c080e7          	jalr	1852(ra) # 5dea <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    46b6:	660d                	lui	a2,0x3
    46b8:	00008597          	auipc	a1,0x8
    46bc:	5c058593          	addi	a1,a1,1472 # cc78 <buf>
    46c0:	fc842503          	lw	a0,-56(s0)
    46c4:	00001097          	auipc	ra,0x1
    46c8:	716080e7          	jalr	1814(ra) # 5dda <read>
    46cc:	4785                	li	a5,1
    46ce:	02f50363          	beq	a0,a5,46f4 <preempt+0x13a>
    printf("%s: preempt read error", s);
    46d2:	85ca                	mv	a1,s2
    46d4:	00003517          	auipc	a0,0x3
    46d8:	7f450513          	addi	a0,a0,2036 # 7ec8 <malloc+0x1cce>
    46dc:	00002097          	auipc	ra,0x2
    46e0:	a66080e7          	jalr	-1434(ra) # 6142 <printf>
}
    46e4:	70e2                	ld	ra,56(sp)
    46e6:	7442                	ld	s0,48(sp)
    46e8:	74a2                	ld	s1,40(sp)
    46ea:	7902                	ld	s2,32(sp)
    46ec:	69e2                	ld	s3,24(sp)
    46ee:	6a42                	ld	s4,16(sp)
    46f0:	6121                	addi	sp,sp,64
    46f2:	8082                	ret
  close(pfds[0]);
    46f4:	fc842503          	lw	a0,-56(s0)
    46f8:	00001097          	auipc	ra,0x1
    46fc:	6f2080e7          	jalr	1778(ra) # 5dea <close>
  printf("kill... ");
    4700:	00003517          	auipc	a0,0x3
    4704:	7e050513          	addi	a0,a0,2016 # 7ee0 <malloc+0x1ce6>
    4708:	00002097          	auipc	ra,0x2
    470c:	a3a080e7          	jalr	-1478(ra) # 6142 <printf>
  kill(pid1);
    4710:	8526                	mv	a0,s1
    4712:	00001097          	auipc	ra,0x1
    4716:	6e0080e7          	jalr	1760(ra) # 5df2 <kill>
  kill(pid2);
    471a:	854e                	mv	a0,s3
    471c:	00001097          	auipc	ra,0x1
    4720:	6d6080e7          	jalr	1750(ra) # 5df2 <kill>
  kill(pid3);
    4724:	8552                	mv	a0,s4
    4726:	00001097          	auipc	ra,0x1
    472a:	6cc080e7          	jalr	1740(ra) # 5df2 <kill>
  printf("wait... ");
    472e:	00003517          	auipc	a0,0x3
    4732:	7c250513          	addi	a0,a0,1986 # 7ef0 <malloc+0x1cf6>
    4736:	00002097          	auipc	ra,0x2
    473a:	a0c080e7          	jalr	-1524(ra) # 6142 <printf>
  wait(0);
    473e:	4501                	li	a0,0
    4740:	00001097          	auipc	ra,0x1
    4744:	68a080e7          	jalr	1674(ra) # 5dca <wait>
  wait(0);
    4748:	4501                	li	a0,0
    474a:	00001097          	auipc	ra,0x1
    474e:	680080e7          	jalr	1664(ra) # 5dca <wait>
  wait(0);
    4752:	4501                	li	a0,0
    4754:	00001097          	auipc	ra,0x1
    4758:	676080e7          	jalr	1654(ra) # 5dca <wait>
    475c:	b761                	j	46e4 <preempt+0x12a>

000000000000475e <reparent>:
{
    475e:	7179                	addi	sp,sp,-48
    4760:	f406                	sd	ra,40(sp)
    4762:	f022                	sd	s0,32(sp)
    4764:	ec26                	sd	s1,24(sp)
    4766:	e84a                	sd	s2,16(sp)
    4768:	e44e                	sd	s3,8(sp)
    476a:	e052                	sd	s4,0(sp)
    476c:	1800                	addi	s0,sp,48
    476e:	89aa                	mv	s3,a0
  int master_pid = getpid();
    4770:	00001097          	auipc	ra,0x1
    4774:	6d2080e7          	jalr	1746(ra) # 5e42 <getpid>
    4778:	8a2a                	mv	s4,a0
    477a:	0c800913          	li	s2,200
    int pid = fork();
    477e:	00001097          	auipc	ra,0x1
    4782:	63c080e7          	jalr	1596(ra) # 5dba <fork>
    4786:	84aa                	mv	s1,a0
    if(pid < 0){
    4788:	02054263          	bltz	a0,47ac <reparent+0x4e>
    if(pid){
    478c:	cd21                	beqz	a0,47e4 <reparent+0x86>
      if(wait(0) != pid){
    478e:	4501                	li	a0,0
    4790:	00001097          	auipc	ra,0x1
    4794:	63a080e7          	jalr	1594(ra) # 5dca <wait>
    4798:	02951863          	bne	a0,s1,47c8 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    479c:	397d                	addiw	s2,s2,-1
    479e:	fe0910e3          	bnez	s2,477e <reparent+0x20>
  exit(0);
    47a2:	4501                	li	a0,0
    47a4:	00001097          	auipc	ra,0x1
    47a8:	61e080e7          	jalr	1566(ra) # 5dc2 <exit>
      printf("%s: fork failed\n", s);
    47ac:	85ce                	mv	a1,s3
    47ae:	00002517          	auipc	a0,0x2
    47b2:	3f250513          	addi	a0,a0,1010 # 6ba0 <malloc+0x9a6>
    47b6:	00002097          	auipc	ra,0x2
    47ba:	98c080e7          	jalr	-1652(ra) # 6142 <printf>
      exit(1);
    47be:	4505                	li	a0,1
    47c0:	00001097          	auipc	ra,0x1
    47c4:	602080e7          	jalr	1538(ra) # 5dc2 <exit>
        printf("%s: wait wrong pid\n", s);
    47c8:	85ce                	mv	a1,s3
    47ca:	00002517          	auipc	a0,0x2
    47ce:	55e50513          	addi	a0,a0,1374 # 6d28 <malloc+0xb2e>
    47d2:	00002097          	auipc	ra,0x2
    47d6:	970080e7          	jalr	-1680(ra) # 6142 <printf>
        exit(1);
    47da:	4505                	li	a0,1
    47dc:	00001097          	auipc	ra,0x1
    47e0:	5e6080e7          	jalr	1510(ra) # 5dc2 <exit>
      int pid2 = fork();
    47e4:	00001097          	auipc	ra,0x1
    47e8:	5d6080e7          	jalr	1494(ra) # 5dba <fork>
      if(pid2 < 0){
    47ec:	00054763          	bltz	a0,47fa <reparent+0x9c>
      exit(0);
    47f0:	4501                	li	a0,0
    47f2:	00001097          	auipc	ra,0x1
    47f6:	5d0080e7          	jalr	1488(ra) # 5dc2 <exit>
        kill(master_pid);
    47fa:	8552                	mv	a0,s4
    47fc:	00001097          	auipc	ra,0x1
    4800:	5f6080e7          	jalr	1526(ra) # 5df2 <kill>
        exit(1);
    4804:	4505                	li	a0,1
    4806:	00001097          	auipc	ra,0x1
    480a:	5bc080e7          	jalr	1468(ra) # 5dc2 <exit>

000000000000480e <sbrkfail>:
{
    480e:	7119                	addi	sp,sp,-128
    4810:	fc86                	sd	ra,120(sp)
    4812:	f8a2                	sd	s0,112(sp)
    4814:	f4a6                	sd	s1,104(sp)
    4816:	f0ca                	sd	s2,96(sp)
    4818:	ecce                	sd	s3,88(sp)
    481a:	e8d2                	sd	s4,80(sp)
    481c:	e4d6                	sd	s5,72(sp)
    481e:	0100                	addi	s0,sp,128
    4820:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    4822:	fb040513          	addi	a0,s0,-80
    4826:	00001097          	auipc	ra,0x1
    482a:	5ac080e7          	jalr	1452(ra) # 5dd2 <pipe>
    482e:	e901                	bnez	a0,483e <sbrkfail+0x30>
    4830:	f8040493          	addi	s1,s0,-128
    4834:	fa840993          	addi	s3,s0,-88
    4838:	8926                	mv	s2,s1
    if(pids[i] != -1)
    483a:	5a7d                	li	s4,-1
    483c:	a085                	j	489c <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    483e:	85d6                	mv	a1,s5
    4840:	00002517          	auipc	a0,0x2
    4844:	46850513          	addi	a0,a0,1128 # 6ca8 <malloc+0xaae>
    4848:	00002097          	auipc	ra,0x2
    484c:	8fa080e7          	jalr	-1798(ra) # 6142 <printf>
    exit(1);
    4850:	4505                	li	a0,1
    4852:	00001097          	auipc	ra,0x1
    4856:	570080e7          	jalr	1392(ra) # 5dc2 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    485a:	00001097          	auipc	ra,0x1
    485e:	5f0080e7          	jalr	1520(ra) # 5e4a <sbrk>
    4862:	064007b7          	lui	a5,0x6400
    4866:	40a7853b          	subw	a0,a5,a0
    486a:	00001097          	auipc	ra,0x1
    486e:	5e0080e7          	jalr	1504(ra) # 5e4a <sbrk>
      write(fds[1], "x", 1);
    4872:	4605                	li	a2,1
    4874:	00002597          	auipc	a1,0x2
    4878:	b1458593          	addi	a1,a1,-1260 # 6388 <malloc+0x18e>
    487c:	fb442503          	lw	a0,-76(s0)
    4880:	00001097          	auipc	ra,0x1
    4884:	562080e7          	jalr	1378(ra) # 5de2 <write>
      for(;;) sleep(1000);
    4888:	3e800513          	li	a0,1000
    488c:	00001097          	auipc	ra,0x1
    4890:	5c6080e7          	jalr	1478(ra) # 5e52 <sleep>
    4894:	bfd5                	j	4888 <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4896:	0911                	addi	s2,s2,4
    4898:	03390563          	beq	s2,s3,48c2 <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    489c:	00001097          	auipc	ra,0x1
    48a0:	51e080e7          	jalr	1310(ra) # 5dba <fork>
    48a4:	00a92023          	sw	a0,0(s2)
    48a8:	d94d                	beqz	a0,485a <sbrkfail+0x4c>
    if(pids[i] != -1)
    48aa:	ff4506e3          	beq	a0,s4,4896 <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    48ae:	4605                	li	a2,1
    48b0:	faf40593          	addi	a1,s0,-81
    48b4:	fb042503          	lw	a0,-80(s0)
    48b8:	00001097          	auipc	ra,0x1
    48bc:	522080e7          	jalr	1314(ra) # 5dda <read>
    48c0:	bfd9                	j	4896 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    48c2:	6505                	lui	a0,0x1
    48c4:	00001097          	auipc	ra,0x1
    48c8:	586080e7          	jalr	1414(ra) # 5e4a <sbrk>
    48cc:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    48ce:	597d                	li	s2,-1
    48d0:	a021                	j	48d8 <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    48d2:	0491                	addi	s1,s1,4
    48d4:	01348f63          	beq	s1,s3,48f2 <sbrkfail+0xe4>
    if(pids[i] == -1)
    48d8:	4088                	lw	a0,0(s1)
    48da:	ff250ce3          	beq	a0,s2,48d2 <sbrkfail+0xc4>
    kill(pids[i]);
    48de:	00001097          	auipc	ra,0x1
    48e2:	514080e7          	jalr	1300(ra) # 5df2 <kill>
    wait(0);
    48e6:	4501                	li	a0,0
    48e8:	00001097          	auipc	ra,0x1
    48ec:	4e2080e7          	jalr	1250(ra) # 5dca <wait>
    48f0:	b7cd                	j	48d2 <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    48f2:	57fd                	li	a5,-1
    48f4:	04fa0163          	beq	s4,a5,4936 <sbrkfail+0x128>
  pid = fork();
    48f8:	00001097          	auipc	ra,0x1
    48fc:	4c2080e7          	jalr	1218(ra) # 5dba <fork>
    4900:	84aa                	mv	s1,a0
  if(pid < 0){
    4902:	04054863          	bltz	a0,4952 <sbrkfail+0x144>
  if(pid == 0){
    4906:	c525                	beqz	a0,496e <sbrkfail+0x160>
  wait(&xstatus);
    4908:	fbc40513          	addi	a0,s0,-68
    490c:	00001097          	auipc	ra,0x1
    4910:	4be080e7          	jalr	1214(ra) # 5dca <wait>
  if(xstatus != -1 && xstatus != 2)
    4914:	fbc42783          	lw	a5,-68(s0)
    4918:	577d                	li	a4,-1
    491a:	00e78563          	beq	a5,a4,4924 <sbrkfail+0x116>
    491e:	4709                	li	a4,2
    4920:	08e79d63          	bne	a5,a4,49ba <sbrkfail+0x1ac>
}
    4924:	70e6                	ld	ra,120(sp)
    4926:	7446                	ld	s0,112(sp)
    4928:	74a6                	ld	s1,104(sp)
    492a:	7906                	ld	s2,96(sp)
    492c:	69e6                	ld	s3,88(sp)
    492e:	6a46                	ld	s4,80(sp)
    4930:	6aa6                	ld	s5,72(sp)
    4932:	6109                	addi	sp,sp,128
    4934:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    4936:	85d6                	mv	a1,s5
    4938:	00003517          	auipc	a0,0x3
    493c:	5c850513          	addi	a0,a0,1480 # 7f00 <malloc+0x1d06>
    4940:	00002097          	auipc	ra,0x2
    4944:	802080e7          	jalr	-2046(ra) # 6142 <printf>
    exit(1);
    4948:	4505                	li	a0,1
    494a:	00001097          	auipc	ra,0x1
    494e:	478080e7          	jalr	1144(ra) # 5dc2 <exit>
    printf("%s: fork failed\n", s);
    4952:	85d6                	mv	a1,s5
    4954:	00002517          	auipc	a0,0x2
    4958:	24c50513          	addi	a0,a0,588 # 6ba0 <malloc+0x9a6>
    495c:	00001097          	auipc	ra,0x1
    4960:	7e6080e7          	jalr	2022(ra) # 6142 <printf>
    exit(1);
    4964:	4505                	li	a0,1
    4966:	00001097          	auipc	ra,0x1
    496a:	45c080e7          	jalr	1116(ra) # 5dc2 <exit>
    a = sbrk(0);
    496e:	4501                	li	a0,0
    4970:	00001097          	auipc	ra,0x1
    4974:	4da080e7          	jalr	1242(ra) # 5e4a <sbrk>
    4978:	892a                	mv	s2,a0
    sbrk(10*BIG);
    497a:	3e800537          	lui	a0,0x3e800
    497e:	00001097          	auipc	ra,0x1
    4982:	4cc080e7          	jalr	1228(ra) # 5e4a <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4986:	87ca                	mv	a5,s2
    4988:	3e800737          	lui	a4,0x3e800
    498c:	993a                	add	s2,s2,a4
    498e:	6705                	lui	a4,0x1
      n += *(a+i);
    4990:	0007c683          	lbu	a3,0(a5) # 6400000 <base+0x63f0388>
    4994:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4996:	97ba                	add	a5,a5,a4
    4998:	ff279ce3          	bne	a5,s2,4990 <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    499c:	8626                	mv	a2,s1
    499e:	85d6                	mv	a1,s5
    49a0:	00003517          	auipc	a0,0x3
    49a4:	58050513          	addi	a0,a0,1408 # 7f20 <malloc+0x1d26>
    49a8:	00001097          	auipc	ra,0x1
    49ac:	79a080e7          	jalr	1946(ra) # 6142 <printf>
    exit(1);
    49b0:	4505                	li	a0,1
    49b2:	00001097          	auipc	ra,0x1
    49b6:	410080e7          	jalr	1040(ra) # 5dc2 <exit>
    exit(1);
    49ba:	4505                	li	a0,1
    49bc:	00001097          	auipc	ra,0x1
    49c0:	406080e7          	jalr	1030(ra) # 5dc2 <exit>

00000000000049c4 <mem>:
{
    49c4:	7139                	addi	sp,sp,-64
    49c6:	fc06                	sd	ra,56(sp)
    49c8:	f822                	sd	s0,48(sp)
    49ca:	f426                	sd	s1,40(sp)
    49cc:	f04a                	sd	s2,32(sp)
    49ce:	ec4e                	sd	s3,24(sp)
    49d0:	0080                	addi	s0,sp,64
    49d2:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    49d4:	00001097          	auipc	ra,0x1
    49d8:	3e6080e7          	jalr	998(ra) # 5dba <fork>
    m1 = 0;
    49dc:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    49de:	6909                	lui	s2,0x2
    49e0:	71190913          	addi	s2,s2,1809 # 2711 <copyinstr3+0x107>
  if((pid = fork()) == 0){
    49e4:	c115                	beqz	a0,4a08 <mem+0x44>
    wait(&xstatus);
    49e6:	fcc40513          	addi	a0,s0,-52
    49ea:	00001097          	auipc	ra,0x1
    49ee:	3e0080e7          	jalr	992(ra) # 5dca <wait>
    if(xstatus == -1){
    49f2:	fcc42503          	lw	a0,-52(s0)
    49f6:	57fd                	li	a5,-1
    49f8:	06f50363          	beq	a0,a5,4a5e <mem+0x9a>
    exit(xstatus);
    49fc:	00001097          	auipc	ra,0x1
    4a00:	3c6080e7          	jalr	966(ra) # 5dc2 <exit>
      *(char**)m2 = m1;
    4a04:	e104                	sd	s1,0(a0)
      m1 = m2;
    4a06:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    4a08:	854a                	mv	a0,s2
    4a0a:	00001097          	auipc	ra,0x1
    4a0e:	7f0080e7          	jalr	2032(ra) # 61fa <malloc>
    4a12:	f96d                	bnez	a0,4a04 <mem+0x40>
    while(m1){
    4a14:	c881                	beqz	s1,4a24 <mem+0x60>
      m2 = *(char**)m1;
    4a16:	8526                	mv	a0,s1
    4a18:	6084                	ld	s1,0(s1)
      free(m1);
    4a1a:	00001097          	auipc	ra,0x1
    4a1e:	75e080e7          	jalr	1886(ra) # 6178 <free>
    while(m1){
    4a22:	f8f5                	bnez	s1,4a16 <mem+0x52>
    m1 = malloc(1024*20);
    4a24:	6515                	lui	a0,0x5
    4a26:	00001097          	auipc	ra,0x1
    4a2a:	7d4080e7          	jalr	2004(ra) # 61fa <malloc>
    if(m1 == 0){
    4a2e:	c911                	beqz	a0,4a42 <mem+0x7e>
    free(m1);
    4a30:	00001097          	auipc	ra,0x1
    4a34:	748080e7          	jalr	1864(ra) # 6178 <free>
    exit(0);
    4a38:	4501                	li	a0,0
    4a3a:	00001097          	auipc	ra,0x1
    4a3e:	388080e7          	jalr	904(ra) # 5dc2 <exit>
      printf("couldn't allocate mem?!!\n", s);
    4a42:	85ce                	mv	a1,s3
    4a44:	00003517          	auipc	a0,0x3
    4a48:	50c50513          	addi	a0,a0,1292 # 7f50 <malloc+0x1d56>
    4a4c:	00001097          	auipc	ra,0x1
    4a50:	6f6080e7          	jalr	1782(ra) # 6142 <printf>
      exit(1);
    4a54:	4505                	li	a0,1
    4a56:	00001097          	auipc	ra,0x1
    4a5a:	36c080e7          	jalr	876(ra) # 5dc2 <exit>
      exit(0);
    4a5e:	4501                	li	a0,0
    4a60:	00001097          	auipc	ra,0x1
    4a64:	362080e7          	jalr	866(ra) # 5dc2 <exit>

0000000000004a68 <sharedfd>:
{
    4a68:	7159                	addi	sp,sp,-112
    4a6a:	f486                	sd	ra,104(sp)
    4a6c:	f0a2                	sd	s0,96(sp)
    4a6e:	eca6                	sd	s1,88(sp)
    4a70:	e8ca                	sd	s2,80(sp)
    4a72:	e4ce                	sd	s3,72(sp)
    4a74:	e0d2                	sd	s4,64(sp)
    4a76:	fc56                	sd	s5,56(sp)
    4a78:	f85a                	sd	s6,48(sp)
    4a7a:	f45e                	sd	s7,40(sp)
    4a7c:	1880                	addi	s0,sp,112
    4a7e:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    4a80:	00003517          	auipc	a0,0x3
    4a84:	4f050513          	addi	a0,a0,1264 # 7f70 <malloc+0x1d76>
    4a88:	00001097          	auipc	ra,0x1
    4a8c:	38a080e7          	jalr	906(ra) # 5e12 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4a90:	20200593          	li	a1,514
    4a94:	00003517          	auipc	a0,0x3
    4a98:	4dc50513          	addi	a0,a0,1244 # 7f70 <malloc+0x1d76>
    4a9c:	00001097          	auipc	ra,0x1
    4aa0:	366080e7          	jalr	870(ra) # 5e02 <open>
  if(fd < 0){
    4aa4:	04054a63          	bltz	a0,4af8 <sharedfd+0x90>
    4aa8:	892a                	mv	s2,a0
  pid = fork();
    4aaa:	00001097          	auipc	ra,0x1
    4aae:	310080e7          	jalr	784(ra) # 5dba <fork>
    4ab2:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4ab4:	07000593          	li	a1,112
    4ab8:	e119                	bnez	a0,4abe <sharedfd+0x56>
    4aba:	06300593          	li	a1,99
    4abe:	4629                	li	a2,10
    4ac0:	fa040513          	addi	a0,s0,-96
    4ac4:	00001097          	auipc	ra,0x1
    4ac8:	104080e7          	jalr	260(ra) # 5bc8 <memset>
    4acc:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4ad0:	4629                	li	a2,10
    4ad2:	fa040593          	addi	a1,s0,-96
    4ad6:	854a                	mv	a0,s2
    4ad8:	00001097          	auipc	ra,0x1
    4adc:	30a080e7          	jalr	778(ra) # 5de2 <write>
    4ae0:	47a9                	li	a5,10
    4ae2:	02f51963          	bne	a0,a5,4b14 <sharedfd+0xac>
  for(i = 0; i < N; i++){
    4ae6:	34fd                	addiw	s1,s1,-1
    4ae8:	f4e5                	bnez	s1,4ad0 <sharedfd+0x68>
  if(pid == 0) {
    4aea:	04099363          	bnez	s3,4b30 <sharedfd+0xc8>
    exit(0);
    4aee:	4501                	li	a0,0
    4af0:	00001097          	auipc	ra,0x1
    4af4:	2d2080e7          	jalr	722(ra) # 5dc2 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4af8:	85d2                	mv	a1,s4
    4afa:	00003517          	auipc	a0,0x3
    4afe:	48650513          	addi	a0,a0,1158 # 7f80 <malloc+0x1d86>
    4b02:	00001097          	auipc	ra,0x1
    4b06:	640080e7          	jalr	1600(ra) # 6142 <printf>
    exit(1);
    4b0a:	4505                	li	a0,1
    4b0c:	00001097          	auipc	ra,0x1
    4b10:	2b6080e7          	jalr	694(ra) # 5dc2 <exit>
      printf("%s: write sharedfd failed\n", s);
    4b14:	85d2                	mv	a1,s4
    4b16:	00003517          	auipc	a0,0x3
    4b1a:	49250513          	addi	a0,a0,1170 # 7fa8 <malloc+0x1dae>
    4b1e:	00001097          	auipc	ra,0x1
    4b22:	624080e7          	jalr	1572(ra) # 6142 <printf>
      exit(1);
    4b26:	4505                	li	a0,1
    4b28:	00001097          	auipc	ra,0x1
    4b2c:	29a080e7          	jalr	666(ra) # 5dc2 <exit>
    wait(&xstatus);
    4b30:	f9c40513          	addi	a0,s0,-100
    4b34:	00001097          	auipc	ra,0x1
    4b38:	296080e7          	jalr	662(ra) # 5dca <wait>
    if(xstatus != 0)
    4b3c:	f9c42983          	lw	s3,-100(s0)
    4b40:	00098763          	beqz	s3,4b4e <sharedfd+0xe6>
      exit(xstatus);
    4b44:	854e                	mv	a0,s3
    4b46:	00001097          	auipc	ra,0x1
    4b4a:	27c080e7          	jalr	636(ra) # 5dc2 <exit>
  close(fd);
    4b4e:	854a                	mv	a0,s2
    4b50:	00001097          	auipc	ra,0x1
    4b54:	29a080e7          	jalr	666(ra) # 5dea <close>
  fd = open("sharedfd", 0);
    4b58:	4581                	li	a1,0
    4b5a:	00003517          	auipc	a0,0x3
    4b5e:	41650513          	addi	a0,a0,1046 # 7f70 <malloc+0x1d76>
    4b62:	00001097          	auipc	ra,0x1
    4b66:	2a0080e7          	jalr	672(ra) # 5e02 <open>
    4b6a:	8baa                	mv	s7,a0
  nc = np = 0;
    4b6c:	8ace                	mv	s5,s3
  if(fd < 0){
    4b6e:	02054563          	bltz	a0,4b98 <sharedfd+0x130>
    4b72:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    4b76:	06300493          	li	s1,99
      if(buf[i] == 'p')
    4b7a:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4b7e:	4629                	li	a2,10
    4b80:	fa040593          	addi	a1,s0,-96
    4b84:	855e                	mv	a0,s7
    4b86:	00001097          	auipc	ra,0x1
    4b8a:	254080e7          	jalr	596(ra) # 5dda <read>
    4b8e:	02a05f63          	blez	a0,4bcc <sharedfd+0x164>
    4b92:	fa040793          	addi	a5,s0,-96
    4b96:	a01d                	j	4bbc <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4b98:	85d2                	mv	a1,s4
    4b9a:	00003517          	auipc	a0,0x3
    4b9e:	42e50513          	addi	a0,a0,1070 # 7fc8 <malloc+0x1dce>
    4ba2:	00001097          	auipc	ra,0x1
    4ba6:	5a0080e7          	jalr	1440(ra) # 6142 <printf>
    exit(1);
    4baa:	4505                	li	a0,1
    4bac:	00001097          	auipc	ra,0x1
    4bb0:	216080e7          	jalr	534(ra) # 5dc2 <exit>
        nc++;
    4bb4:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4bb6:	0785                	addi	a5,a5,1
    4bb8:	fd2783e3          	beq	a5,s2,4b7e <sharedfd+0x116>
      if(buf[i] == 'c')
    4bbc:	0007c703          	lbu	a4,0(a5)
    4bc0:	fe970ae3          	beq	a4,s1,4bb4 <sharedfd+0x14c>
      if(buf[i] == 'p')
    4bc4:	ff6719e3          	bne	a4,s6,4bb6 <sharedfd+0x14e>
        np++;
    4bc8:	2a85                	addiw	s5,s5,1
    4bca:	b7f5                	j	4bb6 <sharedfd+0x14e>
  close(fd);
    4bcc:	855e                	mv	a0,s7
    4bce:	00001097          	auipc	ra,0x1
    4bd2:	21c080e7          	jalr	540(ra) # 5dea <close>
  unlink("sharedfd");
    4bd6:	00003517          	auipc	a0,0x3
    4bda:	39a50513          	addi	a0,a0,922 # 7f70 <malloc+0x1d76>
    4bde:	00001097          	auipc	ra,0x1
    4be2:	234080e7          	jalr	564(ra) # 5e12 <unlink>
  if(nc == N*SZ && np == N*SZ){
    4be6:	6789                	lui	a5,0x2
    4be8:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0x106>
    4bec:	00f99763          	bne	s3,a5,4bfa <sharedfd+0x192>
    4bf0:	6789                	lui	a5,0x2
    4bf2:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0x106>
    4bf6:	02fa8063          	beq	s5,a5,4c16 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4bfa:	85d2                	mv	a1,s4
    4bfc:	00003517          	auipc	a0,0x3
    4c00:	3f450513          	addi	a0,a0,1012 # 7ff0 <malloc+0x1df6>
    4c04:	00001097          	auipc	ra,0x1
    4c08:	53e080e7          	jalr	1342(ra) # 6142 <printf>
    exit(1);
    4c0c:	4505                	li	a0,1
    4c0e:	00001097          	auipc	ra,0x1
    4c12:	1b4080e7          	jalr	436(ra) # 5dc2 <exit>
    exit(0);
    4c16:	4501                	li	a0,0
    4c18:	00001097          	auipc	ra,0x1
    4c1c:	1aa080e7          	jalr	426(ra) # 5dc2 <exit>

0000000000004c20 <fourfiles>:
{
    4c20:	7135                	addi	sp,sp,-160
    4c22:	ed06                	sd	ra,152(sp)
    4c24:	e922                	sd	s0,144(sp)
    4c26:	e526                	sd	s1,136(sp)
    4c28:	e14a                	sd	s2,128(sp)
    4c2a:	fcce                	sd	s3,120(sp)
    4c2c:	f8d2                	sd	s4,112(sp)
    4c2e:	f4d6                	sd	s5,104(sp)
    4c30:	f0da                	sd	s6,96(sp)
    4c32:	ecde                	sd	s7,88(sp)
    4c34:	e8e2                	sd	s8,80(sp)
    4c36:	e4e6                	sd	s9,72(sp)
    4c38:	e0ea                	sd	s10,64(sp)
    4c3a:	fc6e                	sd	s11,56(sp)
    4c3c:	1100                	addi	s0,sp,160
    4c3e:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c40:	00003797          	auipc	a5,0x3
    4c44:	3c878793          	addi	a5,a5,968 # 8008 <malloc+0x1e0e>
    4c48:	f6f43823          	sd	a5,-144(s0)
    4c4c:	00003797          	auipc	a5,0x3
    4c50:	3c478793          	addi	a5,a5,964 # 8010 <malloc+0x1e16>
    4c54:	f6f43c23          	sd	a5,-136(s0)
    4c58:	00003797          	auipc	a5,0x3
    4c5c:	3c078793          	addi	a5,a5,960 # 8018 <malloc+0x1e1e>
    4c60:	f8f43023          	sd	a5,-128(s0)
    4c64:	00003797          	auipc	a5,0x3
    4c68:	3bc78793          	addi	a5,a5,956 # 8020 <malloc+0x1e26>
    4c6c:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    4c70:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c74:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    4c76:	4481                	li	s1,0
    4c78:	4a11                	li	s4,4
    fname = names[pi];
    4c7a:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4c7e:	854e                	mv	a0,s3
    4c80:	00001097          	auipc	ra,0x1
    4c84:	192080e7          	jalr	402(ra) # 5e12 <unlink>
    pid = fork();
    4c88:	00001097          	auipc	ra,0x1
    4c8c:	132080e7          	jalr	306(ra) # 5dba <fork>
    if(pid < 0){
    4c90:	04054063          	bltz	a0,4cd0 <fourfiles+0xb0>
    if(pid == 0){
    4c94:	cd21                	beqz	a0,4cec <fourfiles+0xcc>
  for(pi = 0; pi < NCHILD; pi++){
    4c96:	2485                	addiw	s1,s1,1
    4c98:	0921                	addi	s2,s2,8
    4c9a:	ff4490e3          	bne	s1,s4,4c7a <fourfiles+0x5a>
    4c9e:	4491                	li	s1,4
    wait(&xstatus);
    4ca0:	f6c40513          	addi	a0,s0,-148
    4ca4:	00001097          	auipc	ra,0x1
    4ca8:	126080e7          	jalr	294(ra) # 5dca <wait>
    if(xstatus != 0)
    4cac:	f6c42a83          	lw	s5,-148(s0)
    4cb0:	0c0a9863          	bnez	s5,4d80 <fourfiles+0x160>
  for(pi = 0; pi < NCHILD; pi++){
    4cb4:	34fd                	addiw	s1,s1,-1
    4cb6:	f4ed                	bnez	s1,4ca0 <fourfiles+0x80>
    4cb8:	03000b13          	li	s6,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4cbc:	00008a17          	auipc	s4,0x8
    4cc0:	fbca0a13          	addi	s4,s4,-68 # cc78 <buf>
    if(total != N*SZ){
    4cc4:	6d05                	lui	s10,0x1
    4cc6:	770d0d13          	addi	s10,s10,1904 # 1770 <exectest+0x30>
  for(i = 0; i < NCHILD; i++){
    4cca:	03400d93          	li	s11,52
    4cce:	a22d                	j	4df8 <fourfiles+0x1d8>
      printf("fork failed\n", s);
    4cd0:	85e6                	mv	a1,s9
    4cd2:	00002517          	auipc	a0,0x2
    4cd6:	2d650513          	addi	a0,a0,726 # 6fa8 <malloc+0xdae>
    4cda:	00001097          	auipc	ra,0x1
    4cde:	468080e7          	jalr	1128(ra) # 6142 <printf>
      exit(1);
    4ce2:	4505                	li	a0,1
    4ce4:	00001097          	auipc	ra,0x1
    4ce8:	0de080e7          	jalr	222(ra) # 5dc2 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4cec:	20200593          	li	a1,514
    4cf0:	854e                	mv	a0,s3
    4cf2:	00001097          	auipc	ra,0x1
    4cf6:	110080e7          	jalr	272(ra) # 5e02 <open>
    4cfa:	892a                	mv	s2,a0
      if(fd < 0){
    4cfc:	04054763          	bltz	a0,4d4a <fourfiles+0x12a>
      memset(buf, '0'+pi, SZ);
    4d00:	1f400613          	li	a2,500
    4d04:	0304859b          	addiw	a1,s1,48
    4d08:	00008517          	auipc	a0,0x8
    4d0c:	f7050513          	addi	a0,a0,-144 # cc78 <buf>
    4d10:	00001097          	auipc	ra,0x1
    4d14:	eb8080e7          	jalr	-328(ra) # 5bc8 <memset>
    4d18:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4d1a:	00008997          	auipc	s3,0x8
    4d1e:	f5e98993          	addi	s3,s3,-162 # cc78 <buf>
    4d22:	1f400613          	li	a2,500
    4d26:	85ce                	mv	a1,s3
    4d28:	854a                	mv	a0,s2
    4d2a:	00001097          	auipc	ra,0x1
    4d2e:	0b8080e7          	jalr	184(ra) # 5de2 <write>
    4d32:	85aa                	mv	a1,a0
    4d34:	1f400793          	li	a5,500
    4d38:	02f51763          	bne	a0,a5,4d66 <fourfiles+0x146>
      for(i = 0; i < N; i++){
    4d3c:	34fd                	addiw	s1,s1,-1
    4d3e:	f0f5                	bnez	s1,4d22 <fourfiles+0x102>
      exit(0);
    4d40:	4501                	li	a0,0
    4d42:	00001097          	auipc	ra,0x1
    4d46:	080080e7          	jalr	128(ra) # 5dc2 <exit>
        printf("create failed\n", s);
    4d4a:	85e6                	mv	a1,s9
    4d4c:	00003517          	auipc	a0,0x3
    4d50:	2dc50513          	addi	a0,a0,732 # 8028 <malloc+0x1e2e>
    4d54:	00001097          	auipc	ra,0x1
    4d58:	3ee080e7          	jalr	1006(ra) # 6142 <printf>
        exit(1);
    4d5c:	4505                	li	a0,1
    4d5e:	00001097          	auipc	ra,0x1
    4d62:	064080e7          	jalr	100(ra) # 5dc2 <exit>
          printf("write failed %d\n", n);
    4d66:	00003517          	auipc	a0,0x3
    4d6a:	2d250513          	addi	a0,a0,722 # 8038 <malloc+0x1e3e>
    4d6e:	00001097          	auipc	ra,0x1
    4d72:	3d4080e7          	jalr	980(ra) # 6142 <printf>
          exit(1);
    4d76:	4505                	li	a0,1
    4d78:	00001097          	auipc	ra,0x1
    4d7c:	04a080e7          	jalr	74(ra) # 5dc2 <exit>
      exit(xstatus);
    4d80:	8556                	mv	a0,s5
    4d82:	00001097          	auipc	ra,0x1
    4d86:	040080e7          	jalr	64(ra) # 5dc2 <exit>
          printf("wrong char\n", s);
    4d8a:	85e6                	mv	a1,s9
    4d8c:	00003517          	auipc	a0,0x3
    4d90:	2c450513          	addi	a0,a0,708 # 8050 <malloc+0x1e56>
    4d94:	00001097          	auipc	ra,0x1
    4d98:	3ae080e7          	jalr	942(ra) # 6142 <printf>
          exit(1);
    4d9c:	4505                	li	a0,1
    4d9e:	00001097          	auipc	ra,0x1
    4da2:	024080e7          	jalr	36(ra) # 5dc2 <exit>
      total += n;
    4da6:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4daa:	660d                	lui	a2,0x3
    4dac:	85d2                	mv	a1,s4
    4dae:	854e                	mv	a0,s3
    4db0:	00001097          	auipc	ra,0x1
    4db4:	02a080e7          	jalr	42(ra) # 5dda <read>
    4db8:	02a05063          	blez	a0,4dd8 <fourfiles+0x1b8>
    4dbc:	00008797          	auipc	a5,0x8
    4dc0:	ebc78793          	addi	a5,a5,-324 # cc78 <buf>
    4dc4:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    4dc8:	0007c703          	lbu	a4,0(a5)
    4dcc:	fa971fe3          	bne	a4,s1,4d8a <fourfiles+0x16a>
      for(j = 0; j < n; j++){
    4dd0:	0785                	addi	a5,a5,1
    4dd2:	fed79be3          	bne	a5,a3,4dc8 <fourfiles+0x1a8>
    4dd6:	bfc1                	j	4da6 <fourfiles+0x186>
    close(fd);
    4dd8:	854e                	mv	a0,s3
    4dda:	00001097          	auipc	ra,0x1
    4dde:	010080e7          	jalr	16(ra) # 5dea <close>
    if(total != N*SZ){
    4de2:	03a91863          	bne	s2,s10,4e12 <fourfiles+0x1f2>
    unlink(fname);
    4de6:	8562                	mv	a0,s8
    4de8:	00001097          	auipc	ra,0x1
    4dec:	02a080e7          	jalr	42(ra) # 5e12 <unlink>
  for(i = 0; i < NCHILD; i++){
    4df0:	0ba1                	addi	s7,s7,8
    4df2:	2b05                	addiw	s6,s6,1
    4df4:	03bb0d63          	beq	s6,s11,4e2e <fourfiles+0x20e>
    fname = names[i];
    4df8:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    4dfc:	4581                	li	a1,0
    4dfe:	8562                	mv	a0,s8
    4e00:	00001097          	auipc	ra,0x1
    4e04:	002080e7          	jalr	2(ra) # 5e02 <open>
    4e08:	89aa                	mv	s3,a0
    total = 0;
    4e0a:	8956                	mv	s2,s5
        if(buf[j] != '0'+i){
    4e0c:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4e10:	bf69                	j	4daa <fourfiles+0x18a>
      printf("wrong length %d\n", total);
    4e12:	85ca                	mv	a1,s2
    4e14:	00003517          	auipc	a0,0x3
    4e18:	24c50513          	addi	a0,a0,588 # 8060 <malloc+0x1e66>
    4e1c:	00001097          	auipc	ra,0x1
    4e20:	326080e7          	jalr	806(ra) # 6142 <printf>
      exit(1);
    4e24:	4505                	li	a0,1
    4e26:	00001097          	auipc	ra,0x1
    4e2a:	f9c080e7          	jalr	-100(ra) # 5dc2 <exit>
}
    4e2e:	60ea                	ld	ra,152(sp)
    4e30:	644a                	ld	s0,144(sp)
    4e32:	64aa                	ld	s1,136(sp)
    4e34:	690a                	ld	s2,128(sp)
    4e36:	79e6                	ld	s3,120(sp)
    4e38:	7a46                	ld	s4,112(sp)
    4e3a:	7aa6                	ld	s5,104(sp)
    4e3c:	7b06                	ld	s6,96(sp)
    4e3e:	6be6                	ld	s7,88(sp)
    4e40:	6c46                	ld	s8,80(sp)
    4e42:	6ca6                	ld	s9,72(sp)
    4e44:	6d06                	ld	s10,64(sp)
    4e46:	7de2                	ld	s11,56(sp)
    4e48:	610d                	addi	sp,sp,160
    4e4a:	8082                	ret

0000000000004e4c <concreate>:
{
    4e4c:	7135                	addi	sp,sp,-160
    4e4e:	ed06                	sd	ra,152(sp)
    4e50:	e922                	sd	s0,144(sp)
    4e52:	e526                	sd	s1,136(sp)
    4e54:	e14a                	sd	s2,128(sp)
    4e56:	fcce                	sd	s3,120(sp)
    4e58:	f8d2                	sd	s4,112(sp)
    4e5a:	f4d6                	sd	s5,104(sp)
    4e5c:	f0da                	sd	s6,96(sp)
    4e5e:	ecde                	sd	s7,88(sp)
    4e60:	1100                	addi	s0,sp,160
    4e62:	89aa                	mv	s3,a0
  file[0] = 'C';
    4e64:	04300793          	li	a5,67
    4e68:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    4e6c:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    4e70:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    4e72:	4b0d                	li	s6,3
    4e74:	4a85                	li	s5,1
      link("C0", file);
    4e76:	00003b97          	auipc	s7,0x3
    4e7a:	202b8b93          	addi	s7,s7,514 # 8078 <malloc+0x1e7e>
  for(i = 0; i < N; i++){
    4e7e:	02800a13          	li	s4,40
    4e82:	acc9                	j	5154 <concreate+0x308>
      link("C0", file);
    4e84:	fa840593          	addi	a1,s0,-88
    4e88:	855e                	mv	a0,s7
    4e8a:	00001097          	auipc	ra,0x1
    4e8e:	f98080e7          	jalr	-104(ra) # 5e22 <link>
    if(pid == 0) {
    4e92:	a465                	j	513a <concreate+0x2ee>
    } else if(pid == 0 && (i % 5) == 1){
    4e94:	4795                	li	a5,5
    4e96:	02f9693b          	remw	s2,s2,a5
    4e9a:	4785                	li	a5,1
    4e9c:	02f90b63          	beq	s2,a5,4ed2 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4ea0:	20200593          	li	a1,514
    4ea4:	fa840513          	addi	a0,s0,-88
    4ea8:	00001097          	auipc	ra,0x1
    4eac:	f5a080e7          	jalr	-166(ra) # 5e02 <open>
      if(fd < 0){
    4eb0:	26055c63          	bgez	a0,5128 <concreate+0x2dc>
        printf("concreate create %s failed\n", file);
    4eb4:	fa840593          	addi	a1,s0,-88
    4eb8:	00003517          	auipc	a0,0x3
    4ebc:	1c850513          	addi	a0,a0,456 # 8080 <malloc+0x1e86>
    4ec0:	00001097          	auipc	ra,0x1
    4ec4:	282080e7          	jalr	642(ra) # 6142 <printf>
        exit(1);
    4ec8:	4505                	li	a0,1
    4eca:	00001097          	auipc	ra,0x1
    4ece:	ef8080e7          	jalr	-264(ra) # 5dc2 <exit>
      link("C0", file);
    4ed2:	fa840593          	addi	a1,s0,-88
    4ed6:	00003517          	auipc	a0,0x3
    4eda:	1a250513          	addi	a0,a0,418 # 8078 <malloc+0x1e7e>
    4ede:	00001097          	auipc	ra,0x1
    4ee2:	f44080e7          	jalr	-188(ra) # 5e22 <link>
      exit(0);
    4ee6:	4501                	li	a0,0
    4ee8:	00001097          	auipc	ra,0x1
    4eec:	eda080e7          	jalr	-294(ra) # 5dc2 <exit>
        exit(1);
    4ef0:	4505                	li	a0,1
    4ef2:	00001097          	auipc	ra,0x1
    4ef6:	ed0080e7          	jalr	-304(ra) # 5dc2 <exit>
  memset(fa, 0, sizeof(fa));
    4efa:	02800613          	li	a2,40
    4efe:	4581                	li	a1,0
    4f00:	f8040513          	addi	a0,s0,-128
    4f04:	00001097          	auipc	ra,0x1
    4f08:	cc4080e7          	jalr	-828(ra) # 5bc8 <memset>
  fd = open(".", 0);
    4f0c:	4581                	li	a1,0
    4f0e:	00002517          	auipc	a0,0x2
    4f12:	af250513          	addi	a0,a0,-1294 # 6a00 <malloc+0x806>
    4f16:	00001097          	auipc	ra,0x1
    4f1a:	eec080e7          	jalr	-276(ra) # 5e02 <open>
    4f1e:	892a                	mv	s2,a0
  n = 0;
    4f20:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f22:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4f26:	02700b13          	li	s6,39
      fa[i] = 1;
    4f2a:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4f2c:	4641                	li	a2,16
    4f2e:	f7040593          	addi	a1,s0,-144
    4f32:	854a                	mv	a0,s2
    4f34:	00001097          	auipc	ra,0x1
    4f38:	ea6080e7          	jalr	-346(ra) # 5dda <read>
    4f3c:	08a05263          	blez	a0,4fc0 <concreate+0x174>
    if(de.inum == 0)
    4f40:	f7045783          	lhu	a5,-144(s0)
    4f44:	d7e5                	beqz	a5,4f2c <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f46:	f7244783          	lbu	a5,-142(s0)
    4f4a:	ff4791e3          	bne	a5,s4,4f2c <concreate+0xe0>
    4f4e:	f7444783          	lbu	a5,-140(s0)
    4f52:	ffe9                	bnez	a5,4f2c <concreate+0xe0>
      i = de.name[1] - '0';
    4f54:	f7344783          	lbu	a5,-141(s0)
    4f58:	fd07879b          	addiw	a5,a5,-48
    4f5c:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4f60:	02eb6063          	bltu	s6,a4,4f80 <concreate+0x134>
      if(fa[i]){
    4f64:	fb070793          	addi	a5,a4,-80 # fb0 <linktest+0xbc>
    4f68:	97a2                	add	a5,a5,s0
    4f6a:	fd07c783          	lbu	a5,-48(a5)
    4f6e:	eb8d                	bnez	a5,4fa0 <concreate+0x154>
      fa[i] = 1;
    4f70:	fb070793          	addi	a5,a4,-80
    4f74:	00878733          	add	a4,a5,s0
    4f78:	fd770823          	sb	s7,-48(a4)
      n++;
    4f7c:	2a85                	addiw	s5,s5,1
    4f7e:	b77d                	j	4f2c <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4f80:	f7240613          	addi	a2,s0,-142
    4f84:	85ce                	mv	a1,s3
    4f86:	00003517          	auipc	a0,0x3
    4f8a:	11a50513          	addi	a0,a0,282 # 80a0 <malloc+0x1ea6>
    4f8e:	00001097          	auipc	ra,0x1
    4f92:	1b4080e7          	jalr	436(ra) # 6142 <printf>
        exit(1);
    4f96:	4505                	li	a0,1
    4f98:	00001097          	auipc	ra,0x1
    4f9c:	e2a080e7          	jalr	-470(ra) # 5dc2 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4fa0:	f7240613          	addi	a2,s0,-142
    4fa4:	85ce                	mv	a1,s3
    4fa6:	00003517          	auipc	a0,0x3
    4faa:	11a50513          	addi	a0,a0,282 # 80c0 <malloc+0x1ec6>
    4fae:	00001097          	auipc	ra,0x1
    4fb2:	194080e7          	jalr	404(ra) # 6142 <printf>
        exit(1);
    4fb6:	4505                	li	a0,1
    4fb8:	00001097          	auipc	ra,0x1
    4fbc:	e0a080e7          	jalr	-502(ra) # 5dc2 <exit>
  close(fd);
    4fc0:	854a                	mv	a0,s2
    4fc2:	00001097          	auipc	ra,0x1
    4fc6:	e28080e7          	jalr	-472(ra) # 5dea <close>
  if(n != N){
    4fca:	02800793          	li	a5,40
    4fce:	00fa9763          	bne	s5,a5,4fdc <concreate+0x190>
    if(((i % 3) == 0 && pid == 0) ||
    4fd2:	4a8d                	li	s5,3
    4fd4:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4fd6:	02800a13          	li	s4,40
    4fda:	a8c9                	j	50ac <concreate+0x260>
    printf("%s: concreate not enough files in directory listing\n", s);
    4fdc:	85ce                	mv	a1,s3
    4fde:	00003517          	auipc	a0,0x3
    4fe2:	10a50513          	addi	a0,a0,266 # 80e8 <malloc+0x1eee>
    4fe6:	00001097          	auipc	ra,0x1
    4fea:	15c080e7          	jalr	348(ra) # 6142 <printf>
    exit(1);
    4fee:	4505                	li	a0,1
    4ff0:	00001097          	auipc	ra,0x1
    4ff4:	dd2080e7          	jalr	-558(ra) # 5dc2 <exit>
      printf("%s: fork failed\n", s);
    4ff8:	85ce                	mv	a1,s3
    4ffa:	00002517          	auipc	a0,0x2
    4ffe:	ba650513          	addi	a0,a0,-1114 # 6ba0 <malloc+0x9a6>
    5002:	00001097          	auipc	ra,0x1
    5006:	140080e7          	jalr	320(ra) # 6142 <printf>
      exit(1);
    500a:	4505                	li	a0,1
    500c:	00001097          	auipc	ra,0x1
    5010:	db6080e7          	jalr	-586(ra) # 5dc2 <exit>
      close(open(file, 0));
    5014:	4581                	li	a1,0
    5016:	fa840513          	addi	a0,s0,-88
    501a:	00001097          	auipc	ra,0x1
    501e:	de8080e7          	jalr	-536(ra) # 5e02 <open>
    5022:	00001097          	auipc	ra,0x1
    5026:	dc8080e7          	jalr	-568(ra) # 5dea <close>
      close(open(file, 0));
    502a:	4581                	li	a1,0
    502c:	fa840513          	addi	a0,s0,-88
    5030:	00001097          	auipc	ra,0x1
    5034:	dd2080e7          	jalr	-558(ra) # 5e02 <open>
    5038:	00001097          	auipc	ra,0x1
    503c:	db2080e7          	jalr	-590(ra) # 5dea <close>
      close(open(file, 0));
    5040:	4581                	li	a1,0
    5042:	fa840513          	addi	a0,s0,-88
    5046:	00001097          	auipc	ra,0x1
    504a:	dbc080e7          	jalr	-580(ra) # 5e02 <open>
    504e:	00001097          	auipc	ra,0x1
    5052:	d9c080e7          	jalr	-612(ra) # 5dea <close>
      close(open(file, 0));
    5056:	4581                	li	a1,0
    5058:	fa840513          	addi	a0,s0,-88
    505c:	00001097          	auipc	ra,0x1
    5060:	da6080e7          	jalr	-602(ra) # 5e02 <open>
    5064:	00001097          	auipc	ra,0x1
    5068:	d86080e7          	jalr	-634(ra) # 5dea <close>
      close(open(file, 0));
    506c:	4581                	li	a1,0
    506e:	fa840513          	addi	a0,s0,-88
    5072:	00001097          	auipc	ra,0x1
    5076:	d90080e7          	jalr	-624(ra) # 5e02 <open>
    507a:	00001097          	auipc	ra,0x1
    507e:	d70080e7          	jalr	-656(ra) # 5dea <close>
      close(open(file, 0));
    5082:	4581                	li	a1,0
    5084:	fa840513          	addi	a0,s0,-88
    5088:	00001097          	auipc	ra,0x1
    508c:	d7a080e7          	jalr	-646(ra) # 5e02 <open>
    5090:	00001097          	auipc	ra,0x1
    5094:	d5a080e7          	jalr	-678(ra) # 5dea <close>
    if(pid == 0)
    5098:	08090363          	beqz	s2,511e <concreate+0x2d2>
      wait(0);
    509c:	4501                	li	a0,0
    509e:	00001097          	auipc	ra,0x1
    50a2:	d2c080e7          	jalr	-724(ra) # 5dca <wait>
  for(i = 0; i < N; i++){
    50a6:	2485                	addiw	s1,s1,1
    50a8:	0f448563          	beq	s1,s4,5192 <concreate+0x346>
    file[1] = '0' + i;
    50ac:	0304879b          	addiw	a5,s1,48
    50b0:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    50b4:	00001097          	auipc	ra,0x1
    50b8:	d06080e7          	jalr	-762(ra) # 5dba <fork>
    50bc:	892a                	mv	s2,a0
    if(pid < 0){
    50be:	f2054de3          	bltz	a0,4ff8 <concreate+0x1ac>
    if(((i % 3) == 0 && pid == 0) ||
    50c2:	0354e73b          	remw	a4,s1,s5
    50c6:	00a767b3          	or	a5,a4,a0
    50ca:	2781                	sext.w	a5,a5
    50cc:	d7a1                	beqz	a5,5014 <concreate+0x1c8>
    50ce:	01671363          	bne	a4,s6,50d4 <concreate+0x288>
       ((i % 3) == 1 && pid != 0)){
    50d2:	f129                	bnez	a0,5014 <concreate+0x1c8>
      unlink(file);
    50d4:	fa840513          	addi	a0,s0,-88
    50d8:	00001097          	auipc	ra,0x1
    50dc:	d3a080e7          	jalr	-710(ra) # 5e12 <unlink>
      unlink(file);
    50e0:	fa840513          	addi	a0,s0,-88
    50e4:	00001097          	auipc	ra,0x1
    50e8:	d2e080e7          	jalr	-722(ra) # 5e12 <unlink>
      unlink(file);
    50ec:	fa840513          	addi	a0,s0,-88
    50f0:	00001097          	auipc	ra,0x1
    50f4:	d22080e7          	jalr	-734(ra) # 5e12 <unlink>
      unlink(file);
    50f8:	fa840513          	addi	a0,s0,-88
    50fc:	00001097          	auipc	ra,0x1
    5100:	d16080e7          	jalr	-746(ra) # 5e12 <unlink>
      unlink(file);
    5104:	fa840513          	addi	a0,s0,-88
    5108:	00001097          	auipc	ra,0x1
    510c:	d0a080e7          	jalr	-758(ra) # 5e12 <unlink>
      unlink(file);
    5110:	fa840513          	addi	a0,s0,-88
    5114:	00001097          	auipc	ra,0x1
    5118:	cfe080e7          	jalr	-770(ra) # 5e12 <unlink>
    511c:	bfb5                	j	5098 <concreate+0x24c>
      exit(0);
    511e:	4501                	li	a0,0
    5120:	00001097          	auipc	ra,0x1
    5124:	ca2080e7          	jalr	-862(ra) # 5dc2 <exit>
      close(fd);
    5128:	00001097          	auipc	ra,0x1
    512c:	cc2080e7          	jalr	-830(ra) # 5dea <close>
    if(pid == 0) {
    5130:	bb5d                	j	4ee6 <concreate+0x9a>
      close(fd);
    5132:	00001097          	auipc	ra,0x1
    5136:	cb8080e7          	jalr	-840(ra) # 5dea <close>
      wait(&xstatus);
    513a:	f6c40513          	addi	a0,s0,-148
    513e:	00001097          	auipc	ra,0x1
    5142:	c8c080e7          	jalr	-884(ra) # 5dca <wait>
      if(xstatus != 0)
    5146:	f6c42483          	lw	s1,-148(s0)
    514a:	da0493e3          	bnez	s1,4ef0 <concreate+0xa4>
  for(i = 0; i < N; i++){
    514e:	2905                	addiw	s2,s2,1
    5150:	db4905e3          	beq	s2,s4,4efa <concreate+0xae>
    file[1] = '0' + i;
    5154:	0309079b          	addiw	a5,s2,48
    5158:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    515c:	fa840513          	addi	a0,s0,-88
    5160:	00001097          	auipc	ra,0x1
    5164:	cb2080e7          	jalr	-846(ra) # 5e12 <unlink>
    pid = fork();
    5168:	00001097          	auipc	ra,0x1
    516c:	c52080e7          	jalr	-942(ra) # 5dba <fork>
    if(pid && (i % 3) == 1){
    5170:	d20502e3          	beqz	a0,4e94 <concreate+0x48>
    5174:	036967bb          	remw	a5,s2,s6
    5178:	d15786e3          	beq	a5,s5,4e84 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    517c:	20200593          	li	a1,514
    5180:	fa840513          	addi	a0,s0,-88
    5184:	00001097          	auipc	ra,0x1
    5188:	c7e080e7          	jalr	-898(ra) # 5e02 <open>
      if(fd < 0){
    518c:	fa0553e3          	bgez	a0,5132 <concreate+0x2e6>
    5190:	b315                	j	4eb4 <concreate+0x68>
}
    5192:	60ea                	ld	ra,152(sp)
    5194:	644a                	ld	s0,144(sp)
    5196:	64aa                	ld	s1,136(sp)
    5198:	690a                	ld	s2,128(sp)
    519a:	79e6                	ld	s3,120(sp)
    519c:	7a46                	ld	s4,112(sp)
    519e:	7aa6                	ld	s5,104(sp)
    51a0:	7b06                	ld	s6,96(sp)
    51a2:	6be6                	ld	s7,88(sp)
    51a4:	610d                	addi	sp,sp,160
    51a6:	8082                	ret

00000000000051a8 <bigfile>:
{
    51a8:	7139                	addi	sp,sp,-64
    51aa:	fc06                	sd	ra,56(sp)
    51ac:	f822                	sd	s0,48(sp)
    51ae:	f426                	sd	s1,40(sp)
    51b0:	f04a                	sd	s2,32(sp)
    51b2:	ec4e                	sd	s3,24(sp)
    51b4:	e852                	sd	s4,16(sp)
    51b6:	e456                	sd	s5,8(sp)
    51b8:	0080                	addi	s0,sp,64
    51ba:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    51bc:	00003517          	auipc	a0,0x3
    51c0:	f6450513          	addi	a0,a0,-156 # 8120 <malloc+0x1f26>
    51c4:	00001097          	auipc	ra,0x1
    51c8:	c4e080e7          	jalr	-946(ra) # 5e12 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    51cc:	20200593          	li	a1,514
    51d0:	00003517          	auipc	a0,0x3
    51d4:	f5050513          	addi	a0,a0,-176 # 8120 <malloc+0x1f26>
    51d8:	00001097          	auipc	ra,0x1
    51dc:	c2a080e7          	jalr	-982(ra) # 5e02 <open>
    51e0:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    51e2:	4481                	li	s1,0
    memset(buf, i, SZ);
    51e4:	00008917          	auipc	s2,0x8
    51e8:	a9490913          	addi	s2,s2,-1388 # cc78 <buf>
  for(i = 0; i < N; i++){
    51ec:	4a51                	li	s4,20
  if(fd < 0){
    51ee:	0a054063          	bltz	a0,528e <bigfile+0xe6>
    memset(buf, i, SZ);
    51f2:	25800613          	li	a2,600
    51f6:	85a6                	mv	a1,s1
    51f8:	854a                	mv	a0,s2
    51fa:	00001097          	auipc	ra,0x1
    51fe:	9ce080e7          	jalr	-1586(ra) # 5bc8 <memset>
    if(write(fd, buf, SZ) != SZ){
    5202:	25800613          	li	a2,600
    5206:	85ca                	mv	a1,s2
    5208:	854e                	mv	a0,s3
    520a:	00001097          	auipc	ra,0x1
    520e:	bd8080e7          	jalr	-1064(ra) # 5de2 <write>
    5212:	25800793          	li	a5,600
    5216:	08f51a63          	bne	a0,a5,52aa <bigfile+0x102>
  for(i = 0; i < N; i++){
    521a:	2485                	addiw	s1,s1,1
    521c:	fd449be3          	bne	s1,s4,51f2 <bigfile+0x4a>
  close(fd);
    5220:	854e                	mv	a0,s3
    5222:	00001097          	auipc	ra,0x1
    5226:	bc8080e7          	jalr	-1080(ra) # 5dea <close>
  fd = open("bigfile.dat", 0);
    522a:	4581                	li	a1,0
    522c:	00003517          	auipc	a0,0x3
    5230:	ef450513          	addi	a0,a0,-268 # 8120 <malloc+0x1f26>
    5234:	00001097          	auipc	ra,0x1
    5238:	bce080e7          	jalr	-1074(ra) # 5e02 <open>
    523c:	8a2a                	mv	s4,a0
  total = 0;
    523e:	4981                	li	s3,0
  for(i = 0; ; i++){
    5240:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    5242:	00008917          	auipc	s2,0x8
    5246:	a3690913          	addi	s2,s2,-1482 # cc78 <buf>
  if(fd < 0){
    524a:	06054e63          	bltz	a0,52c6 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    524e:	12c00613          	li	a2,300
    5252:	85ca                	mv	a1,s2
    5254:	8552                	mv	a0,s4
    5256:	00001097          	auipc	ra,0x1
    525a:	b84080e7          	jalr	-1148(ra) # 5dda <read>
    if(cc < 0){
    525e:	08054263          	bltz	a0,52e2 <bigfile+0x13a>
    if(cc == 0)
    5262:	c971                	beqz	a0,5336 <bigfile+0x18e>
    if(cc != SZ/2){
    5264:	12c00793          	li	a5,300
    5268:	08f51b63          	bne	a0,a5,52fe <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    526c:	01f4d79b          	srliw	a5,s1,0x1f
    5270:	9fa5                	addw	a5,a5,s1
    5272:	4017d79b          	sraiw	a5,a5,0x1
    5276:	00094703          	lbu	a4,0(s2)
    527a:	0af71063          	bne	a4,a5,531a <bigfile+0x172>
    527e:	12b94703          	lbu	a4,299(s2)
    5282:	08f71c63          	bne	a4,a5,531a <bigfile+0x172>
    total += cc;
    5286:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    528a:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    528c:	b7c9                	j	524e <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    528e:	85d6                	mv	a1,s5
    5290:	00003517          	auipc	a0,0x3
    5294:	ea050513          	addi	a0,a0,-352 # 8130 <malloc+0x1f36>
    5298:	00001097          	auipc	ra,0x1
    529c:	eaa080e7          	jalr	-342(ra) # 6142 <printf>
    exit(1);
    52a0:	4505                	li	a0,1
    52a2:	00001097          	auipc	ra,0x1
    52a6:	b20080e7          	jalr	-1248(ra) # 5dc2 <exit>
      printf("%s: write bigfile failed\n", s);
    52aa:	85d6                	mv	a1,s5
    52ac:	00003517          	auipc	a0,0x3
    52b0:	ea450513          	addi	a0,a0,-348 # 8150 <malloc+0x1f56>
    52b4:	00001097          	auipc	ra,0x1
    52b8:	e8e080e7          	jalr	-370(ra) # 6142 <printf>
      exit(1);
    52bc:	4505                	li	a0,1
    52be:	00001097          	auipc	ra,0x1
    52c2:	b04080e7          	jalr	-1276(ra) # 5dc2 <exit>
    printf("%s: cannot open bigfile\n", s);
    52c6:	85d6                	mv	a1,s5
    52c8:	00003517          	auipc	a0,0x3
    52cc:	ea850513          	addi	a0,a0,-344 # 8170 <malloc+0x1f76>
    52d0:	00001097          	auipc	ra,0x1
    52d4:	e72080e7          	jalr	-398(ra) # 6142 <printf>
    exit(1);
    52d8:	4505                	li	a0,1
    52da:	00001097          	auipc	ra,0x1
    52de:	ae8080e7          	jalr	-1304(ra) # 5dc2 <exit>
      printf("%s: read bigfile failed\n", s);
    52e2:	85d6                	mv	a1,s5
    52e4:	00003517          	auipc	a0,0x3
    52e8:	eac50513          	addi	a0,a0,-340 # 8190 <malloc+0x1f96>
    52ec:	00001097          	auipc	ra,0x1
    52f0:	e56080e7          	jalr	-426(ra) # 6142 <printf>
      exit(1);
    52f4:	4505                	li	a0,1
    52f6:	00001097          	auipc	ra,0x1
    52fa:	acc080e7          	jalr	-1332(ra) # 5dc2 <exit>
      printf("%s: short read bigfile\n", s);
    52fe:	85d6                	mv	a1,s5
    5300:	00003517          	auipc	a0,0x3
    5304:	eb050513          	addi	a0,a0,-336 # 81b0 <malloc+0x1fb6>
    5308:	00001097          	auipc	ra,0x1
    530c:	e3a080e7          	jalr	-454(ra) # 6142 <printf>
      exit(1);
    5310:	4505                	li	a0,1
    5312:	00001097          	auipc	ra,0x1
    5316:	ab0080e7          	jalr	-1360(ra) # 5dc2 <exit>
      printf("%s: read bigfile wrong data\n", s);
    531a:	85d6                	mv	a1,s5
    531c:	00003517          	auipc	a0,0x3
    5320:	eac50513          	addi	a0,a0,-340 # 81c8 <malloc+0x1fce>
    5324:	00001097          	auipc	ra,0x1
    5328:	e1e080e7          	jalr	-482(ra) # 6142 <printf>
      exit(1);
    532c:	4505                	li	a0,1
    532e:	00001097          	auipc	ra,0x1
    5332:	a94080e7          	jalr	-1388(ra) # 5dc2 <exit>
  close(fd);
    5336:	8552                	mv	a0,s4
    5338:	00001097          	auipc	ra,0x1
    533c:	ab2080e7          	jalr	-1358(ra) # 5dea <close>
  if(total != N*SZ){
    5340:	678d                	lui	a5,0x3
    5342:	ee078793          	addi	a5,a5,-288 # 2ee0 <sbrklast+0x8e>
    5346:	02f99363          	bne	s3,a5,536c <bigfile+0x1c4>
  unlink("bigfile.dat");
    534a:	00003517          	auipc	a0,0x3
    534e:	dd650513          	addi	a0,a0,-554 # 8120 <malloc+0x1f26>
    5352:	00001097          	auipc	ra,0x1
    5356:	ac0080e7          	jalr	-1344(ra) # 5e12 <unlink>
}
    535a:	70e2                	ld	ra,56(sp)
    535c:	7442                	ld	s0,48(sp)
    535e:	74a2                	ld	s1,40(sp)
    5360:	7902                	ld	s2,32(sp)
    5362:	69e2                	ld	s3,24(sp)
    5364:	6a42                	ld	s4,16(sp)
    5366:	6aa2                	ld	s5,8(sp)
    5368:	6121                	addi	sp,sp,64
    536a:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    536c:	85d6                	mv	a1,s5
    536e:	00003517          	auipc	a0,0x3
    5372:	e7a50513          	addi	a0,a0,-390 # 81e8 <malloc+0x1fee>
    5376:	00001097          	auipc	ra,0x1
    537a:	dcc080e7          	jalr	-564(ra) # 6142 <printf>
    exit(1);
    537e:	4505                	li	a0,1
    5380:	00001097          	auipc	ra,0x1
    5384:	a42080e7          	jalr	-1470(ra) # 5dc2 <exit>

0000000000005388 <fsfull>:
{
    5388:	7135                	addi	sp,sp,-160
    538a:	ed06                	sd	ra,152(sp)
    538c:	e922                	sd	s0,144(sp)
    538e:	e526                	sd	s1,136(sp)
    5390:	e14a                	sd	s2,128(sp)
    5392:	fcce                	sd	s3,120(sp)
    5394:	f8d2                	sd	s4,112(sp)
    5396:	f4d6                	sd	s5,104(sp)
    5398:	f0da                	sd	s6,96(sp)
    539a:	ecde                	sd	s7,88(sp)
    539c:	e8e2                	sd	s8,80(sp)
    539e:	e4e6                	sd	s9,72(sp)
    53a0:	e0ea                	sd	s10,64(sp)
    53a2:	1100                	addi	s0,sp,160
  printf("fsfull test\n");
    53a4:	00003517          	auipc	a0,0x3
    53a8:	e6450513          	addi	a0,a0,-412 # 8208 <malloc+0x200e>
    53ac:	00001097          	auipc	ra,0x1
    53b0:	d96080e7          	jalr	-618(ra) # 6142 <printf>
  for(nfiles = 0; ; nfiles++){
    53b4:	4481                	li	s1,0
    name[0] = 'f';
    53b6:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    53ba:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    53be:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    53c2:	4b29                	li	s6,10
    printf("writing %s\n", name);
    53c4:	00003c97          	auipc	s9,0x3
    53c8:	e54c8c93          	addi	s9,s9,-428 # 8218 <malloc+0x201e>
    name[0] = 'f';
    53cc:	f7a40023          	sb	s10,-160(s0)
    name[1] = '0' + nfiles / 1000;
    53d0:	0384c7bb          	divw	a5,s1,s8
    53d4:	0307879b          	addiw	a5,a5,48
    53d8:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    53dc:	0384e7bb          	remw	a5,s1,s8
    53e0:	0377c7bb          	divw	a5,a5,s7
    53e4:	0307879b          	addiw	a5,a5,48
    53e8:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    53ec:	0374e7bb          	remw	a5,s1,s7
    53f0:	0367c7bb          	divw	a5,a5,s6
    53f4:	0307879b          	addiw	a5,a5,48
    53f8:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    53fc:	0364e7bb          	remw	a5,s1,s6
    5400:	0307879b          	addiw	a5,a5,48
    5404:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    5408:	f60402a3          	sb	zero,-155(s0)
    printf("writing %s\n", name);
    540c:	f6040593          	addi	a1,s0,-160
    5410:	8566                	mv	a0,s9
    5412:	00001097          	auipc	ra,0x1
    5416:	d30080e7          	jalr	-720(ra) # 6142 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    541a:	20200593          	li	a1,514
    541e:	f6040513          	addi	a0,s0,-160
    5422:	00001097          	auipc	ra,0x1
    5426:	9e0080e7          	jalr	-1568(ra) # 5e02 <open>
    542a:	892a                	mv	s2,a0
    if(fd < 0){
    542c:	0a055563          	bgez	a0,54d6 <fsfull+0x14e>
      printf("open %s failed\n", name);
    5430:	f6040593          	addi	a1,s0,-160
    5434:	00003517          	auipc	a0,0x3
    5438:	df450513          	addi	a0,a0,-524 # 8228 <malloc+0x202e>
    543c:	00001097          	auipc	ra,0x1
    5440:	d06080e7          	jalr	-762(ra) # 6142 <printf>
  while(nfiles >= 0){
    5444:	0604c363          	bltz	s1,54aa <fsfull+0x122>
    name[0] = 'f';
    5448:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    544c:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    5450:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    5454:	4929                	li	s2,10
  while(nfiles >= 0){
    5456:	5afd                	li	s5,-1
    name[0] = 'f';
    5458:	f7640023          	sb	s6,-160(s0)
    name[1] = '0' + nfiles / 1000;
    545c:	0344c7bb          	divw	a5,s1,s4
    5460:	0307879b          	addiw	a5,a5,48
    5464:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5468:	0344e7bb          	remw	a5,s1,s4
    546c:	0337c7bb          	divw	a5,a5,s3
    5470:	0307879b          	addiw	a5,a5,48
    5474:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5478:	0334e7bb          	remw	a5,s1,s3
    547c:	0327c7bb          	divw	a5,a5,s2
    5480:	0307879b          	addiw	a5,a5,48
    5484:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    5488:	0324e7bb          	remw	a5,s1,s2
    548c:	0307879b          	addiw	a5,a5,48
    5490:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    5494:	f60402a3          	sb	zero,-155(s0)
    unlink(name);
    5498:	f6040513          	addi	a0,s0,-160
    549c:	00001097          	auipc	ra,0x1
    54a0:	976080e7          	jalr	-1674(ra) # 5e12 <unlink>
    nfiles--;
    54a4:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    54a6:	fb5499e3          	bne	s1,s5,5458 <fsfull+0xd0>
  printf("fsfull test finished\n");
    54aa:	00003517          	auipc	a0,0x3
    54ae:	d9e50513          	addi	a0,a0,-610 # 8248 <malloc+0x204e>
    54b2:	00001097          	auipc	ra,0x1
    54b6:	c90080e7          	jalr	-880(ra) # 6142 <printf>
}
    54ba:	60ea                	ld	ra,152(sp)
    54bc:	644a                	ld	s0,144(sp)
    54be:	64aa                	ld	s1,136(sp)
    54c0:	690a                	ld	s2,128(sp)
    54c2:	79e6                	ld	s3,120(sp)
    54c4:	7a46                	ld	s4,112(sp)
    54c6:	7aa6                	ld	s5,104(sp)
    54c8:	7b06                	ld	s6,96(sp)
    54ca:	6be6                	ld	s7,88(sp)
    54cc:	6c46                	ld	s8,80(sp)
    54ce:	6ca6                	ld	s9,72(sp)
    54d0:	6d06                	ld	s10,64(sp)
    54d2:	610d                	addi	sp,sp,160
    54d4:	8082                	ret
    int total = 0;
    54d6:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    54d8:	00007a97          	auipc	s5,0x7
    54dc:	7a0a8a93          	addi	s5,s5,1952 # cc78 <buf>
      if(cc < BSIZE)
    54e0:	3ff00a13          	li	s4,1023
      int cc = write(fd, buf, BSIZE);
    54e4:	40000613          	li	a2,1024
    54e8:	85d6                	mv	a1,s5
    54ea:	854a                	mv	a0,s2
    54ec:	00001097          	auipc	ra,0x1
    54f0:	8f6080e7          	jalr	-1802(ra) # 5de2 <write>
      if(cc < BSIZE)
    54f4:	00aa5563          	bge	s4,a0,54fe <fsfull+0x176>
      total += cc;
    54f8:	00a989bb          	addw	s3,s3,a0
    while(1){
    54fc:	b7e5                	j	54e4 <fsfull+0x15c>
    printf("wrote %d bytes\n", total);
    54fe:	85ce                	mv	a1,s3
    5500:	00003517          	auipc	a0,0x3
    5504:	d3850513          	addi	a0,a0,-712 # 8238 <malloc+0x203e>
    5508:	00001097          	auipc	ra,0x1
    550c:	c3a080e7          	jalr	-966(ra) # 6142 <printf>
    close(fd);
    5510:	854a                	mv	a0,s2
    5512:	00001097          	auipc	ra,0x1
    5516:	8d8080e7          	jalr	-1832(ra) # 5dea <close>
    if(total == 0)
    551a:	f20985e3          	beqz	s3,5444 <fsfull+0xbc>
  for(nfiles = 0; ; nfiles++){
    551e:	2485                	addiw	s1,s1,1
    5520:	b575                	j	53cc <fsfull+0x44>

0000000000005522 <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5522:	7179                	addi	sp,sp,-48
    5524:	f406                	sd	ra,40(sp)
    5526:	f022                	sd	s0,32(sp)
    5528:	ec26                	sd	s1,24(sp)
    552a:	e84a                	sd	s2,16(sp)
    552c:	1800                	addi	s0,sp,48
    552e:	84aa                	mv	s1,a0
    5530:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5532:	00003517          	auipc	a0,0x3
    5536:	d2e50513          	addi	a0,a0,-722 # 8260 <malloc+0x2066>
    553a:	00001097          	auipc	ra,0x1
    553e:	c08080e7          	jalr	-1016(ra) # 6142 <printf>
  if((pid = fork()) < 0) {
    5542:	00001097          	auipc	ra,0x1
    5546:	878080e7          	jalr	-1928(ra) # 5dba <fork>
    554a:	02054e63          	bltz	a0,5586 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    554e:	c929                	beqz	a0,55a0 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5550:	fdc40513          	addi	a0,s0,-36
    5554:	00001097          	auipc	ra,0x1
    5558:	876080e7          	jalr	-1930(ra) # 5dca <wait>
    if(xstatus != 0) 
    555c:	fdc42783          	lw	a5,-36(s0)
    5560:	c7b9                	beqz	a5,55ae <run+0x8c>
      printf("FAILED\n");
    5562:	00003517          	auipc	a0,0x3
    5566:	d2650513          	addi	a0,a0,-730 # 8288 <malloc+0x208e>
    556a:	00001097          	auipc	ra,0x1
    556e:	bd8080e7          	jalr	-1064(ra) # 6142 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    5572:	fdc42503          	lw	a0,-36(s0)
  }
}
    5576:	00153513          	seqz	a0,a0
    557a:	70a2                	ld	ra,40(sp)
    557c:	7402                	ld	s0,32(sp)
    557e:	64e2                	ld	s1,24(sp)
    5580:	6942                	ld	s2,16(sp)
    5582:	6145                	addi	sp,sp,48
    5584:	8082                	ret
    printf("runtest: fork error\n");
    5586:	00003517          	auipc	a0,0x3
    558a:	cea50513          	addi	a0,a0,-790 # 8270 <malloc+0x2076>
    558e:	00001097          	auipc	ra,0x1
    5592:	bb4080e7          	jalr	-1100(ra) # 6142 <printf>
    exit(1);
    5596:	4505                	li	a0,1
    5598:	00001097          	auipc	ra,0x1
    559c:	82a080e7          	jalr	-2006(ra) # 5dc2 <exit>
    f(s);
    55a0:	854a                	mv	a0,s2
    55a2:	9482                	jalr	s1
    exit(0);
    55a4:	4501                	li	a0,0
    55a6:	00001097          	auipc	ra,0x1
    55aa:	81c080e7          	jalr	-2020(ra) # 5dc2 <exit>
      printf("OK\n");
    55ae:	00003517          	auipc	a0,0x3
    55b2:	ce250513          	addi	a0,a0,-798 # 8290 <malloc+0x2096>
    55b6:	00001097          	auipc	ra,0x1
    55ba:	b8c080e7          	jalr	-1140(ra) # 6142 <printf>
    55be:	bf55                	j	5572 <run+0x50>

00000000000055c0 <runtests>:

int
runtests(struct test *tests, char *justone) {
    55c0:	1101                	addi	sp,sp,-32
    55c2:	ec06                	sd	ra,24(sp)
    55c4:	e822                	sd	s0,16(sp)
    55c6:	e426                	sd	s1,8(sp)
    55c8:	e04a                	sd	s2,0(sp)
    55ca:	1000                	addi	s0,sp,32
    55cc:	84aa                	mv	s1,a0
    55ce:	892e                	mv	s2,a1
  for (struct test *t = tests; t->s != 0; t++) {
    55d0:	6508                	ld	a0,8(a0)
    55d2:	ed09                	bnez	a0,55ec <runtests+0x2c>
        printf("SOME TESTS FAILED\n");
        return 1;
      }
    }
  }
  return 0;
    55d4:	4501                	li	a0,0
    55d6:	a82d                	j	5610 <runtests+0x50>
      if(!run(t->f, t->s)){
    55d8:	648c                	ld	a1,8(s1)
    55da:	6088                	ld	a0,0(s1)
    55dc:	00000097          	auipc	ra,0x0
    55e0:	f46080e7          	jalr	-186(ra) # 5522 <run>
    55e4:	cd09                	beqz	a0,55fe <runtests+0x3e>
  for (struct test *t = tests; t->s != 0; t++) {
    55e6:	04c1                	addi	s1,s1,16
    55e8:	6488                	ld	a0,8(s1)
    55ea:	c11d                	beqz	a0,5610 <runtests+0x50>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    55ec:	fe0906e3          	beqz	s2,55d8 <runtests+0x18>
    55f0:	85ca                	mv	a1,s2
    55f2:	00000097          	auipc	ra,0x0
    55f6:	580080e7          	jalr	1408(ra) # 5b72 <strcmp>
    55fa:	f575                	bnez	a0,55e6 <runtests+0x26>
    55fc:	bff1                	j	55d8 <runtests+0x18>
        printf("SOME TESTS FAILED\n");
    55fe:	00003517          	auipc	a0,0x3
    5602:	c9a50513          	addi	a0,a0,-870 # 8298 <malloc+0x209e>
    5606:	00001097          	auipc	ra,0x1
    560a:	b3c080e7          	jalr	-1220(ra) # 6142 <printf>
        return 1;
    560e:	4505                	li	a0,1
}
    5610:	60e2                	ld	ra,24(sp)
    5612:	6442                	ld	s0,16(sp)
    5614:	64a2                	ld	s1,8(sp)
    5616:	6902                	ld	s2,0(sp)
    5618:	6105                	addi	sp,sp,32
    561a:	8082                	ret

000000000000561c <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    561c:	7139                	addi	sp,sp,-64
    561e:	fc06                	sd	ra,56(sp)
    5620:	f822                	sd	s0,48(sp)
    5622:	f426                	sd	s1,40(sp)
    5624:	f04a                	sd	s2,32(sp)
    5626:	ec4e                	sd	s3,24(sp)
    5628:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    562a:	fc840513          	addi	a0,s0,-56
    562e:	00000097          	auipc	ra,0x0
    5632:	7a4080e7          	jalr	1956(ra) # 5dd2 <pipe>
    5636:	06054763          	bltz	a0,56a4 <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    563a:	00000097          	auipc	ra,0x0
    563e:	780080e7          	jalr	1920(ra) # 5dba <fork>

  if(pid < 0){
    5642:	06054e63          	bltz	a0,56be <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    5646:	ed51                	bnez	a0,56e2 <countfree+0xc6>
    close(fds[0]);
    5648:	fc842503          	lw	a0,-56(s0)
    564c:	00000097          	auipc	ra,0x0
    5650:	79e080e7          	jalr	1950(ra) # 5dea <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    5654:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    5656:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    5658:	00001997          	auipc	s3,0x1
    565c:	d3098993          	addi	s3,s3,-720 # 6388 <malloc+0x18e>
      uint64 a = (uint64) sbrk(4096);
    5660:	6505                	lui	a0,0x1
    5662:	00000097          	auipc	ra,0x0
    5666:	7e8080e7          	jalr	2024(ra) # 5e4a <sbrk>
      if(a == 0xffffffffffffffff){
    566a:	07250763          	beq	a0,s2,56d8 <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    566e:	6785                	lui	a5,0x1
    5670:	97aa                	add	a5,a5,a0
    5672:	fe978fa3          	sb	s1,-1(a5) # fff <linktest+0x10b>
      if(write(fds[1], "x", 1) != 1){
    5676:	8626                	mv	a2,s1
    5678:	85ce                	mv	a1,s3
    567a:	fcc42503          	lw	a0,-52(s0)
    567e:	00000097          	auipc	ra,0x0
    5682:	764080e7          	jalr	1892(ra) # 5de2 <write>
    5686:	fc950de3          	beq	a0,s1,5660 <countfree+0x44>
        printf("write() failed in countfree()\n");
    568a:	00003517          	auipc	a0,0x3
    568e:	c6650513          	addi	a0,a0,-922 # 82f0 <malloc+0x20f6>
    5692:	00001097          	auipc	ra,0x1
    5696:	ab0080e7          	jalr	-1360(ra) # 6142 <printf>
        exit(1);
    569a:	4505                	li	a0,1
    569c:	00000097          	auipc	ra,0x0
    56a0:	726080e7          	jalr	1830(ra) # 5dc2 <exit>
    printf("pipe() failed in countfree()\n");
    56a4:	00003517          	auipc	a0,0x3
    56a8:	c0c50513          	addi	a0,a0,-1012 # 82b0 <malloc+0x20b6>
    56ac:	00001097          	auipc	ra,0x1
    56b0:	a96080e7          	jalr	-1386(ra) # 6142 <printf>
    exit(1);
    56b4:	4505                	li	a0,1
    56b6:	00000097          	auipc	ra,0x0
    56ba:	70c080e7          	jalr	1804(ra) # 5dc2 <exit>
    printf("fork failed in countfree()\n");
    56be:	00003517          	auipc	a0,0x3
    56c2:	c1250513          	addi	a0,a0,-1006 # 82d0 <malloc+0x20d6>
    56c6:	00001097          	auipc	ra,0x1
    56ca:	a7c080e7          	jalr	-1412(ra) # 6142 <printf>
    exit(1);
    56ce:	4505                	li	a0,1
    56d0:	00000097          	auipc	ra,0x0
    56d4:	6f2080e7          	jalr	1778(ra) # 5dc2 <exit>
      }
    }

    exit(0);
    56d8:	4501                	li	a0,0
    56da:	00000097          	auipc	ra,0x0
    56de:	6e8080e7          	jalr	1768(ra) # 5dc2 <exit>
  }

  close(fds[1]);
    56e2:	fcc42503          	lw	a0,-52(s0)
    56e6:	00000097          	auipc	ra,0x0
    56ea:	704080e7          	jalr	1796(ra) # 5dea <close>

  int n = 0;
    56ee:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    56f0:	4605                	li	a2,1
    56f2:	fc740593          	addi	a1,s0,-57
    56f6:	fc842503          	lw	a0,-56(s0)
    56fa:	00000097          	auipc	ra,0x0
    56fe:	6e0080e7          	jalr	1760(ra) # 5dda <read>
    if(cc < 0){
    5702:	00054563          	bltz	a0,570c <countfree+0xf0>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    5706:	c105                	beqz	a0,5726 <countfree+0x10a>
      break;
    n += 1;
    5708:	2485                	addiw	s1,s1,1
  while(1){
    570a:	b7dd                	j	56f0 <countfree+0xd4>
      printf("read() failed in countfree()\n");
    570c:	00003517          	auipc	a0,0x3
    5710:	c0450513          	addi	a0,a0,-1020 # 8310 <malloc+0x2116>
    5714:	00001097          	auipc	ra,0x1
    5718:	a2e080e7          	jalr	-1490(ra) # 6142 <printf>
      exit(1);
    571c:	4505                	li	a0,1
    571e:	00000097          	auipc	ra,0x0
    5722:	6a4080e7          	jalr	1700(ra) # 5dc2 <exit>
  }

  close(fds[0]);
    5726:	fc842503          	lw	a0,-56(s0)
    572a:	00000097          	auipc	ra,0x0
    572e:	6c0080e7          	jalr	1728(ra) # 5dea <close>
  wait((int*)0);
    5732:	4501                	li	a0,0
    5734:	00000097          	auipc	ra,0x0
    5738:	696080e7          	jalr	1686(ra) # 5dca <wait>
  
  return n;
}
    573c:	8526                	mv	a0,s1
    573e:	70e2                	ld	ra,56(sp)
    5740:	7442                	ld	s0,48(sp)
    5742:	74a2                	ld	s1,40(sp)
    5744:	7902                	ld	s2,32(sp)
    5746:	69e2                	ld	s3,24(sp)
    5748:	6121                	addi	sp,sp,64
    574a:	8082                	ret

000000000000574c <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    574c:	711d                	addi	sp,sp,-96
    574e:	ec86                	sd	ra,88(sp)
    5750:	e8a2                	sd	s0,80(sp)
    5752:	e4a6                	sd	s1,72(sp)
    5754:	e0ca                	sd	s2,64(sp)
    5756:	fc4e                	sd	s3,56(sp)
    5758:	f852                	sd	s4,48(sp)
    575a:	f456                	sd	s5,40(sp)
    575c:	f05a                	sd	s6,32(sp)
    575e:	ec5e                	sd	s7,24(sp)
    5760:	e862                	sd	s8,16(sp)
    5762:	e466                	sd	s9,8(sp)
    5764:	e06a                	sd	s10,0(sp)
    5766:	1080                	addi	s0,sp,96
    5768:	8aaa                	mv	s5,a0
    576a:	89ae                	mv	s3,a1
    576c:	8932                	mv	s2,a2
  do {
    printf("usertests starting\n");
    576e:	00003b97          	auipc	s7,0x3
    5772:	bc2b8b93          	addi	s7,s7,-1086 # 8330 <malloc+0x2136>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone)) {
    5776:	00004b17          	auipc	s6,0x4
    577a:	89ab0b13          	addi	s6,s6,-1894 # 9010 <quicktests>
      if(continuous != 2) {
    577e:	4a09                	li	s4,2
      }
    }
    if(!quick) {
      if (justone == 0)
        printf("usertests slow tests starting\n");
      if (runtests(slowtests, justone)) {
    5780:	00004c17          	auipc	s8,0x4
    5784:	c60c0c13          	addi	s8,s8,-928 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    5788:	00003d17          	auipc	s10,0x3
    578c:	bc0d0d13          	addi	s10,s10,-1088 # 8348 <malloc+0x214e>
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5790:	00003c97          	auipc	s9,0x3
    5794:	bd8c8c93          	addi	s9,s9,-1064 # 8368 <malloc+0x216e>
    5798:	a839                	j	57b6 <drivetests+0x6a>
        printf("usertests slow tests starting\n");
    579a:	856a                	mv	a0,s10
    579c:	00001097          	auipc	ra,0x1
    57a0:	9a6080e7          	jalr	-1626(ra) # 6142 <printf>
    57a4:	a081                	j	57e4 <drivetests+0x98>
    if((free1 = countfree()) < free0) {
    57a6:	00000097          	auipc	ra,0x0
    57aa:	e76080e7          	jalr	-394(ra) # 561c <countfree>
    57ae:	04954663          	blt	a0,s1,57fa <drivetests+0xae>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    57b2:	06098163          	beqz	s3,5814 <drivetests+0xc8>
    printf("usertests starting\n");
    57b6:	855e                	mv	a0,s7
    57b8:	00001097          	auipc	ra,0x1
    57bc:	98a080e7          	jalr	-1654(ra) # 6142 <printf>
    int free0 = countfree();
    57c0:	00000097          	auipc	ra,0x0
    57c4:	e5c080e7          	jalr	-420(ra) # 561c <countfree>
    57c8:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone)) {
    57ca:	85ca                	mv	a1,s2
    57cc:	855a                	mv	a0,s6
    57ce:	00000097          	auipc	ra,0x0
    57d2:	df2080e7          	jalr	-526(ra) # 55c0 <runtests>
    57d6:	c119                	beqz	a0,57dc <drivetests+0x90>
      if(continuous != 2) {
    57d8:	03499c63          	bne	s3,s4,5810 <drivetests+0xc4>
    if(!quick) {
    57dc:	fc0a95e3          	bnez	s5,57a6 <drivetests+0x5a>
      if (justone == 0)
    57e0:	fa090de3          	beqz	s2,579a <drivetests+0x4e>
      if (runtests(slowtests, justone)) {
    57e4:	85ca                	mv	a1,s2
    57e6:	8562                	mv	a0,s8
    57e8:	00000097          	auipc	ra,0x0
    57ec:	dd8080e7          	jalr	-552(ra) # 55c0 <runtests>
    57f0:	d95d                	beqz	a0,57a6 <drivetests+0x5a>
        if(continuous != 2) {
    57f2:	fb498ae3          	beq	s3,s4,57a6 <drivetests+0x5a>
          return 1;
    57f6:	4505                	li	a0,1
    57f8:	a839                	j	5816 <drivetests+0xca>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    57fa:	8626                	mv	a2,s1
    57fc:	85aa                	mv	a1,a0
    57fe:	8566                	mv	a0,s9
    5800:	00001097          	auipc	ra,0x1
    5804:	942080e7          	jalr	-1726(ra) # 6142 <printf>
      if(continuous != 2) {
    5808:	fb4987e3          	beq	s3,s4,57b6 <drivetests+0x6a>
        return 1;
    580c:	4505                	li	a0,1
    580e:	a021                	j	5816 <drivetests+0xca>
        return 1;
    5810:	4505                	li	a0,1
    5812:	a011                	j	5816 <drivetests+0xca>
  return 0;
    5814:	854e                	mv	a0,s3
}
    5816:	60e6                	ld	ra,88(sp)
    5818:	6446                	ld	s0,80(sp)
    581a:	64a6                	ld	s1,72(sp)
    581c:	6906                	ld	s2,64(sp)
    581e:	79e2                	ld	s3,56(sp)
    5820:	7a42                	ld	s4,48(sp)
    5822:	7aa2                	ld	s5,40(sp)
    5824:	7b02                	ld	s6,32(sp)
    5826:	6be2                	ld	s7,24(sp)
    5828:	6c42                	ld	s8,16(sp)
    582a:	6ca2                	ld	s9,8(sp)
    582c:	6d02                	ld	s10,0(sp)
    582e:	6125                	addi	sp,sp,96
    5830:	8082                	ret

0000000000005832 <main>:

int
main(int argc, char *argv[])
{
    5832:	1101                	addi	sp,sp,-32
    5834:	ec06                	sd	ra,24(sp)
    5836:	e822                	sd	s0,16(sp)
    5838:	e426                	sd	s1,8(sp)
    583a:	e04a                	sd	s2,0(sp)
    583c:	1000                	addi	s0,sp,32
    583e:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    5840:	4789                	li	a5,2
    5842:	02f50263          	beq	a0,a5,5866 <main+0x34>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    5846:	4785                	li	a5,1
    5848:	08a7c063          	blt	a5,a0,58c8 <main+0x96>
  char *justone = 0;
    584c:	4601                	li	a2,0
  int quick = 0;
    584e:	4501                	li	a0,0
  int continuous = 0;
    5850:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    5852:	00000097          	auipc	ra,0x0
    5856:	efa080e7          	jalr	-262(ra) # 574c <drivetests>
    585a:	c951                	beqz	a0,58ee <main+0xbc>
    exit(1);
    585c:	4505                	li	a0,1
    585e:	00000097          	auipc	ra,0x0
    5862:	564080e7          	jalr	1380(ra) # 5dc2 <exit>
    5866:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    5868:	00003597          	auipc	a1,0x3
    586c:	b3058593          	addi	a1,a1,-1232 # 8398 <malloc+0x219e>
    5870:	00893503          	ld	a0,8(s2)
    5874:	00000097          	auipc	ra,0x0
    5878:	2fe080e7          	jalr	766(ra) # 5b72 <strcmp>
    587c:	85aa                	mv	a1,a0
    587e:	e501                	bnez	a0,5886 <main+0x54>
  char *justone = 0;
    5880:	4601                	li	a2,0
    quick = 1;
    5882:	4505                	li	a0,1
    5884:	b7f9                	j	5852 <main+0x20>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    5886:	00003597          	auipc	a1,0x3
    588a:	b1a58593          	addi	a1,a1,-1254 # 83a0 <malloc+0x21a6>
    588e:	00893503          	ld	a0,8(s2)
    5892:	00000097          	auipc	ra,0x0
    5896:	2e0080e7          	jalr	736(ra) # 5b72 <strcmp>
    589a:	c521                	beqz	a0,58e2 <main+0xb0>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    589c:	00003597          	auipc	a1,0x3
    58a0:	b5458593          	addi	a1,a1,-1196 # 83f0 <malloc+0x21f6>
    58a4:	00893503          	ld	a0,8(s2)
    58a8:	00000097          	auipc	ra,0x0
    58ac:	2ca080e7          	jalr	714(ra) # 5b72 <strcmp>
    58b0:	cd05                	beqz	a0,58e8 <main+0xb6>
  } else if(argc == 2 && argv[1][0] != '-'){
    58b2:	00893603          	ld	a2,8(s2)
    58b6:	00064703          	lbu	a4,0(a2) # 3000 <execout+0xa6>
    58ba:	02d00793          	li	a5,45
    58be:	00f70563          	beq	a4,a5,58c8 <main+0x96>
  int quick = 0;
    58c2:	4501                	li	a0,0
  int continuous = 0;
    58c4:	4581                	li	a1,0
    58c6:	b771                	j	5852 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    58c8:	00003517          	auipc	a0,0x3
    58cc:	ae050513          	addi	a0,a0,-1312 # 83a8 <malloc+0x21ae>
    58d0:	00001097          	auipc	ra,0x1
    58d4:	872080e7          	jalr	-1934(ra) # 6142 <printf>
    exit(1);
    58d8:	4505                	li	a0,1
    58da:	00000097          	auipc	ra,0x0
    58de:	4e8080e7          	jalr	1256(ra) # 5dc2 <exit>
  char *justone = 0;
    58e2:	4601                	li	a2,0
    continuous = 1;
    58e4:	4585                	li	a1,1
    58e6:	b7b5                	j	5852 <main+0x20>
    continuous = 2;
    58e8:	85a6                	mv	a1,s1
  char *justone = 0;
    58ea:	4601                	li	a2,0
    58ec:	b79d                	j	5852 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    58ee:	00003517          	auipc	a0,0x3
    58f2:	aea50513          	addi	a0,a0,-1302 # 83d8 <malloc+0x21de>
    58f6:	00001097          	auipc	ra,0x1
    58fa:	84c080e7          	jalr	-1972(ra) # 6142 <printf>
  exit(0);
    58fe:	4501                	li	a0,0
    5900:	00000097          	auipc	ra,0x0
    5904:	4c2080e7          	jalr	1218(ra) # 5dc2 <exit>

0000000000005908 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
    5908:	1141                	addi	sp,sp,-16
    590a:	e422                	sd	s0,8(sp)
    590c:	0800                	addi	s0,sp,16
    lk->name = name;
    590e:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
    5910:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
    5914:	57fd                	li	a5,-1
    5916:	00f50823          	sb	a5,16(a0)
}
    591a:	6422                	ld	s0,8(sp)
    591c:	0141                	addi	sp,sp,16
    591e:	8082                	ret

0000000000005920 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
    5920:	00054783          	lbu	a5,0(a0)
    5924:	e399                	bnez	a5,592a <holding+0xa>
    5926:	4501                	li	a0,0
}
    5928:	8082                	ret
{
    592a:	1101                	addi	sp,sp,-32
    592c:	ec06                	sd	ra,24(sp)
    592e:	e822                	sd	s0,16(sp)
    5930:	e426                	sd	s1,8(sp)
    5932:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
    5934:	01054483          	lbu	s1,16(a0)
    5938:	00000097          	auipc	ra,0x0
    593c:	172080e7          	jalr	370(ra) # 5aaa <twhoami>
    5940:	2501                	sext.w	a0,a0
    5942:	40a48533          	sub	a0,s1,a0
    5946:	00153513          	seqz	a0,a0
}
    594a:	60e2                	ld	ra,24(sp)
    594c:	6442                	ld	s0,16(sp)
    594e:	64a2                	ld	s1,8(sp)
    5950:	6105                	addi	sp,sp,32
    5952:	8082                	ret

0000000000005954 <acquire>:

void acquire(struct lock *lk)
{
    5954:	7179                	addi	sp,sp,-48
    5956:	f406                	sd	ra,40(sp)
    5958:	f022                	sd	s0,32(sp)
    595a:	ec26                	sd	s1,24(sp)
    595c:	e84a                	sd	s2,16(sp)
    595e:	e44e                	sd	s3,8(sp)
    5960:	e052                	sd	s4,0(sp)
    5962:	1800                	addi	s0,sp,48
    5964:	8a2a                	mv	s4,a0
    if (holding(lk))
    5966:	00000097          	auipc	ra,0x0
    596a:	fba080e7          	jalr	-70(ra) # 5920 <holding>
    596e:	e919                	bnez	a0,5984 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
    5970:	ffca7493          	andi	s1,s4,-4
    5974:	003a7913          	andi	s2,s4,3
    5978:	0039191b          	slliw	s2,s2,0x3
    597c:	4985                	li	s3,1
    597e:	012999bb          	sllw	s3,s3,s2
    5982:	a015                	j	59a6 <acquire+0x52>
        printf("re-acquiring lock we already hold");
    5984:	00003517          	auipc	a0,0x3
    5988:	dd450513          	addi	a0,a0,-556 # 8758 <malloc+0x255e>
    598c:	00000097          	auipc	ra,0x0
    5990:	7b6080e7          	jalr	1974(ra) # 6142 <printf>
        exit(-1);
    5994:	557d                	li	a0,-1
    5996:	00000097          	auipc	ra,0x0
    599a:	42c080e7          	jalr	1068(ra) # 5dc2 <exit>
    {
        // give up the cpu for other threads
        tyield();
    599e:	00000097          	auipc	ra,0x0
    59a2:	0f4080e7          	jalr	244(ra) # 5a92 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
    59a6:	4534a7af          	amoor.w.aq	a5,s3,(s1)
    59aa:	0127d7bb          	srlw	a5,a5,s2
    59ae:	0ff7f793          	zext.b	a5,a5
    59b2:	f7f5                	bnez	a5,599e <acquire+0x4a>
    }

    __sync_synchronize();
    59b4:	0ff0000f          	fence

    lk->tid = twhoami();
    59b8:	00000097          	auipc	ra,0x0
    59bc:	0f2080e7          	jalr	242(ra) # 5aaa <twhoami>
    59c0:	00aa0823          	sb	a0,16(s4)
}
    59c4:	70a2                	ld	ra,40(sp)
    59c6:	7402                	ld	s0,32(sp)
    59c8:	64e2                	ld	s1,24(sp)
    59ca:	6942                	ld	s2,16(sp)
    59cc:	69a2                	ld	s3,8(sp)
    59ce:	6a02                	ld	s4,0(sp)
    59d0:	6145                	addi	sp,sp,48
    59d2:	8082                	ret

00000000000059d4 <release>:

void release(struct lock *lk)
{
    59d4:	1101                	addi	sp,sp,-32
    59d6:	ec06                	sd	ra,24(sp)
    59d8:	e822                	sd	s0,16(sp)
    59da:	e426                	sd	s1,8(sp)
    59dc:	1000                	addi	s0,sp,32
    59de:	84aa                	mv	s1,a0
    if (!holding(lk))
    59e0:	00000097          	auipc	ra,0x0
    59e4:	f40080e7          	jalr	-192(ra) # 5920 <holding>
    59e8:	c11d                	beqz	a0,5a0e <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
    59ea:	57fd                	li	a5,-1
    59ec:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
    59f0:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
    59f4:	0ff0000f          	fence
    59f8:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
    59fc:	00000097          	auipc	ra,0x0
    5a00:	096080e7          	jalr	150(ra) # 5a92 <tyield>
}
    5a04:	60e2                	ld	ra,24(sp)
    5a06:	6442                	ld	s0,16(sp)
    5a08:	64a2                	ld	s1,8(sp)
    5a0a:	6105                	addi	sp,sp,32
    5a0c:	8082                	ret
        printf("releasing lock we are not holding");
    5a0e:	00003517          	auipc	a0,0x3
    5a12:	d7250513          	addi	a0,a0,-654 # 8780 <malloc+0x2586>
    5a16:	00000097          	auipc	ra,0x0
    5a1a:	72c080e7          	jalr	1836(ra) # 6142 <printf>
        exit(-1);
    5a1e:	557d                	li	a0,-1
    5a20:	00000097          	auipc	ra,0x0
    5a24:	3a2080e7          	jalr	930(ra) # 5dc2 <exit>

0000000000005a28 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
    5a28:	1141                	addi	sp,sp,-16
    5a2a:	e422                	sd	s0,8(sp)
    5a2c:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
    5a2e:	00004717          	auipc	a4,0x4
    5a32:	a2273703          	ld	a4,-1502(a4) # 9450 <current_thread>
    5a36:	47c1                	li	a5,16
    5a38:	c319                	beqz	a4,5a3e <tsched+0x16>
    for (int i = 0; i < 16; i++) {
    5a3a:	37fd                	addiw	a5,a5,-1
    5a3c:	fff5                	bnez	a5,5a38 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
    5a3e:	6422                	ld	s0,8(sp)
    5a40:	0141                	addi	sp,sp,16
    5a42:	8082                	ret

0000000000005a44 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
    5a44:	7179                	addi	sp,sp,-48
    5a46:	f406                	sd	ra,40(sp)
    5a48:	f022                	sd	s0,32(sp)
    5a4a:	ec26                	sd	s1,24(sp)
    5a4c:	e84a                	sd	s2,16(sp)
    5a4e:	e44e                	sd	s3,8(sp)
    5a50:	1800                	addi	s0,sp,48
    5a52:	84aa                	mv	s1,a0
    5a54:	89b2                	mv	s3,a2
    5a56:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
    5a58:	09000513          	li	a0,144
    5a5c:	00000097          	auipc	ra,0x0
    5a60:	79e080e7          	jalr	1950(ra) # 61fa <malloc>
    5a64:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
    5a66:	478d                	li	a5,3
    5a68:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
    5a6a:	609c                	ld	a5,0(s1)
    5a6c:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
    5a70:	609c                	ld	a5,0(s1)
    5a72:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
    5a76:	70a2                	ld	ra,40(sp)
    5a78:	7402                	ld	s0,32(sp)
    5a7a:	64e2                	ld	s1,24(sp)
    5a7c:	6942                	ld	s2,16(sp)
    5a7e:	69a2                	ld	s3,8(sp)
    5a80:	6145                	addi	sp,sp,48
    5a82:	8082                	ret

0000000000005a84 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
    5a84:	1141                	addi	sp,sp,-16
    5a86:	e422                	sd	s0,8(sp)
    5a88:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
    5a8a:	4501                	li	a0,0
    5a8c:	6422                	ld	s0,8(sp)
    5a8e:	0141                	addi	sp,sp,16
    5a90:	8082                	ret

0000000000005a92 <tyield>:

void tyield()
{
    5a92:	1141                	addi	sp,sp,-16
    5a94:	e422                	sd	s0,8(sp)
    5a96:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
    5a98:	00004797          	auipc	a5,0x4
    5a9c:	9b87b783          	ld	a5,-1608(a5) # 9450 <current_thread>
    5aa0:	470d                	li	a4,3
    5aa2:	dfb8                	sw	a4,120(a5)
    tsched();
}
    5aa4:	6422                	ld	s0,8(sp)
    5aa6:	0141                	addi	sp,sp,16
    5aa8:	8082                	ret

0000000000005aaa <twhoami>:

uint8 twhoami()
{
    5aaa:	1141                	addi	sp,sp,-16
    5aac:	e422                	sd	s0,8(sp)
    5aae:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
    5ab0:	4501                	li	a0,0
    5ab2:	6422                	ld	s0,8(sp)
    5ab4:	0141                	addi	sp,sp,16
    5ab6:	8082                	ret

0000000000005ab8 <tswtch>:
    5ab8:	00153023          	sd	ra,0(a0)
    5abc:	00253423          	sd	sp,8(a0)
    5ac0:	e900                	sd	s0,16(a0)
    5ac2:	ed04                	sd	s1,24(a0)
    5ac4:	03253023          	sd	s2,32(a0)
    5ac8:	03353423          	sd	s3,40(a0)
    5acc:	03453823          	sd	s4,48(a0)
    5ad0:	03553c23          	sd	s5,56(a0)
    5ad4:	05653023          	sd	s6,64(a0)
    5ad8:	05753423          	sd	s7,72(a0)
    5adc:	05853823          	sd	s8,80(a0)
    5ae0:	05953c23          	sd	s9,88(a0)
    5ae4:	07a53023          	sd	s10,96(a0)
    5ae8:	07b53423          	sd	s11,104(a0)
    5aec:	0005b083          	ld	ra,0(a1)
    5af0:	0085b103          	ld	sp,8(a1)
    5af4:	6980                	ld	s0,16(a1)
    5af6:	6d84                	ld	s1,24(a1)
    5af8:	0205b903          	ld	s2,32(a1)
    5afc:	0285b983          	ld	s3,40(a1)
    5b00:	0305ba03          	ld	s4,48(a1)
    5b04:	0385ba83          	ld	s5,56(a1)
    5b08:	0405bb03          	ld	s6,64(a1)
    5b0c:	0485bb83          	ld	s7,72(a1)
    5b10:	0505bc03          	ld	s8,80(a1)
    5b14:	0585bc83          	ld	s9,88(a1)
    5b18:	0605bd03          	ld	s10,96(a1)
    5b1c:	0685bd83          	ld	s11,104(a1)
    5b20:	8082                	ret

0000000000005b22 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
    5b22:	1101                	addi	sp,sp,-32
    5b24:	ec06                	sd	ra,24(sp)
    5b26:	e822                	sd	s0,16(sp)
    5b28:	e426                	sd	s1,8(sp)
    5b2a:	e04a                	sd	s2,0(sp)
    5b2c:	1000                	addi	s0,sp,32
    5b2e:	84aa                	mv	s1,a0
    5b30:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
    5b32:	09000513          	li	a0,144
    5b36:	00000097          	auipc	ra,0x0
    5b3a:	6c4080e7          	jalr	1732(ra) # 61fa <malloc>

    main_thread->tid = 0;
    5b3e:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
    5b42:	85ca                	mv	a1,s2
    5b44:	8526                	mv	a0,s1
    5b46:	00000097          	auipc	ra,0x0
    5b4a:	cec080e7          	jalr	-788(ra) # 5832 <main>
    exit(res);
    5b4e:	00000097          	auipc	ra,0x0
    5b52:	274080e7          	jalr	628(ra) # 5dc2 <exit>

0000000000005b56 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    5b56:	1141                	addi	sp,sp,-16
    5b58:	e422                	sd	s0,8(sp)
    5b5a:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    5b5c:	87aa                	mv	a5,a0
    5b5e:	0585                	addi	a1,a1,1
    5b60:	0785                	addi	a5,a5,1
    5b62:	fff5c703          	lbu	a4,-1(a1)
    5b66:	fee78fa3          	sb	a4,-1(a5)
    5b6a:	fb75                	bnez	a4,5b5e <strcpy+0x8>
        ;
    return os;
}
    5b6c:	6422                	ld	s0,8(sp)
    5b6e:	0141                	addi	sp,sp,16
    5b70:	8082                	ret

0000000000005b72 <strcmp>:

int strcmp(const char *p, const char *q)
{
    5b72:	1141                	addi	sp,sp,-16
    5b74:	e422                	sd	s0,8(sp)
    5b76:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
    5b78:	00054783          	lbu	a5,0(a0)
    5b7c:	cb91                	beqz	a5,5b90 <strcmp+0x1e>
    5b7e:	0005c703          	lbu	a4,0(a1)
    5b82:	00f71763          	bne	a4,a5,5b90 <strcmp+0x1e>
        p++, q++;
    5b86:	0505                	addi	a0,a0,1
    5b88:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
    5b8a:	00054783          	lbu	a5,0(a0)
    5b8e:	fbe5                	bnez	a5,5b7e <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
    5b90:	0005c503          	lbu	a0,0(a1)
}
    5b94:	40a7853b          	subw	a0,a5,a0
    5b98:	6422                	ld	s0,8(sp)
    5b9a:	0141                	addi	sp,sp,16
    5b9c:	8082                	ret

0000000000005b9e <strlen>:

uint strlen(const char *s)
{
    5b9e:	1141                	addi	sp,sp,-16
    5ba0:	e422                	sd	s0,8(sp)
    5ba2:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
    5ba4:	00054783          	lbu	a5,0(a0)
    5ba8:	cf91                	beqz	a5,5bc4 <strlen+0x26>
    5baa:	0505                	addi	a0,a0,1
    5bac:	87aa                	mv	a5,a0
    5bae:	86be                	mv	a3,a5
    5bb0:	0785                	addi	a5,a5,1
    5bb2:	fff7c703          	lbu	a4,-1(a5)
    5bb6:	ff65                	bnez	a4,5bae <strlen+0x10>
    5bb8:	40a6853b          	subw	a0,a3,a0
    5bbc:	2505                	addiw	a0,a0,1
        ;
    return n;
}
    5bbe:	6422                	ld	s0,8(sp)
    5bc0:	0141                	addi	sp,sp,16
    5bc2:	8082                	ret
    for (n = 0; s[n]; n++)
    5bc4:	4501                	li	a0,0
    5bc6:	bfe5                	j	5bbe <strlen+0x20>

0000000000005bc8 <memset>:

void *
memset(void *dst, int c, uint n)
{
    5bc8:	1141                	addi	sp,sp,-16
    5bca:	e422                	sd	s0,8(sp)
    5bcc:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
    5bce:	ca19                	beqz	a2,5be4 <memset+0x1c>
    5bd0:	87aa                	mv	a5,a0
    5bd2:	1602                	slli	a2,a2,0x20
    5bd4:	9201                	srli	a2,a2,0x20
    5bd6:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
    5bda:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
    5bde:	0785                	addi	a5,a5,1
    5be0:	fee79de3          	bne	a5,a4,5bda <memset+0x12>
    }
    return dst;
}
    5be4:	6422                	ld	s0,8(sp)
    5be6:	0141                	addi	sp,sp,16
    5be8:	8082                	ret

0000000000005bea <strchr>:

char *
strchr(const char *s, char c)
{
    5bea:	1141                	addi	sp,sp,-16
    5bec:	e422                	sd	s0,8(sp)
    5bee:	0800                	addi	s0,sp,16
    for (; *s; s++)
    5bf0:	00054783          	lbu	a5,0(a0)
    5bf4:	cb99                	beqz	a5,5c0a <strchr+0x20>
        if (*s == c)
    5bf6:	00f58763          	beq	a1,a5,5c04 <strchr+0x1a>
    for (; *s; s++)
    5bfa:	0505                	addi	a0,a0,1
    5bfc:	00054783          	lbu	a5,0(a0)
    5c00:	fbfd                	bnez	a5,5bf6 <strchr+0xc>
            return (char *)s;
    return 0;
    5c02:	4501                	li	a0,0
}
    5c04:	6422                	ld	s0,8(sp)
    5c06:	0141                	addi	sp,sp,16
    5c08:	8082                	ret
    return 0;
    5c0a:	4501                	li	a0,0
    5c0c:	bfe5                	j	5c04 <strchr+0x1a>

0000000000005c0e <gets>:

char *
gets(char *buf, int max)
{
    5c0e:	711d                	addi	sp,sp,-96
    5c10:	ec86                	sd	ra,88(sp)
    5c12:	e8a2                	sd	s0,80(sp)
    5c14:	e4a6                	sd	s1,72(sp)
    5c16:	e0ca                	sd	s2,64(sp)
    5c18:	fc4e                	sd	s3,56(sp)
    5c1a:	f852                	sd	s4,48(sp)
    5c1c:	f456                	sd	s5,40(sp)
    5c1e:	f05a                	sd	s6,32(sp)
    5c20:	ec5e                	sd	s7,24(sp)
    5c22:	1080                	addi	s0,sp,96
    5c24:	8baa                	mv	s7,a0
    5c26:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
    5c28:	892a                	mv	s2,a0
    5c2a:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
    5c2c:	4aa9                	li	s5,10
    5c2e:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
    5c30:	89a6                	mv	s3,s1
    5c32:	2485                	addiw	s1,s1,1
    5c34:	0344d863          	bge	s1,s4,5c64 <gets+0x56>
        cc = read(0, &c, 1);
    5c38:	4605                	li	a2,1
    5c3a:	faf40593          	addi	a1,s0,-81
    5c3e:	4501                	li	a0,0
    5c40:	00000097          	auipc	ra,0x0
    5c44:	19a080e7          	jalr	410(ra) # 5dda <read>
        if (cc < 1)
    5c48:	00a05e63          	blez	a0,5c64 <gets+0x56>
        buf[i++] = c;
    5c4c:	faf44783          	lbu	a5,-81(s0)
    5c50:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
    5c54:	01578763          	beq	a5,s5,5c62 <gets+0x54>
    5c58:	0905                	addi	s2,s2,1
    5c5a:	fd679be3          	bne	a5,s6,5c30 <gets+0x22>
    for (i = 0; i + 1 < max;)
    5c5e:	89a6                	mv	s3,s1
    5c60:	a011                	j	5c64 <gets+0x56>
    5c62:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
    5c64:	99de                	add	s3,s3,s7
    5c66:	00098023          	sb	zero,0(s3)
    return buf;
}
    5c6a:	855e                	mv	a0,s7
    5c6c:	60e6                	ld	ra,88(sp)
    5c6e:	6446                	ld	s0,80(sp)
    5c70:	64a6                	ld	s1,72(sp)
    5c72:	6906                	ld	s2,64(sp)
    5c74:	79e2                	ld	s3,56(sp)
    5c76:	7a42                	ld	s4,48(sp)
    5c78:	7aa2                	ld	s5,40(sp)
    5c7a:	7b02                	ld	s6,32(sp)
    5c7c:	6be2                	ld	s7,24(sp)
    5c7e:	6125                	addi	sp,sp,96
    5c80:	8082                	ret

0000000000005c82 <stat>:

int stat(const char *n, struct stat *st)
{
    5c82:	1101                	addi	sp,sp,-32
    5c84:	ec06                	sd	ra,24(sp)
    5c86:	e822                	sd	s0,16(sp)
    5c88:	e426                	sd	s1,8(sp)
    5c8a:	e04a                	sd	s2,0(sp)
    5c8c:	1000                	addi	s0,sp,32
    5c8e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    5c90:	4581                	li	a1,0
    5c92:	00000097          	auipc	ra,0x0
    5c96:	170080e7          	jalr	368(ra) # 5e02 <open>
    if (fd < 0)
    5c9a:	02054563          	bltz	a0,5cc4 <stat+0x42>
    5c9e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
    5ca0:	85ca                	mv	a1,s2
    5ca2:	00000097          	auipc	ra,0x0
    5ca6:	178080e7          	jalr	376(ra) # 5e1a <fstat>
    5caa:	892a                	mv	s2,a0
    close(fd);
    5cac:	8526                	mv	a0,s1
    5cae:	00000097          	auipc	ra,0x0
    5cb2:	13c080e7          	jalr	316(ra) # 5dea <close>
    return r;
}
    5cb6:	854a                	mv	a0,s2
    5cb8:	60e2                	ld	ra,24(sp)
    5cba:	6442                	ld	s0,16(sp)
    5cbc:	64a2                	ld	s1,8(sp)
    5cbe:	6902                	ld	s2,0(sp)
    5cc0:	6105                	addi	sp,sp,32
    5cc2:	8082                	ret
        return -1;
    5cc4:	597d                	li	s2,-1
    5cc6:	bfc5                	j	5cb6 <stat+0x34>

0000000000005cc8 <atoi>:

int atoi(const char *s)
{
    5cc8:	1141                	addi	sp,sp,-16
    5cca:	e422                	sd	s0,8(sp)
    5ccc:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
    5cce:	00054683          	lbu	a3,0(a0)
    5cd2:	fd06879b          	addiw	a5,a3,-48
    5cd6:	0ff7f793          	zext.b	a5,a5
    5cda:	4625                	li	a2,9
    5cdc:	02f66863          	bltu	a2,a5,5d0c <atoi+0x44>
    5ce0:	872a                	mv	a4,a0
    n = 0;
    5ce2:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
    5ce4:	0705                	addi	a4,a4,1
    5ce6:	0025179b          	slliw	a5,a0,0x2
    5cea:	9fa9                	addw	a5,a5,a0
    5cec:	0017979b          	slliw	a5,a5,0x1
    5cf0:	9fb5                	addw	a5,a5,a3
    5cf2:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    5cf6:	00074683          	lbu	a3,0(a4)
    5cfa:	fd06879b          	addiw	a5,a3,-48
    5cfe:	0ff7f793          	zext.b	a5,a5
    5d02:	fef671e3          	bgeu	a2,a5,5ce4 <atoi+0x1c>
    return n;
}
    5d06:	6422                	ld	s0,8(sp)
    5d08:	0141                	addi	sp,sp,16
    5d0a:	8082                	ret
    n = 0;
    5d0c:	4501                	li	a0,0
    5d0e:	bfe5                	j	5d06 <atoi+0x3e>

0000000000005d10 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    5d10:	1141                	addi	sp,sp,-16
    5d12:	e422                	sd	s0,8(sp)
    5d14:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
    5d16:	02b57463          	bgeu	a0,a1,5d3e <memmove+0x2e>
    {
        while (n-- > 0)
    5d1a:	00c05f63          	blez	a2,5d38 <memmove+0x28>
    5d1e:	1602                	slli	a2,a2,0x20
    5d20:	9201                	srli	a2,a2,0x20
    5d22:	00c507b3          	add	a5,a0,a2
    dst = vdst;
    5d26:	872a                	mv	a4,a0
            *dst++ = *src++;
    5d28:	0585                	addi	a1,a1,1
    5d2a:	0705                	addi	a4,a4,1
    5d2c:	fff5c683          	lbu	a3,-1(a1)
    5d30:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    5d34:	fee79ae3          	bne	a5,a4,5d28 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
    5d38:	6422                	ld	s0,8(sp)
    5d3a:	0141                	addi	sp,sp,16
    5d3c:	8082                	ret
        dst += n;
    5d3e:	00c50733          	add	a4,a0,a2
        src += n;
    5d42:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    5d44:	fec05ae3          	blez	a2,5d38 <memmove+0x28>
    5d48:	fff6079b          	addiw	a5,a2,-1
    5d4c:	1782                	slli	a5,a5,0x20
    5d4e:	9381                	srli	a5,a5,0x20
    5d50:	fff7c793          	not	a5,a5
    5d54:	97ba                	add	a5,a5,a4
            *--dst = *--src;
    5d56:	15fd                	addi	a1,a1,-1
    5d58:	177d                	addi	a4,a4,-1
    5d5a:	0005c683          	lbu	a3,0(a1)
    5d5e:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    5d62:	fee79ae3          	bne	a5,a4,5d56 <memmove+0x46>
    5d66:	bfc9                	j	5d38 <memmove+0x28>

0000000000005d68 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    5d68:	1141                	addi	sp,sp,-16
    5d6a:	e422                	sd	s0,8(sp)
    5d6c:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
    5d6e:	ca05                	beqz	a2,5d9e <memcmp+0x36>
    5d70:	fff6069b          	addiw	a3,a2,-1
    5d74:	1682                	slli	a3,a3,0x20
    5d76:	9281                	srli	a3,a3,0x20
    5d78:	0685                	addi	a3,a3,1
    5d7a:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
    5d7c:	00054783          	lbu	a5,0(a0)
    5d80:	0005c703          	lbu	a4,0(a1)
    5d84:	00e79863          	bne	a5,a4,5d94 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
    5d88:	0505                	addi	a0,a0,1
        p2++;
    5d8a:	0585                	addi	a1,a1,1
    while (n-- > 0)
    5d8c:	fed518e3          	bne	a0,a3,5d7c <memcmp+0x14>
    }
    return 0;
    5d90:	4501                	li	a0,0
    5d92:	a019                	j	5d98 <memcmp+0x30>
            return *p1 - *p2;
    5d94:	40e7853b          	subw	a0,a5,a4
}
    5d98:	6422                	ld	s0,8(sp)
    5d9a:	0141                	addi	sp,sp,16
    5d9c:	8082                	ret
    return 0;
    5d9e:	4501                	li	a0,0
    5da0:	bfe5                	j	5d98 <memcmp+0x30>

0000000000005da2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5da2:	1141                	addi	sp,sp,-16
    5da4:	e406                	sd	ra,8(sp)
    5da6:	e022                	sd	s0,0(sp)
    5da8:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    5daa:	00000097          	auipc	ra,0x0
    5dae:	f66080e7          	jalr	-154(ra) # 5d10 <memmove>
}
    5db2:	60a2                	ld	ra,8(sp)
    5db4:	6402                	ld	s0,0(sp)
    5db6:	0141                	addi	sp,sp,16
    5db8:	8082                	ret

0000000000005dba <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5dba:	4885                	li	a7,1
 ecall
    5dbc:	00000073          	ecall
 ret
    5dc0:	8082                	ret

0000000000005dc2 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5dc2:	4889                	li	a7,2
 ecall
    5dc4:	00000073          	ecall
 ret
    5dc8:	8082                	ret

0000000000005dca <wait>:
.global wait
wait:
 li a7, SYS_wait
    5dca:	488d                	li	a7,3
 ecall
    5dcc:	00000073          	ecall
 ret
    5dd0:	8082                	ret

0000000000005dd2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5dd2:	4891                	li	a7,4
 ecall
    5dd4:	00000073          	ecall
 ret
    5dd8:	8082                	ret

0000000000005dda <read>:
.global read
read:
 li a7, SYS_read
    5dda:	4895                	li	a7,5
 ecall
    5ddc:	00000073          	ecall
 ret
    5de0:	8082                	ret

0000000000005de2 <write>:
.global write
write:
 li a7, SYS_write
    5de2:	48c1                	li	a7,16
 ecall
    5de4:	00000073          	ecall
 ret
    5de8:	8082                	ret

0000000000005dea <close>:
.global close
close:
 li a7, SYS_close
    5dea:	48d5                	li	a7,21
 ecall
    5dec:	00000073          	ecall
 ret
    5df0:	8082                	ret

0000000000005df2 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5df2:	4899                	li	a7,6
 ecall
    5df4:	00000073          	ecall
 ret
    5df8:	8082                	ret

0000000000005dfa <exec>:
.global exec
exec:
 li a7, SYS_exec
    5dfa:	489d                	li	a7,7
 ecall
    5dfc:	00000073          	ecall
 ret
    5e00:	8082                	ret

0000000000005e02 <open>:
.global open
open:
 li a7, SYS_open
    5e02:	48bd                	li	a7,15
 ecall
    5e04:	00000073          	ecall
 ret
    5e08:	8082                	ret

0000000000005e0a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5e0a:	48c5                	li	a7,17
 ecall
    5e0c:	00000073          	ecall
 ret
    5e10:	8082                	ret

0000000000005e12 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5e12:	48c9                	li	a7,18
 ecall
    5e14:	00000073          	ecall
 ret
    5e18:	8082                	ret

0000000000005e1a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5e1a:	48a1                	li	a7,8
 ecall
    5e1c:	00000073          	ecall
 ret
    5e20:	8082                	ret

0000000000005e22 <link>:
.global link
link:
 li a7, SYS_link
    5e22:	48cd                	li	a7,19
 ecall
    5e24:	00000073          	ecall
 ret
    5e28:	8082                	ret

0000000000005e2a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5e2a:	48d1                	li	a7,20
 ecall
    5e2c:	00000073          	ecall
 ret
    5e30:	8082                	ret

0000000000005e32 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5e32:	48a5                	li	a7,9
 ecall
    5e34:	00000073          	ecall
 ret
    5e38:	8082                	ret

0000000000005e3a <dup>:
.global dup
dup:
 li a7, SYS_dup
    5e3a:	48a9                	li	a7,10
 ecall
    5e3c:	00000073          	ecall
 ret
    5e40:	8082                	ret

0000000000005e42 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5e42:	48ad                	li	a7,11
 ecall
    5e44:	00000073          	ecall
 ret
    5e48:	8082                	ret

0000000000005e4a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5e4a:	48b1                	li	a7,12
 ecall
    5e4c:	00000073          	ecall
 ret
    5e50:	8082                	ret

0000000000005e52 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5e52:	48b5                	li	a7,13
 ecall
    5e54:	00000073          	ecall
 ret
    5e58:	8082                	ret

0000000000005e5a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5e5a:	48b9                	li	a7,14
 ecall
    5e5c:	00000073          	ecall
 ret
    5e60:	8082                	ret

0000000000005e62 <ps>:
.global ps
ps:
 li a7, SYS_ps
    5e62:	48d9                	li	a7,22
 ecall
    5e64:	00000073          	ecall
 ret
    5e68:	8082                	ret

0000000000005e6a <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
    5e6a:	48dd                	li	a7,23
 ecall
    5e6c:	00000073          	ecall
 ret
    5e70:	8082                	ret

0000000000005e72 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
    5e72:	48e1                	li	a7,24
 ecall
    5e74:	00000073          	ecall
 ret
    5e78:	8082                	ret

0000000000005e7a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5e7a:	1101                	addi	sp,sp,-32
    5e7c:	ec06                	sd	ra,24(sp)
    5e7e:	e822                	sd	s0,16(sp)
    5e80:	1000                	addi	s0,sp,32
    5e82:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5e86:	4605                	li	a2,1
    5e88:	fef40593          	addi	a1,s0,-17
    5e8c:	00000097          	auipc	ra,0x0
    5e90:	f56080e7          	jalr	-170(ra) # 5de2 <write>
}
    5e94:	60e2                	ld	ra,24(sp)
    5e96:	6442                	ld	s0,16(sp)
    5e98:	6105                	addi	sp,sp,32
    5e9a:	8082                	ret

0000000000005e9c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5e9c:	7139                	addi	sp,sp,-64
    5e9e:	fc06                	sd	ra,56(sp)
    5ea0:	f822                	sd	s0,48(sp)
    5ea2:	f426                	sd	s1,40(sp)
    5ea4:	f04a                	sd	s2,32(sp)
    5ea6:	ec4e                	sd	s3,24(sp)
    5ea8:	0080                	addi	s0,sp,64
    5eaa:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5eac:	c299                	beqz	a3,5eb2 <printint+0x16>
    5eae:	0805c963          	bltz	a1,5f40 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5eb2:	2581                	sext.w	a1,a1
  neg = 0;
    5eb4:	4881                	li	a7,0
    5eb6:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    5eba:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5ebc:	2601                	sext.w	a2,a2
    5ebe:	00003517          	auipc	a0,0x3
    5ec2:	94a50513          	addi	a0,a0,-1718 # 8808 <digits>
    5ec6:	883a                	mv	a6,a4
    5ec8:	2705                	addiw	a4,a4,1
    5eca:	02c5f7bb          	remuw	a5,a1,a2
    5ece:	1782                	slli	a5,a5,0x20
    5ed0:	9381                	srli	a5,a5,0x20
    5ed2:	97aa                	add	a5,a5,a0
    5ed4:	0007c783          	lbu	a5,0(a5)
    5ed8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5edc:	0005879b          	sext.w	a5,a1
    5ee0:	02c5d5bb          	divuw	a1,a1,a2
    5ee4:	0685                	addi	a3,a3,1
    5ee6:	fec7f0e3          	bgeu	a5,a2,5ec6 <printint+0x2a>
  if(neg)
    5eea:	00088c63          	beqz	a7,5f02 <printint+0x66>
    buf[i++] = '-';
    5eee:	fd070793          	addi	a5,a4,-48
    5ef2:	00878733          	add	a4,a5,s0
    5ef6:	02d00793          	li	a5,45
    5efa:	fef70823          	sb	a5,-16(a4)
    5efe:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    5f02:	02e05863          	blez	a4,5f32 <printint+0x96>
    5f06:	fc040793          	addi	a5,s0,-64
    5f0a:	00e78933          	add	s2,a5,a4
    5f0e:	fff78993          	addi	s3,a5,-1
    5f12:	99ba                	add	s3,s3,a4
    5f14:	377d                	addiw	a4,a4,-1
    5f16:	1702                	slli	a4,a4,0x20
    5f18:	9301                	srli	a4,a4,0x20
    5f1a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5f1e:	fff94583          	lbu	a1,-1(s2)
    5f22:	8526                	mv	a0,s1
    5f24:	00000097          	auipc	ra,0x0
    5f28:	f56080e7          	jalr	-170(ra) # 5e7a <putc>
  while(--i >= 0)
    5f2c:	197d                	addi	s2,s2,-1
    5f2e:	ff3918e3          	bne	s2,s3,5f1e <printint+0x82>
}
    5f32:	70e2                	ld	ra,56(sp)
    5f34:	7442                	ld	s0,48(sp)
    5f36:	74a2                	ld	s1,40(sp)
    5f38:	7902                	ld	s2,32(sp)
    5f3a:	69e2                	ld	s3,24(sp)
    5f3c:	6121                	addi	sp,sp,64
    5f3e:	8082                	ret
    x = -xx;
    5f40:	40b005bb          	negw	a1,a1
    neg = 1;
    5f44:	4885                	li	a7,1
    x = -xx;
    5f46:	bf85                	j	5eb6 <printint+0x1a>

0000000000005f48 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5f48:	715d                	addi	sp,sp,-80
    5f4a:	e486                	sd	ra,72(sp)
    5f4c:	e0a2                	sd	s0,64(sp)
    5f4e:	fc26                	sd	s1,56(sp)
    5f50:	f84a                	sd	s2,48(sp)
    5f52:	f44e                	sd	s3,40(sp)
    5f54:	f052                	sd	s4,32(sp)
    5f56:	ec56                	sd	s5,24(sp)
    5f58:	e85a                	sd	s6,16(sp)
    5f5a:	e45e                	sd	s7,8(sp)
    5f5c:	e062                	sd	s8,0(sp)
    5f5e:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5f60:	0005c903          	lbu	s2,0(a1)
    5f64:	18090c63          	beqz	s2,60fc <vprintf+0x1b4>
    5f68:	8aaa                	mv	s5,a0
    5f6a:	8bb2                	mv	s7,a2
    5f6c:	00158493          	addi	s1,a1,1
  state = 0;
    5f70:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5f72:	02500a13          	li	s4,37
    5f76:	4b55                	li	s6,21
    5f78:	a839                	j	5f96 <vprintf+0x4e>
        putc(fd, c);
    5f7a:	85ca                	mv	a1,s2
    5f7c:	8556                	mv	a0,s5
    5f7e:	00000097          	auipc	ra,0x0
    5f82:	efc080e7          	jalr	-260(ra) # 5e7a <putc>
    5f86:	a019                	j	5f8c <vprintf+0x44>
    } else if(state == '%'){
    5f88:	01498d63          	beq	s3,s4,5fa2 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    5f8c:	0485                	addi	s1,s1,1
    5f8e:	fff4c903          	lbu	s2,-1(s1)
    5f92:	16090563          	beqz	s2,60fc <vprintf+0x1b4>
    if(state == 0){
    5f96:	fe0999e3          	bnez	s3,5f88 <vprintf+0x40>
      if(c == '%'){
    5f9a:	ff4910e3          	bne	s2,s4,5f7a <vprintf+0x32>
        state = '%';
    5f9e:	89d2                	mv	s3,s4
    5fa0:	b7f5                	j	5f8c <vprintf+0x44>
      if(c == 'd'){
    5fa2:	13490263          	beq	s2,s4,60c6 <vprintf+0x17e>
    5fa6:	f9d9079b          	addiw	a5,s2,-99
    5faa:	0ff7f793          	zext.b	a5,a5
    5fae:	12fb6563          	bltu	s6,a5,60d8 <vprintf+0x190>
    5fb2:	f9d9079b          	addiw	a5,s2,-99
    5fb6:	0ff7f713          	zext.b	a4,a5
    5fba:	10eb6f63          	bltu	s6,a4,60d8 <vprintf+0x190>
    5fbe:	00271793          	slli	a5,a4,0x2
    5fc2:	00002717          	auipc	a4,0x2
    5fc6:	7ee70713          	addi	a4,a4,2030 # 87b0 <malloc+0x25b6>
    5fca:	97ba                	add	a5,a5,a4
    5fcc:	439c                	lw	a5,0(a5)
    5fce:	97ba                	add	a5,a5,a4
    5fd0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    5fd2:	008b8913          	addi	s2,s7,8
    5fd6:	4685                	li	a3,1
    5fd8:	4629                	li	a2,10
    5fda:	000ba583          	lw	a1,0(s7)
    5fde:	8556                	mv	a0,s5
    5fe0:	00000097          	auipc	ra,0x0
    5fe4:	ebc080e7          	jalr	-324(ra) # 5e9c <printint>
    5fe8:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    5fea:	4981                	li	s3,0
    5fec:	b745                	j	5f8c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5fee:	008b8913          	addi	s2,s7,8
    5ff2:	4681                	li	a3,0
    5ff4:	4629                	li	a2,10
    5ff6:	000ba583          	lw	a1,0(s7)
    5ffa:	8556                	mv	a0,s5
    5ffc:	00000097          	auipc	ra,0x0
    6000:	ea0080e7          	jalr	-352(ra) # 5e9c <printint>
    6004:	8bca                	mv	s7,s2
      state = 0;
    6006:	4981                	li	s3,0
    6008:	b751                	j	5f8c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    600a:	008b8913          	addi	s2,s7,8
    600e:	4681                	li	a3,0
    6010:	4641                	li	a2,16
    6012:	000ba583          	lw	a1,0(s7)
    6016:	8556                	mv	a0,s5
    6018:	00000097          	auipc	ra,0x0
    601c:	e84080e7          	jalr	-380(ra) # 5e9c <printint>
    6020:	8bca                	mv	s7,s2
      state = 0;
    6022:	4981                	li	s3,0
    6024:	b7a5                	j	5f8c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    6026:	008b8c13          	addi	s8,s7,8
    602a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    602e:	03000593          	li	a1,48
    6032:	8556                	mv	a0,s5
    6034:	00000097          	auipc	ra,0x0
    6038:	e46080e7          	jalr	-442(ra) # 5e7a <putc>
  putc(fd, 'x');
    603c:	07800593          	li	a1,120
    6040:	8556                	mv	a0,s5
    6042:	00000097          	auipc	ra,0x0
    6046:	e38080e7          	jalr	-456(ra) # 5e7a <putc>
    604a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    604c:	00002b97          	auipc	s7,0x2
    6050:	7bcb8b93          	addi	s7,s7,1980 # 8808 <digits>
    6054:	03c9d793          	srli	a5,s3,0x3c
    6058:	97de                	add	a5,a5,s7
    605a:	0007c583          	lbu	a1,0(a5)
    605e:	8556                	mv	a0,s5
    6060:	00000097          	auipc	ra,0x0
    6064:	e1a080e7          	jalr	-486(ra) # 5e7a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    6068:	0992                	slli	s3,s3,0x4
    606a:	397d                	addiw	s2,s2,-1
    606c:	fe0914e3          	bnez	s2,6054 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    6070:	8be2                	mv	s7,s8
      state = 0;
    6072:	4981                	li	s3,0
    6074:	bf21                	j	5f8c <vprintf+0x44>
        s = va_arg(ap, char*);
    6076:	008b8993          	addi	s3,s7,8
    607a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    607e:	02090163          	beqz	s2,60a0 <vprintf+0x158>
        while(*s != 0){
    6082:	00094583          	lbu	a1,0(s2)
    6086:	c9a5                	beqz	a1,60f6 <vprintf+0x1ae>
          putc(fd, *s);
    6088:	8556                	mv	a0,s5
    608a:	00000097          	auipc	ra,0x0
    608e:	df0080e7          	jalr	-528(ra) # 5e7a <putc>
          s++;
    6092:	0905                	addi	s2,s2,1
        while(*s != 0){
    6094:	00094583          	lbu	a1,0(s2)
    6098:	f9e5                	bnez	a1,6088 <vprintf+0x140>
        s = va_arg(ap, char*);
    609a:	8bce                	mv	s7,s3
      state = 0;
    609c:	4981                	li	s3,0
    609e:	b5fd                	j	5f8c <vprintf+0x44>
          s = "(null)";
    60a0:	00002917          	auipc	s2,0x2
    60a4:	70890913          	addi	s2,s2,1800 # 87a8 <malloc+0x25ae>
        while(*s != 0){
    60a8:	02800593          	li	a1,40
    60ac:	bff1                	j	6088 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    60ae:	008b8913          	addi	s2,s7,8
    60b2:	000bc583          	lbu	a1,0(s7)
    60b6:	8556                	mv	a0,s5
    60b8:	00000097          	auipc	ra,0x0
    60bc:	dc2080e7          	jalr	-574(ra) # 5e7a <putc>
    60c0:	8bca                	mv	s7,s2
      state = 0;
    60c2:	4981                	li	s3,0
    60c4:	b5e1                	j	5f8c <vprintf+0x44>
        putc(fd, c);
    60c6:	02500593          	li	a1,37
    60ca:	8556                	mv	a0,s5
    60cc:	00000097          	auipc	ra,0x0
    60d0:	dae080e7          	jalr	-594(ra) # 5e7a <putc>
      state = 0;
    60d4:	4981                	li	s3,0
    60d6:	bd5d                	j	5f8c <vprintf+0x44>
        putc(fd, '%');
    60d8:	02500593          	li	a1,37
    60dc:	8556                	mv	a0,s5
    60de:	00000097          	auipc	ra,0x0
    60e2:	d9c080e7          	jalr	-612(ra) # 5e7a <putc>
        putc(fd, c);
    60e6:	85ca                	mv	a1,s2
    60e8:	8556                	mv	a0,s5
    60ea:	00000097          	auipc	ra,0x0
    60ee:	d90080e7          	jalr	-624(ra) # 5e7a <putc>
      state = 0;
    60f2:	4981                	li	s3,0
    60f4:	bd61                	j	5f8c <vprintf+0x44>
        s = va_arg(ap, char*);
    60f6:	8bce                	mv	s7,s3
      state = 0;
    60f8:	4981                	li	s3,0
    60fa:	bd49                	j	5f8c <vprintf+0x44>
    }
  }
}
    60fc:	60a6                	ld	ra,72(sp)
    60fe:	6406                	ld	s0,64(sp)
    6100:	74e2                	ld	s1,56(sp)
    6102:	7942                	ld	s2,48(sp)
    6104:	79a2                	ld	s3,40(sp)
    6106:	7a02                	ld	s4,32(sp)
    6108:	6ae2                	ld	s5,24(sp)
    610a:	6b42                	ld	s6,16(sp)
    610c:	6ba2                	ld	s7,8(sp)
    610e:	6c02                	ld	s8,0(sp)
    6110:	6161                	addi	sp,sp,80
    6112:	8082                	ret

0000000000006114 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    6114:	715d                	addi	sp,sp,-80
    6116:	ec06                	sd	ra,24(sp)
    6118:	e822                	sd	s0,16(sp)
    611a:	1000                	addi	s0,sp,32
    611c:	e010                	sd	a2,0(s0)
    611e:	e414                	sd	a3,8(s0)
    6120:	e818                	sd	a4,16(s0)
    6122:	ec1c                	sd	a5,24(s0)
    6124:	03043023          	sd	a6,32(s0)
    6128:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    612c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    6130:	8622                	mv	a2,s0
    6132:	00000097          	auipc	ra,0x0
    6136:	e16080e7          	jalr	-490(ra) # 5f48 <vprintf>
}
    613a:	60e2                	ld	ra,24(sp)
    613c:	6442                	ld	s0,16(sp)
    613e:	6161                	addi	sp,sp,80
    6140:	8082                	ret

0000000000006142 <printf>:

void
printf(const char *fmt, ...)
{
    6142:	711d                	addi	sp,sp,-96
    6144:	ec06                	sd	ra,24(sp)
    6146:	e822                	sd	s0,16(sp)
    6148:	1000                	addi	s0,sp,32
    614a:	e40c                	sd	a1,8(s0)
    614c:	e810                	sd	a2,16(s0)
    614e:	ec14                	sd	a3,24(s0)
    6150:	f018                	sd	a4,32(s0)
    6152:	f41c                	sd	a5,40(s0)
    6154:	03043823          	sd	a6,48(s0)
    6158:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    615c:	00840613          	addi	a2,s0,8
    6160:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    6164:	85aa                	mv	a1,a0
    6166:	4505                	li	a0,1
    6168:	00000097          	auipc	ra,0x0
    616c:	de0080e7          	jalr	-544(ra) # 5f48 <vprintf>
}
    6170:	60e2                	ld	ra,24(sp)
    6172:	6442                	ld	s0,16(sp)
    6174:	6125                	addi	sp,sp,96
    6176:	8082                	ret

0000000000006178 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    6178:	1141                	addi	sp,sp,-16
    617a:	e422                	sd	s0,8(sp)
    617c:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    617e:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    6182:	00003797          	auipc	a5,0x3
    6186:	2d67b783          	ld	a5,726(a5) # 9458 <freep>
    618a:	a02d                	j	61b4 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    618c:	4618                	lw	a4,8(a2)
    618e:	9f2d                	addw	a4,a4,a1
    6190:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    6194:	6398                	ld	a4,0(a5)
    6196:	6310                	ld	a2,0(a4)
    6198:	a83d                	j	61d6 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    619a:	ff852703          	lw	a4,-8(a0)
    619e:	9f31                	addw	a4,a4,a2
    61a0:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    61a2:	ff053683          	ld	a3,-16(a0)
    61a6:	a091                	j	61ea <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    61a8:	6398                	ld	a4,0(a5)
    61aa:	00e7e463          	bltu	a5,a4,61b2 <free+0x3a>
    61ae:	00e6ea63          	bltu	a3,a4,61c2 <free+0x4a>
{
    61b2:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    61b4:	fed7fae3          	bgeu	a5,a3,61a8 <free+0x30>
    61b8:	6398                	ld	a4,0(a5)
    61ba:	00e6e463          	bltu	a3,a4,61c2 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    61be:	fee7eae3          	bltu	a5,a4,61b2 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    61c2:	ff852583          	lw	a1,-8(a0)
    61c6:	6390                	ld	a2,0(a5)
    61c8:	02059813          	slli	a6,a1,0x20
    61cc:	01c85713          	srli	a4,a6,0x1c
    61d0:	9736                	add	a4,a4,a3
    61d2:	fae60de3          	beq	a2,a4,618c <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    61d6:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    61da:	4790                	lw	a2,8(a5)
    61dc:	02061593          	slli	a1,a2,0x20
    61e0:	01c5d713          	srli	a4,a1,0x1c
    61e4:	973e                	add	a4,a4,a5
    61e6:	fae68ae3          	beq	a3,a4,619a <free+0x22>
        p->s.ptr = bp->s.ptr;
    61ea:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    61ec:	00003717          	auipc	a4,0x3
    61f0:	26f73623          	sd	a5,620(a4) # 9458 <freep>
}
    61f4:	6422                	ld	s0,8(sp)
    61f6:	0141                	addi	sp,sp,16
    61f8:	8082                	ret

00000000000061fa <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    61fa:	7139                	addi	sp,sp,-64
    61fc:	fc06                	sd	ra,56(sp)
    61fe:	f822                	sd	s0,48(sp)
    6200:	f426                	sd	s1,40(sp)
    6202:	f04a                	sd	s2,32(sp)
    6204:	ec4e                	sd	s3,24(sp)
    6206:	e852                	sd	s4,16(sp)
    6208:	e456                	sd	s5,8(sp)
    620a:	e05a                	sd	s6,0(sp)
    620c:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    620e:	02051493          	slli	s1,a0,0x20
    6212:	9081                	srli	s1,s1,0x20
    6214:	04bd                	addi	s1,s1,15
    6216:	8091                	srli	s1,s1,0x4
    6218:	0014899b          	addiw	s3,s1,1
    621c:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    621e:	00003517          	auipc	a0,0x3
    6222:	23a53503          	ld	a0,570(a0) # 9458 <freep>
    6226:	c515                	beqz	a0,6252 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    6228:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    622a:	4798                	lw	a4,8(a5)
    622c:	02977f63          	bgeu	a4,s1,626a <malloc+0x70>
    if (nu < 4096)
    6230:	8a4e                	mv	s4,s3
    6232:	0009871b          	sext.w	a4,s3
    6236:	6685                	lui	a3,0x1
    6238:	00d77363          	bgeu	a4,a3,623e <malloc+0x44>
    623c:	6a05                	lui	s4,0x1
    623e:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    6242:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    6246:	00003917          	auipc	s2,0x3
    624a:	21290913          	addi	s2,s2,530 # 9458 <freep>
    if (p == (char *)-1)
    624e:	5afd                	li	s5,-1
    6250:	a895                	j	62c4 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    6252:	0000a797          	auipc	a5,0xa
    6256:	a2678793          	addi	a5,a5,-1498 # fc78 <base>
    625a:	00003717          	auipc	a4,0x3
    625e:	1ef73f23          	sd	a5,510(a4) # 9458 <freep>
    6262:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    6264:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    6268:	b7e1                	j	6230 <malloc+0x36>
            if (p->s.size == nunits)
    626a:	02e48c63          	beq	s1,a4,62a2 <malloc+0xa8>
                p->s.size -= nunits;
    626e:	4137073b          	subw	a4,a4,s3
    6272:	c798                	sw	a4,8(a5)
                p += p->s.size;
    6274:	02071693          	slli	a3,a4,0x20
    6278:	01c6d713          	srli	a4,a3,0x1c
    627c:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    627e:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    6282:	00003717          	auipc	a4,0x3
    6286:	1ca73b23          	sd	a0,470(a4) # 9458 <freep>
            return (void *)(p + 1);
    628a:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    628e:	70e2                	ld	ra,56(sp)
    6290:	7442                	ld	s0,48(sp)
    6292:	74a2                	ld	s1,40(sp)
    6294:	7902                	ld	s2,32(sp)
    6296:	69e2                	ld	s3,24(sp)
    6298:	6a42                	ld	s4,16(sp)
    629a:	6aa2                	ld	s5,8(sp)
    629c:	6b02                	ld	s6,0(sp)
    629e:	6121                	addi	sp,sp,64
    62a0:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    62a2:	6398                	ld	a4,0(a5)
    62a4:	e118                	sd	a4,0(a0)
    62a6:	bff1                	j	6282 <malloc+0x88>
    hp->s.size = nu;
    62a8:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    62ac:	0541                	addi	a0,a0,16
    62ae:	00000097          	auipc	ra,0x0
    62b2:	eca080e7          	jalr	-310(ra) # 6178 <free>
    return freep;
    62b6:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    62ba:	d971                	beqz	a0,628e <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    62bc:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    62be:	4798                	lw	a4,8(a5)
    62c0:	fa9775e3          	bgeu	a4,s1,626a <malloc+0x70>
        if (p == freep)
    62c4:	00093703          	ld	a4,0(s2)
    62c8:	853e                	mv	a0,a5
    62ca:	fef719e3          	bne	a4,a5,62bc <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    62ce:	8552                	mv	a0,s4
    62d0:	00000097          	auipc	ra,0x0
    62d4:	b7a080e7          	jalr	-1158(ra) # 5e4a <sbrk>
    if (p == (char *)-1)
    62d8:	fd5518e3          	bne	a0,s5,62a8 <malloc+0xae>
                return 0;
    62dc:	4501                	li	a0,0
    62de:	bf45                	j	628e <malloc+0x94>
