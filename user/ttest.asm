
user/_ttest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print_hello_world>:
    release(&shared_state_lock);
    return 0;
}

void *print_hello_world(void *arg)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
    printf("Hello World\n");
       8:	00001517          	auipc	a0,0x1
       c:	27850513          	addi	a0,a0,632 # 1280 <__FUNCTION__.4+0x10>
      10:	00001097          	auipc	ra,0x1
      14:	098080e7          	jalr	152(ra) # 10a8 <printf>
    return 0;
}
      18:	4501                	li	a0,0
      1a:	60a2                	ld	ra,8(sp)
      1c:	6402                	ld	s0,0(sp)
      1e:	0141                	addi	sp,sp,16
      20:	8082                	ret

0000000000000022 <print_hello_world_with_tid>:

void *print_hello_world_with_tid(void *arg)
{
      22:	1141                	addi	sp,sp,-16
      24:	e406                	sd	ra,8(sp)
      26:	e022                	sd	s0,0(sp)
      28:	0800                	addi	s0,sp,16
    printf("Hello World from Thread %d\n", twhoami());
      2a:	00001097          	auipc	ra,0x1
      2e:	9ac080e7          	jalr	-1620(ra) # 9d6 <twhoami>
      32:	0005059b          	sext.w	a1,a0
      36:	00001517          	auipc	a0,0x1
      3a:	25a50513          	addi	a0,a0,602 # 1290 <__FUNCTION__.4+0x20>
      3e:	00001097          	auipc	ra,0x1
      42:	06a080e7          	jalr	106(ra) # 10a8 <printf>
    return 0;
}
      46:	4501                	li	a0,0
      48:	60a2                	ld	ra,8(sp)
      4a:	6402                	ld	s0,0(sp)
      4c:	0141                	addi	sp,sp,16
      4e:	8082                	ret

0000000000000050 <race_for_state>:
{
      50:	7179                	addi	sp,sp,-48
      52:	f406                	sd	ra,40(sp)
      54:	f022                	sd	s0,32(sp)
      56:	ec26                	sd	s1,24(sp)
      58:	e84a                	sd	s2,16(sp)
      5a:	e44e                	sd	s3,8(sp)
      5c:	e052                	sd	s4,0(sp)
      5e:	1800                	addi	s0,sp,48
    struct arg args = *(struct arg *)arg;
      60:	00052a03          	lw	s4,0(a0)
      64:	00452983          	lw	s3,4(a0)
    printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
      68:	00001097          	auipc	ra,0x1
      6c:	96e080e7          	jalr	-1682(ra) # 9d6 <twhoami>
      70:	00002497          	auipc	s1,0x2
      74:	fa048493          	addi	s1,s1,-96 # 2010 <shared_state>
      78:	4094                	lw	a3,0(s1)
      7a:	0005061b          	sext.w	a2,a0
      7e:	00001597          	auipc	a1,0x1
      82:	34a58593          	addi	a1,a1,842 # 13c8 <__FUNCTION__.6>
      86:	00001517          	auipc	a0,0x1
      8a:	22a50513          	addi	a0,a0,554 # 12b0 <__FUNCTION__.4+0x40>
      8e:	00001097          	auipc	ra,0x1
      92:	01a080e7          	jalr	26(ra) # 10a8 <printf>
    if (shared_state == 0)
      96:	409c                	lw	a5,0(s1)
      98:	ebb5                	bnez	a5,10c <race_for_state+0xbc>
        tyield();
      9a:	00001097          	auipc	ra,0x1
      9e:	8ba080e7          	jalr	-1862(ra) # 954 <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
      a2:	00001097          	auipc	ra,0x1
      a6:	934080e7          	jalr	-1740(ra) # 9d6 <twhoami>
      aa:	00001917          	auipc	s2,0x1
      ae:	31e90913          	addi	s2,s2,798 # 13c8 <__FUNCTION__.6>
      b2:	4094                	lw	a3,0(s1)
      b4:	0005061b          	sext.w	a2,a0
      b8:	85ca                	mv	a1,s2
      ba:	00001517          	auipc	a0,0x1
      be:	1f650513          	addi	a0,a0,502 # 12b0 <__FUNCTION__.4+0x40>
      c2:	00001097          	auipc	ra,0x1
      c6:	fe6080e7          	jalr	-26(ra) # 10a8 <printf>
        shared_state += args.a;
      ca:	409c                	lw	a5,0(s1)
      cc:	014787bb          	addw	a5,a5,s4
      d0:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
      d2:	00001097          	auipc	ra,0x1
      d6:	904080e7          	jalr	-1788(ra) # 9d6 <twhoami>
      da:	4094                	lw	a3,0(s1)
      dc:	0005061b          	sext.w	a2,a0
      e0:	85ca                	mv	a1,s2
      e2:	00001517          	auipc	a0,0x1
      e6:	1ce50513          	addi	a0,a0,462 # 12b0 <__FUNCTION__.4+0x40>
      ea:	00001097          	auipc	ra,0x1
      ee:	fbe080e7          	jalr	-66(ra) # 10a8 <printf>
        tyield();
      f2:	00001097          	auipc	ra,0x1
      f6:	862080e7          	jalr	-1950(ra) # 954 <tyield>
}
      fa:	4501                	li	a0,0
      fc:	70a2                	ld	ra,40(sp)
      fe:	7402                	ld	s0,32(sp)
     100:	64e2                	ld	s1,24(sp)
     102:	6942                	ld	s2,16(sp)
     104:	69a2                	ld	s3,8(sp)
     106:	6a02                	ld	s4,0(sp)
     108:	6145                	addi	sp,sp,48
     10a:	8082                	ret
        tyield();
     10c:	00001097          	auipc	ra,0x1
     110:	848080e7          	jalr	-1976(ra) # 954 <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     114:	00001097          	auipc	ra,0x1
     118:	8c2080e7          	jalr	-1854(ra) # 9d6 <twhoami>
     11c:	00002497          	auipc	s1,0x2
     120:	ef448493          	addi	s1,s1,-268 # 2010 <shared_state>
     124:	00001917          	auipc	s2,0x1
     128:	2a490913          	addi	s2,s2,676 # 13c8 <__FUNCTION__.6>
     12c:	4094                	lw	a3,0(s1)
     12e:	0005061b          	sext.w	a2,a0
     132:	85ca                	mv	a1,s2
     134:	00001517          	auipc	a0,0x1
     138:	17c50513          	addi	a0,a0,380 # 12b0 <__FUNCTION__.4+0x40>
     13c:	00001097          	auipc	ra,0x1
     140:	f6c080e7          	jalr	-148(ra) # 10a8 <printf>
        shared_state += args.b;
     144:	409c                	lw	a5,0(s1)
     146:	013787bb          	addw	a5,a5,s3
     14a:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     14c:	00001097          	auipc	ra,0x1
     150:	88a080e7          	jalr	-1910(ra) # 9d6 <twhoami>
     154:	4094                	lw	a3,0(s1)
     156:	0005061b          	sext.w	a2,a0
     15a:	85ca                	mv	a1,s2
     15c:	00001517          	auipc	a0,0x1
     160:	15450513          	addi	a0,a0,340 # 12b0 <__FUNCTION__.4+0x40>
     164:	00001097          	auipc	ra,0x1
     168:	f44080e7          	jalr	-188(ra) # 10a8 <printf>
        tyield();
     16c:	00000097          	auipc	ra,0x0
     170:	7e8080e7          	jalr	2024(ra) # 954 <tyield>
     174:	b759                	j	fa <race_for_state+0xaa>

0000000000000176 <no_race_for_state>:
{
     176:	7179                	addi	sp,sp,-48
     178:	f406                	sd	ra,40(sp)
     17a:	f022                	sd	s0,32(sp)
     17c:	ec26                	sd	s1,24(sp)
     17e:	e84a                	sd	s2,16(sp)
     180:	e44e                	sd	s3,8(sp)
     182:	e052                	sd	s4,0(sp)
     184:	1800                	addi	s0,sp,48
    struct arg args = *(struct arg *)arg;
     186:	00052a03          	lw	s4,0(a0)
     18a:	00452983          	lw	s3,4(a0)
    printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     18e:	00001097          	auipc	ra,0x1
     192:	848080e7          	jalr	-1976(ra) # 9d6 <twhoami>
     196:	00002497          	auipc	s1,0x2
     19a:	e7a48493          	addi	s1,s1,-390 # 2010 <shared_state>
     19e:	4094                	lw	a3,0(s1)
     1a0:	0005061b          	sext.w	a2,a0
     1a4:	00001597          	auipc	a1,0x1
     1a8:	23458593          	addi	a1,a1,564 # 13d8 <__FUNCTION__.5>
     1ac:	00001517          	auipc	a0,0x1
     1b0:	10450513          	addi	a0,a0,260 # 12b0 <__FUNCTION__.4+0x40>
     1b4:	00001097          	auipc	ra,0x1
     1b8:	ef4080e7          	jalr	-268(ra) # 10a8 <printf>
    acquire(&shared_state_lock);
     1bc:	00002517          	auipc	a0,0x2
     1c0:	e7450513          	addi	a0,a0,-396 # 2030 <shared_state_lock>
     1c4:	00000097          	auipc	ra,0x0
     1c8:	56a080e7          	jalr	1386(ra) # 72e <acquire>
    if (shared_state == 0)
     1cc:	409c                	lw	a5,0(s1)
     1ce:	e3d1                	bnez	a5,252 <no_race_for_state+0xdc>
        tyield();
     1d0:	00000097          	auipc	ra,0x0
     1d4:	784080e7          	jalr	1924(ra) # 954 <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     1d8:	00000097          	auipc	ra,0x0
     1dc:	7fe080e7          	jalr	2046(ra) # 9d6 <twhoami>
     1e0:	00001917          	auipc	s2,0x1
     1e4:	1f890913          	addi	s2,s2,504 # 13d8 <__FUNCTION__.5>
     1e8:	4094                	lw	a3,0(s1)
     1ea:	0005061b          	sext.w	a2,a0
     1ee:	85ca                	mv	a1,s2
     1f0:	00001517          	auipc	a0,0x1
     1f4:	0c050513          	addi	a0,a0,192 # 12b0 <__FUNCTION__.4+0x40>
     1f8:	00001097          	auipc	ra,0x1
     1fc:	eb0080e7          	jalr	-336(ra) # 10a8 <printf>
        shared_state += args.a;
     200:	409c                	lw	a5,0(s1)
     202:	014787bb          	addw	a5,a5,s4
     206:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     208:	00000097          	auipc	ra,0x0
     20c:	7ce080e7          	jalr	1998(ra) # 9d6 <twhoami>
     210:	4094                	lw	a3,0(s1)
     212:	0005061b          	sext.w	a2,a0
     216:	85ca                	mv	a1,s2
     218:	00001517          	auipc	a0,0x1
     21c:	09850513          	addi	a0,a0,152 # 12b0 <__FUNCTION__.4+0x40>
     220:	00001097          	auipc	ra,0x1
     224:	e88080e7          	jalr	-376(ra) # 10a8 <printf>
        tyield();
     228:	00000097          	auipc	ra,0x0
     22c:	72c080e7          	jalr	1836(ra) # 954 <tyield>
    release(&shared_state_lock);
     230:	00002517          	auipc	a0,0x2
     234:	e0050513          	addi	a0,a0,-512 # 2030 <shared_state_lock>
     238:	00000097          	auipc	ra,0x0
     23c:	576080e7          	jalr	1398(ra) # 7ae <release>
}
     240:	4501                	li	a0,0
     242:	70a2                	ld	ra,40(sp)
     244:	7402                	ld	s0,32(sp)
     246:	64e2                	ld	s1,24(sp)
     248:	6942                	ld	s2,16(sp)
     24a:	69a2                	ld	s3,8(sp)
     24c:	6a02                	ld	s4,0(sp)
     24e:	6145                	addi	sp,sp,48
     250:	8082                	ret
        tyield();
     252:	00000097          	auipc	ra,0x0
     256:	702080e7          	jalr	1794(ra) # 954 <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     25a:	00000097          	auipc	ra,0x0
     25e:	77c080e7          	jalr	1916(ra) # 9d6 <twhoami>
     262:	00002497          	auipc	s1,0x2
     266:	dae48493          	addi	s1,s1,-594 # 2010 <shared_state>
     26a:	00001917          	auipc	s2,0x1
     26e:	16e90913          	addi	s2,s2,366 # 13d8 <__FUNCTION__.5>
     272:	4094                	lw	a3,0(s1)
     274:	0005061b          	sext.w	a2,a0
     278:	85ca                	mv	a1,s2
     27a:	00001517          	auipc	a0,0x1
     27e:	03650513          	addi	a0,a0,54 # 12b0 <__FUNCTION__.4+0x40>
     282:	00001097          	auipc	ra,0x1
     286:	e26080e7          	jalr	-474(ra) # 10a8 <printf>
        shared_state += args.b;
     28a:	409c                	lw	a5,0(s1)
     28c:	013787bb          	addw	a5,a5,s3
     290:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     292:	00000097          	auipc	ra,0x0
     296:	744080e7          	jalr	1860(ra) # 9d6 <twhoami>
     29a:	4094                	lw	a3,0(s1)
     29c:	0005061b          	sext.w	a2,a0
     2a0:	85ca                	mv	a1,s2
     2a2:	00001517          	auipc	a0,0x1
     2a6:	00e50513          	addi	a0,a0,14 # 12b0 <__FUNCTION__.4+0x40>
     2aa:	00001097          	auipc	ra,0x1
     2ae:	dfe080e7          	jalr	-514(ra) # 10a8 <printf>
        tyield();
     2b2:	00000097          	auipc	ra,0x0
     2b6:	6a2080e7          	jalr	1698(ra) # 954 <tyield>
     2ba:	bf9d                	j	230 <no_race_for_state+0xba>

00000000000002bc <calculate_rv>:

void *calculate_rv(void *arg)
{
     2bc:	7179                	addi	sp,sp,-48
     2be:	f406                	sd	ra,40(sp)
     2c0:	f022                	sd	s0,32(sp)
     2c2:	ec26                	sd	s1,24(sp)
     2c4:	e84a                	sd	s2,16(sp)
     2c6:	e44e                	sd	s3,8(sp)
     2c8:	1800                	addi	s0,sp,48
    struct arg args = *(struct arg *)arg;
     2ca:	4104                	lw	s1,0(a0)
     2cc:	00452983          	lw	s3,4(a0)
    printf("child args: a=%d, b=%d\n", args.a, args.b);
     2d0:	864e                	mv	a2,s3
     2d2:	85a6                	mv	a1,s1
     2d4:	00001517          	auipc	a0,0x1
     2d8:	fec50513          	addi	a0,a0,-20 # 12c0 <__FUNCTION__.4+0x50>
     2dc:	00001097          	auipc	ra,0x1
     2e0:	dcc080e7          	jalr	-564(ra) # 10a8 <printf>
    int *result = (int *)malloc(sizeof(int));
     2e4:	4511                	li	a0,4
     2e6:	00001097          	auipc	ra,0x1
     2ea:	e7a080e7          	jalr	-390(ra) # 1160 <malloc>
     2ee:	892a                	mv	s2,a0
    *result = args.a + args.b;
     2f0:	013485bb          	addw	a1,s1,s3
     2f4:	c10c                	sw	a1,0(a0)
    printf("child result: %d\n", *result);
     2f6:	2581                	sext.w	a1,a1
     2f8:	00001517          	auipc	a0,0x1
     2fc:	fe050513          	addi	a0,a0,-32 # 12d8 <__FUNCTION__.4+0x68>
     300:	00001097          	auipc	ra,0x1
     304:	da8080e7          	jalr	-600(ra) # 10a8 <printf>
    return (void *)result;
}
     308:	854a                	mv	a0,s2
     30a:	70a2                	ld	ra,40(sp)
     30c:	7402                	ld	s0,32(sp)
     30e:	64e2                	ld	s1,24(sp)
     310:	6942                	ld	s2,16(sp)
     312:	69a2                	ld	s3,8(sp)
     314:	6145                	addi	sp,sp,48
     316:	8082                	ret

0000000000000318 <test1>:

void test1()
{
     318:	1101                	addi	sp,sp,-32
     31a:	ec06                	sd	ra,24(sp)
     31c:	e822                	sd	s0,16(sp)
     31e:	1000                	addi	s0,sp,32
    printf("[%s enter]\n", __FUNCTION__);
     320:	00001597          	auipc	a1,0x1
     324:	f5058593          	addi	a1,a1,-176 # 1270 <__FUNCTION__.4>
     328:	00001517          	auipc	a0,0x1
     32c:	fc850513          	addi	a0,a0,-56 # 12f0 <__FUNCTION__.4+0x80>
     330:	00001097          	auipc	ra,0x1
     334:	d78080e7          	jalr	-648(ra) # 10a8 <printf>
    struct thread *t;
    tcreate(&t, 0, &print_hello_world, 0);
     338:	4681                	li	a3,0
     33a:	00000617          	auipc	a2,0x0
     33e:	cc660613          	addi	a2,a2,-826 # 0 <print_hello_world>
     342:	4581                	li	a1,0
     344:	fe840513          	addi	a0,s0,-24
     348:	00000097          	auipc	ra,0x0
     34c:	56e080e7          	jalr	1390(ra) # 8b6 <tcreate>
    tyield();
     350:	00000097          	auipc	ra,0x0
     354:	604080e7          	jalr	1540(ra) # 954 <tyield>
    printf("[%s exit]\n", __FUNCTION__);
     358:	00001597          	auipc	a1,0x1
     35c:	f1858593          	addi	a1,a1,-232 # 1270 <__FUNCTION__.4>
     360:	00001517          	auipc	a0,0x1
     364:	fa050513          	addi	a0,a0,-96 # 1300 <__FUNCTION__.4+0x90>
     368:	00001097          	auipc	ra,0x1
     36c:	d40080e7          	jalr	-704(ra) # 10a8 <printf>
}
     370:	60e2                	ld	ra,24(sp)
     372:	6442                	ld	s0,16(sp)
     374:	6105                	addi	sp,sp,32
     376:	8082                	ret

0000000000000378 <test2>:

void test2()
{
     378:	7159                	addi	sp,sp,-112
     37a:	f486                	sd	ra,104(sp)
     37c:	f0a2                	sd	s0,96(sp)
     37e:	eca6                	sd	s1,88(sp)
     380:	e8ca                	sd	s2,80(sp)
     382:	e4ce                	sd	s3,72(sp)
     384:	e0d2                	sd	s4,64(sp)
     386:	1880                	addi	s0,sp,112
    printf("[%s enter]\n", __FUNCTION__);
     388:	00001597          	auipc	a1,0x1
     38c:	ee058593          	addi	a1,a1,-288 # 1268 <__FUNCTION__.3>
     390:	00001517          	auipc	a0,0x1
     394:	f6050513          	addi	a0,a0,-160 # 12f0 <__FUNCTION__.4+0x80>
     398:	00001097          	auipc	ra,0x1
     39c:	d10080e7          	jalr	-752(ra) # 10a8 <printf>
    struct thread *threadpool[8] = {0};
     3a0:	f8043823          	sd	zero,-112(s0)
     3a4:	f8043c23          	sd	zero,-104(s0)
     3a8:	fa043023          	sd	zero,-96(s0)
     3ac:	fa043423          	sd	zero,-88(s0)
     3b0:	fa043823          	sd	zero,-80(s0)
     3b4:	fa043c23          	sd	zero,-72(s0)
     3b8:	fc043023          	sd	zero,-64(s0)
     3bc:	fc043423          	sd	zero,-56(s0)
    for (int i = 0; i < 8; i++)
     3c0:	f9040493          	addi	s1,s0,-112
     3c4:	fd040993          	addi	s3,s0,-48
    struct thread *threadpool[8] = {0};
     3c8:	8926                	mv	s2,s1
    {
        tcreate(&threadpool[i], 0, &print_hello_world_with_tid, 0);
     3ca:	00000a17          	auipc	s4,0x0
     3ce:	c58a0a13          	addi	s4,s4,-936 # 22 <print_hello_world_with_tid>
     3d2:	4681                	li	a3,0
     3d4:	8652                	mv	a2,s4
     3d6:	4581                	li	a1,0
     3d8:	854a                	mv	a0,s2
     3da:	00000097          	auipc	ra,0x0
     3de:	4dc080e7          	jalr	1244(ra) # 8b6 <tcreate>
    for (int i = 0; i < 8; i++)
     3e2:	0921                	addi	s2,s2,8
     3e4:	ff3917e3          	bne	s2,s3,3d2 <test2+0x5a>
    }
    for (int i = 0; i < 8; i++)
    {
        tjoin(threadpool[i]->tid, 0, 0);
     3e8:	609c                	ld	a5,0(s1)
     3ea:	4601                	li	a2,0
     3ec:	4581                	li	a1,0
     3ee:	0007c503          	lbu	a0,0(a5)
     3f2:	00000097          	auipc	ra,0x0
     3f6:	586080e7          	jalr	1414(ra) # 978 <tjoin>
    for (int i = 0; i < 8; i++)
     3fa:	04a1                	addi	s1,s1,8
     3fc:	ff3496e3          	bne	s1,s3,3e8 <test2+0x70>
    }
    printf("[%s exit]\n", __FUNCTION__);
     400:	00001597          	auipc	a1,0x1
     404:	e6858593          	addi	a1,a1,-408 # 1268 <__FUNCTION__.3>
     408:	00001517          	auipc	a0,0x1
     40c:	ef850513          	addi	a0,a0,-264 # 1300 <__FUNCTION__.4+0x90>
     410:	00001097          	auipc	ra,0x1
     414:	c98080e7          	jalr	-872(ra) # 10a8 <printf>
}
     418:	70a6                	ld	ra,104(sp)
     41a:	7406                	ld	s0,96(sp)
     41c:	64e6                	ld	s1,88(sp)
     41e:	6946                	ld	s2,80(sp)
     420:	69a6                	ld	s3,72(sp)
     422:	6a06                	ld	s4,64(sp)
     424:	6165                	addi	sp,sp,112
     426:	8082                	ret

0000000000000428 <test3>:

void test3()
{
     428:	7179                	addi	sp,sp,-48
     42a:	f406                	sd	ra,40(sp)
     42c:	f022                	sd	s0,32(sp)
     42e:	1800                	addi	s0,sp,48
    printf("[%s enter]\n", __FUNCTION__);
     430:	00001597          	auipc	a1,0x1
     434:	e3058593          	addi	a1,a1,-464 # 1260 <__FUNCTION__.2>
     438:	00001517          	auipc	a0,0x1
     43c:	eb850513          	addi	a0,a0,-328 # 12f0 <__FUNCTION__.4+0x80>
     440:	00001097          	auipc	ra,0x1
     444:	c68080e7          	jalr	-920(ra) # 10a8 <printf>
    struct thread *t;
    struct thread_attr tattr;
    tattr.res_size = sizeof(int);
     448:	4791                	li	a5,4
     44a:	fef42223          	sw	a5,-28(s0)
    tattr.stacksize = 512;
     44e:	20000793          	li	a5,512
     452:	fef42023          	sw	a5,-32(s0)
    struct arg args;
    args.a = 1;
     456:	4785                	li	a5,1
     458:	fcf42c23          	sw	a5,-40(s0)
    args.b = 10;
     45c:	47a9                	li	a5,10
     45e:	fcf42e23          	sw	a5,-36(s0)
    tcreate(&t, &tattr, &calculate_rv, &args);
     462:	fd840693          	addi	a3,s0,-40
     466:	00000617          	auipc	a2,0x0
     46a:	e5660613          	addi	a2,a2,-426 # 2bc <calculate_rv>
     46e:	fe040593          	addi	a1,s0,-32
     472:	fe840513          	addi	a0,s0,-24
     476:	00000097          	auipc	ra,0x0
     47a:	440080e7          	jalr	1088(ra) # 8b6 <tcreate>
    int result;
    tjoin(t->tid, &result, sizeof(int));
     47e:	4611                	li	a2,4
     480:	fd440593          	addi	a1,s0,-44
     484:	fe843783          	ld	a5,-24(s0)
     488:	0007c503          	lbu	a0,0(a5)
     48c:	00000097          	auipc	ra,0x0
     490:	4ec080e7          	jalr	1260(ra) # 978 <tjoin>
    printf("parent result: %d\n", result);
     494:	fd442583          	lw	a1,-44(s0)
     498:	00001517          	auipc	a0,0x1
     49c:	e7850513          	addi	a0,a0,-392 # 1310 <__FUNCTION__.4+0xa0>
     4a0:	00001097          	auipc	ra,0x1
     4a4:	c08080e7          	jalr	-1016(ra) # 10a8 <printf>
    printf("[%s exit]\n", __FUNCTION__);
     4a8:	00001597          	auipc	a1,0x1
     4ac:	db858593          	addi	a1,a1,-584 # 1260 <__FUNCTION__.2>
     4b0:	00001517          	auipc	a0,0x1
     4b4:	e5050513          	addi	a0,a0,-432 # 1300 <__FUNCTION__.4+0x90>
     4b8:	00001097          	auipc	ra,0x1
     4bc:	bf0080e7          	jalr	-1040(ra) # 10a8 <printf>
}
     4c0:	70a2                	ld	ra,40(sp)
     4c2:	7402                	ld	s0,32(sp)
     4c4:	6145                	addi	sp,sp,48
     4c6:	8082                	ret

00000000000004c8 <test4>:

void test4()
{
     4c8:	7179                	addi	sp,sp,-48
     4ca:	f406                	sd	ra,40(sp)
     4cc:	f022                	sd	s0,32(sp)
     4ce:	1800                	addi	s0,sp,48
    printf("[%s enter]\n", __FUNCTION__);
     4d0:	00001597          	auipc	a1,0x1
     4d4:	d8858593          	addi	a1,a1,-632 # 1258 <__FUNCTION__.1>
     4d8:	00001517          	auipc	a0,0x1
     4dc:	e1850513          	addi	a0,a0,-488 # 12f0 <__FUNCTION__.4+0x80>
     4e0:	00001097          	auipc	ra,0x1
     4e4:	bc8080e7          	jalr	-1080(ra) # 10a8 <printf>
    struct thread *ta;
    struct thread *tb;
    struct arg args;
    args.a = 1;
     4e8:	4785                	li	a5,1
     4ea:	fcf42c23          	sw	a5,-40(s0)
    args.b = 2;
     4ee:	4789                	li	a5,2
     4f0:	fcf42e23          	sw	a5,-36(s0)
    tcreate(&ta, 0, &race_for_state, &args);
     4f4:	fd840693          	addi	a3,s0,-40
     4f8:	00000617          	auipc	a2,0x0
     4fc:	b5860613          	addi	a2,a2,-1192 # 50 <race_for_state>
     500:	4581                	li	a1,0
     502:	fe840513          	addi	a0,s0,-24
     506:	00000097          	auipc	ra,0x0
     50a:	3b0080e7          	jalr	944(ra) # 8b6 <tcreate>
    tcreate(&tb, 0, &race_for_state, &args);
     50e:	fd840693          	addi	a3,s0,-40
     512:	00000617          	auipc	a2,0x0
     516:	b3e60613          	addi	a2,a2,-1218 # 50 <race_for_state>
     51a:	4581                	li	a1,0
     51c:	fe040513          	addi	a0,s0,-32
     520:	00000097          	auipc	ra,0x0
     524:	396080e7          	jalr	918(ra) # 8b6 <tcreate>
    tyield();
     528:	00000097          	auipc	ra,0x0
     52c:	42c080e7          	jalr	1068(ra) # 954 <tyield>
    tjoin(ta->tid, 0, 0);
     530:	4601                	li	a2,0
     532:	4581                	li	a1,0
     534:	fe843783          	ld	a5,-24(s0)
     538:	0007c503          	lbu	a0,0(a5)
     53c:	00000097          	auipc	ra,0x0
     540:	43c080e7          	jalr	1084(ra) # 978 <tjoin>
    tjoin(tb->tid, 0, 0);
     544:	4601                	li	a2,0
     546:	4581                	li	a1,0
     548:	fe043783          	ld	a5,-32(s0)
     54c:	0007c503          	lbu	a0,0(a5)
     550:	00000097          	auipc	ra,0x0
     554:	428080e7          	jalr	1064(ra) # 978 <tjoin>
    printf("[%s exit]\n", __FUNCTION__);
     558:	00001597          	auipc	a1,0x1
     55c:	d0058593          	addi	a1,a1,-768 # 1258 <__FUNCTION__.1>
     560:	00001517          	auipc	a0,0x1
     564:	da050513          	addi	a0,a0,-608 # 1300 <__FUNCTION__.4+0x90>
     568:	00001097          	auipc	ra,0x1
     56c:	b40080e7          	jalr	-1216(ra) # 10a8 <printf>
}
     570:	70a2                	ld	ra,40(sp)
     572:	7402                	ld	s0,32(sp)
     574:	6145                	addi	sp,sp,48
     576:	8082                	ret

0000000000000578 <test5>:

void test5()
{
     578:	7179                	addi	sp,sp,-48
     57a:	f406                	sd	ra,40(sp)
     57c:	f022                	sd	s0,32(sp)
     57e:	1800                	addi	s0,sp,48
    printf("[%s enter]\n", __FUNCTION__);
     580:	00001597          	auipc	a1,0x1
     584:	cd058593          	addi	a1,a1,-816 # 1250 <__FUNCTION__.0>
     588:	00001517          	auipc	a0,0x1
     58c:	d6850513          	addi	a0,a0,-664 # 12f0 <__FUNCTION__.4+0x80>
     590:	00001097          	auipc	ra,0x1
     594:	b18080e7          	jalr	-1256(ra) # 10a8 <printf>
    initlock(&shared_state_lock, "sharedstate lock");
     598:	00001597          	auipc	a1,0x1
     59c:	d9058593          	addi	a1,a1,-624 # 1328 <__FUNCTION__.4+0xb8>
     5a0:	00002517          	auipc	a0,0x2
     5a4:	a9050513          	addi	a0,a0,-1392 # 2030 <shared_state_lock>
     5a8:	00000097          	auipc	ra,0x0
     5ac:	13a080e7          	jalr	314(ra) # 6e2 <initlock>
    struct thread *ta;
    struct thread *tb;
    struct arg args;
    args.a = 1;
     5b0:	4785                	li	a5,1
     5b2:	fcf42c23          	sw	a5,-40(s0)
    args.b = 2;
     5b6:	4789                	li	a5,2
     5b8:	fcf42e23          	sw	a5,-36(s0)
    tcreate(&ta, 0, &no_race_for_state, &args);
     5bc:	fd840693          	addi	a3,s0,-40
     5c0:	00000617          	auipc	a2,0x0
     5c4:	bb660613          	addi	a2,a2,-1098 # 176 <no_race_for_state>
     5c8:	4581                	li	a1,0
     5ca:	fe840513          	addi	a0,s0,-24
     5ce:	00000097          	auipc	ra,0x0
     5d2:	2e8080e7          	jalr	744(ra) # 8b6 <tcreate>
    tcreate(&tb, 0, &no_race_for_state, &args);
     5d6:	fd840693          	addi	a3,s0,-40
     5da:	00000617          	auipc	a2,0x0
     5de:	b9c60613          	addi	a2,a2,-1124 # 176 <no_race_for_state>
     5e2:	4581                	li	a1,0
     5e4:	fe040513          	addi	a0,s0,-32
     5e8:	00000097          	auipc	ra,0x0
     5ec:	2ce080e7          	jalr	718(ra) # 8b6 <tcreate>
    tyield();
     5f0:	00000097          	auipc	ra,0x0
     5f4:	364080e7          	jalr	868(ra) # 954 <tyield>
    tjoin(ta->tid, 0, 0);
     5f8:	4601                	li	a2,0
     5fa:	4581                	li	a1,0
     5fc:	fe843783          	ld	a5,-24(s0)
     600:	0007c503          	lbu	a0,0(a5)
     604:	00000097          	auipc	ra,0x0
     608:	374080e7          	jalr	884(ra) # 978 <tjoin>
    tjoin(tb->tid, 0, 0);
     60c:	4601                	li	a2,0
     60e:	4581                	li	a1,0
     610:	fe043783          	ld	a5,-32(s0)
     614:	0007c503          	lbu	a0,0(a5)
     618:	00000097          	auipc	ra,0x0
     61c:	360080e7          	jalr	864(ra) # 978 <tjoin>
    printf("[%s exit]\n", __FUNCTION__);
     620:	00001597          	auipc	a1,0x1
     624:	c3058593          	addi	a1,a1,-976 # 1250 <__FUNCTION__.0>
     628:	00001517          	auipc	a0,0x1
     62c:	cd850513          	addi	a0,a0,-808 # 1300 <__FUNCTION__.4+0x90>
     630:	00001097          	auipc	ra,0x1
     634:	a78080e7          	jalr	-1416(ra) # 10a8 <printf>
}
     638:	70a2                	ld	ra,40(sp)
     63a:	7402                	ld	s0,32(sp)
     63c:	6145                	addi	sp,sp,48
     63e:	8082                	ret

0000000000000640 <main>:
int main(int argc, char *argv[])
{
     640:	1101                	addi	sp,sp,-32
     642:	ec06                	sd	ra,24(sp)
     644:	e822                	sd	s0,16(sp)
     646:	e426                	sd	s1,8(sp)
     648:	1000                	addi	s0,sp,32
    if (argc < 2)
     64a:	4785                	li	a5,1
     64c:	02a7d463          	bge	a5,a0,674 <main+0x34>
     650:	84ae                	mv	s1,a1
    {
        printf("ttest TEST_ID\n TEST ID\tId of the test to run. ID can be any value from 1 to 5\n");
        return -1;
    }

    switch (atoi(argv[1]))
     652:	6588                	ld	a0,8(a1)
     654:	00000097          	auipc	ra,0x0
     658:	5da080e7          	jalr	1498(ra) # c2e <atoi>
     65c:	4795                	li	a5,5
     65e:	06a7e763          	bltu	a5,a0,6cc <main+0x8c>
     662:	050a                	slli	a0,a0,0x2
     664:	00001717          	auipc	a4,0x1
     668:	d4c70713          	addi	a4,a4,-692 # 13b0 <__FUNCTION__.4+0x140>
     66c:	953a                	add	a0,a0,a4
     66e:	411c                	lw	a5,0(a0)
     670:	97ba                	add	a5,a5,a4
     672:	8782                	jr	a5
        printf("ttest TEST_ID\n TEST ID\tId of the test to run. ID can be any value from 1 to 5\n");
     674:	00001517          	auipc	a0,0x1
     678:	ccc50513          	addi	a0,a0,-820 # 1340 <__FUNCTION__.4+0xd0>
     67c:	00001097          	auipc	ra,0x1
     680:	a2c080e7          	jalr	-1492(ra) # 10a8 <printf>
        return -1;
     684:	557d                	li	a0,-1
     686:	a031                	j	692 <main+0x52>
    {
    case 1:
        test1();
     688:	00000097          	auipc	ra,0x0
     68c:	c90080e7          	jalr	-880(ra) # 318 <test1>

    default:
        printf("Error: No test with index %s\n", argv[1]);
        return -1;
    }
    return 0;
     690:	4501                	li	a0,0
    return 0;
     692:	60e2                	ld	ra,24(sp)
     694:	6442                	ld	s0,16(sp)
     696:	64a2                	ld	s1,8(sp)
     698:	6105                	addi	sp,sp,32
     69a:	8082                	ret
        test2();
     69c:	00000097          	auipc	ra,0x0
     6a0:	cdc080e7          	jalr	-804(ra) # 378 <test2>
    return 0;
     6a4:	4501                	li	a0,0
        break;
     6a6:	b7f5                	j	692 <main+0x52>
        test3();
     6a8:	00000097          	auipc	ra,0x0
     6ac:	d80080e7          	jalr	-640(ra) # 428 <test3>
    return 0;
     6b0:	4501                	li	a0,0
        break;
     6b2:	b7c5                	j	692 <main+0x52>
        test4();
     6b4:	00000097          	auipc	ra,0x0
     6b8:	e14080e7          	jalr	-492(ra) # 4c8 <test4>
    return 0;
     6bc:	4501                	li	a0,0
        break;
     6be:	bfd1                	j	692 <main+0x52>
        test5();
     6c0:	00000097          	auipc	ra,0x0
     6c4:	eb8080e7          	jalr	-328(ra) # 578 <test5>
    return 0;
     6c8:	4501                	li	a0,0
        break;
     6ca:	b7e1                	j	692 <main+0x52>
        printf("Error: No test with index %s\n", argv[1]);
     6cc:	648c                	ld	a1,8(s1)
     6ce:	00001517          	auipc	a0,0x1
     6d2:	cc250513          	addi	a0,a0,-830 # 1390 <__FUNCTION__.4+0x120>
     6d6:	00001097          	auipc	ra,0x1
     6da:	9d2080e7          	jalr	-1582(ra) # 10a8 <printf>
        return -1;
     6de:	557d                	li	a0,-1
     6e0:	bf4d                	j	692 <main+0x52>

00000000000006e2 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
     6e2:	1141                	addi	sp,sp,-16
     6e4:	e422                	sd	s0,8(sp)
     6e6:	0800                	addi	s0,sp,16
    lk->name = name;
     6e8:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
     6ea:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
     6ee:	57fd                	li	a5,-1
     6f0:	00f50823          	sb	a5,16(a0)
}
     6f4:	6422                	ld	s0,8(sp)
     6f6:	0141                	addi	sp,sp,16
     6f8:	8082                	ret

00000000000006fa <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
     6fa:	00054783          	lbu	a5,0(a0)
     6fe:	e399                	bnez	a5,704 <holding+0xa>
     700:	4501                	li	a0,0
}
     702:	8082                	ret
{
     704:	1101                	addi	sp,sp,-32
     706:	ec06                	sd	ra,24(sp)
     708:	e822                	sd	s0,16(sp)
     70a:	e426                	sd	s1,8(sp)
     70c:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
     70e:	01054483          	lbu	s1,16(a0)
     712:	00000097          	auipc	ra,0x0
     716:	2c4080e7          	jalr	708(ra) # 9d6 <twhoami>
     71a:	2501                	sext.w	a0,a0
     71c:	40a48533          	sub	a0,s1,a0
     720:	00153513          	seqz	a0,a0
}
     724:	60e2                	ld	ra,24(sp)
     726:	6442                	ld	s0,16(sp)
     728:	64a2                	ld	s1,8(sp)
     72a:	6105                	addi	sp,sp,32
     72c:	8082                	ret

000000000000072e <acquire>:

void acquire(struct lock *lk)
{
     72e:	7179                	addi	sp,sp,-48
     730:	f406                	sd	ra,40(sp)
     732:	f022                	sd	s0,32(sp)
     734:	ec26                	sd	s1,24(sp)
     736:	e84a                	sd	s2,16(sp)
     738:	e44e                	sd	s3,8(sp)
     73a:	e052                	sd	s4,0(sp)
     73c:	1800                	addi	s0,sp,48
     73e:	8a2a                	mv	s4,a0
    if (holding(lk))
     740:	00000097          	auipc	ra,0x0
     744:	fba080e7          	jalr	-70(ra) # 6fa <holding>
     748:	e919                	bnez	a0,75e <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
     74a:	ffca7493          	andi	s1,s4,-4
     74e:	003a7913          	andi	s2,s4,3
     752:	0039191b          	slliw	s2,s2,0x3
     756:	4985                	li	s3,1
     758:	012999bb          	sllw	s3,s3,s2
     75c:	a015                	j	780 <acquire+0x52>
        printf("re-acquiring lock we already hold");
     75e:	00001517          	auipc	a0,0x1
     762:	c9250513          	addi	a0,a0,-878 # 13f0 <__FUNCTION__.5+0x18>
     766:	00001097          	auipc	ra,0x1
     76a:	942080e7          	jalr	-1726(ra) # 10a8 <printf>
        exit(-1);
     76e:	557d                	li	a0,-1
     770:	00000097          	auipc	ra,0x0
     774:	5b8080e7          	jalr	1464(ra) # d28 <exit>
    {
        // give up the cpu for other threads
        tyield();
     778:	00000097          	auipc	ra,0x0
     77c:	1dc080e7          	jalr	476(ra) # 954 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
     780:	4534a7af          	amoor.w.aq	a5,s3,(s1)
     784:	0127d7bb          	srlw	a5,a5,s2
     788:	0ff7f793          	zext.b	a5,a5
     78c:	f7f5                	bnez	a5,778 <acquire+0x4a>
    }

    __sync_synchronize();
     78e:	0ff0000f          	fence

    lk->tid = twhoami();
     792:	00000097          	auipc	ra,0x0
     796:	244080e7          	jalr	580(ra) # 9d6 <twhoami>
     79a:	00aa0823          	sb	a0,16(s4)
}
     79e:	70a2                	ld	ra,40(sp)
     7a0:	7402                	ld	s0,32(sp)
     7a2:	64e2                	ld	s1,24(sp)
     7a4:	6942                	ld	s2,16(sp)
     7a6:	69a2                	ld	s3,8(sp)
     7a8:	6a02                	ld	s4,0(sp)
     7aa:	6145                	addi	sp,sp,48
     7ac:	8082                	ret

00000000000007ae <release>:

void release(struct lock *lk)
{
     7ae:	1101                	addi	sp,sp,-32
     7b0:	ec06                	sd	ra,24(sp)
     7b2:	e822                	sd	s0,16(sp)
     7b4:	e426                	sd	s1,8(sp)
     7b6:	1000                	addi	s0,sp,32
     7b8:	84aa                	mv	s1,a0
    if (!holding(lk))
     7ba:	00000097          	auipc	ra,0x0
     7be:	f40080e7          	jalr	-192(ra) # 6fa <holding>
     7c2:	c11d                	beqz	a0,7e8 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
     7c4:	57fd                	li	a5,-1
     7c6:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
     7ca:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
     7ce:	0ff0000f          	fence
     7d2:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
     7d6:	00000097          	auipc	ra,0x0
     7da:	17e080e7          	jalr	382(ra) # 954 <tyield>
}
     7de:	60e2                	ld	ra,24(sp)
     7e0:	6442                	ld	s0,16(sp)
     7e2:	64a2                	ld	s1,8(sp)
     7e4:	6105                	addi	sp,sp,32
     7e6:	8082                	ret
        printf("releasing lock we are not holding");
     7e8:	00001517          	auipc	a0,0x1
     7ec:	c3050513          	addi	a0,a0,-976 # 1418 <__FUNCTION__.5+0x40>
     7f0:	00001097          	auipc	ra,0x1
     7f4:	8b8080e7          	jalr	-1864(ra) # 10a8 <printf>
        exit(-1);
     7f8:	557d                	li	a0,-1
     7fa:	00000097          	auipc	ra,0x0
     7fe:	52e080e7          	jalr	1326(ra) # d28 <exit>

0000000000000802 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
     802:	00002517          	auipc	a0,0x2
     806:	81653503          	ld	a0,-2026(a0) # 2018 <current_thread>
     80a:	00002717          	auipc	a4,0x2
     80e:	83e70713          	addi	a4,a4,-1986 # 2048 <threads>
    for (int i = 0; i < 16; i++) {
     812:	4781                	li	a5,0
     814:	4641                	li	a2,16
        if (threads[i] == current_thread) {
     816:	6314                	ld	a3,0(a4)
     818:	00a68763          	beq	a3,a0,826 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
     81c:	2785                	addiw	a5,a5,1
     81e:	0721                	addi	a4,a4,8
     820:	fec79be3          	bne	a5,a2,816 <tsched+0x14>
    int current_index = 0;
     824:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
     826:	0017869b          	addiw	a3,a5,1
     82a:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     82e:	00002817          	auipc	a6,0x2
     832:	81a80813          	addi	a6,a6,-2022 # 2048 <threads>
     836:	488d                	li	a7,3
     838:	a021                	j	840 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
     83a:	2685                	addiw	a3,a3,1
     83c:	04c68363          	beq	a3,a2,882 <tsched+0x80>
        int next_index = (current_index + i) % 16;
     840:	41f6d71b          	sraiw	a4,a3,0x1f
     844:	01c7571b          	srliw	a4,a4,0x1c
     848:	00d707bb          	addw	a5,a4,a3
     84c:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     84e:	9f99                	subw	a5,a5,a4
     850:	078e                	slli	a5,a5,0x3
     852:	97c2                	add	a5,a5,a6
     854:	638c                	ld	a1,0(a5)
     856:	d1f5                	beqz	a1,83a <tsched+0x38>
     858:	5dbc                	lw	a5,120(a1)
     85a:	ff1790e3          	bne	a5,a7,83a <tsched+0x38>
{
     85e:	1141                	addi	sp,sp,-16
     860:	e406                	sd	ra,8(sp)
     862:	e022                	sd	s0,0(sp)
     864:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
     866:	00001797          	auipc	a5,0x1
     86a:	7ab7b923          	sd	a1,1970(a5) # 2018 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
     86e:	05a1                	addi	a1,a1,8
     870:	0521                	addi	a0,a0,8
     872:	00000097          	auipc	ra,0x0
     876:	17c080e7          	jalr	380(ra) # 9ee <tswtch>
        //printf("Thread switch complete\n");
    }
}
     87a:	60a2                	ld	ra,8(sp)
     87c:	6402                	ld	s0,0(sp)
     87e:	0141                	addi	sp,sp,16
     880:	8082                	ret
     882:	8082                	ret

0000000000000884 <thread_wrapper>:
{
     884:	1101                	addi	sp,sp,-32
     886:	ec06                	sd	ra,24(sp)
     888:	e822                	sd	s0,16(sp)
     88a:	e426                	sd	s1,8(sp)
     88c:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
     88e:	00001497          	auipc	s1,0x1
     892:	78a48493          	addi	s1,s1,1930 # 2018 <current_thread>
     896:	609c                	ld	a5,0(s1)
     898:	67d8                	ld	a4,136(a5)
     89a:	63c8                	ld	a0,128(a5)
     89c:	9702                	jalr	a4
    current_thread->state = EXITED;
     89e:	609c                	ld	a5,0(s1)
     8a0:	4719                	li	a4,6
     8a2:	dfb8                	sw	a4,120(a5)
    tsched();
     8a4:	00000097          	auipc	ra,0x0
     8a8:	f5e080e7          	jalr	-162(ra) # 802 <tsched>
}
     8ac:	60e2                	ld	ra,24(sp)
     8ae:	6442                	ld	s0,16(sp)
     8b0:	64a2                	ld	s1,8(sp)
     8b2:	6105                	addi	sp,sp,32
     8b4:	8082                	ret

00000000000008b6 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     8b6:	7179                	addi	sp,sp,-48
     8b8:	f406                	sd	ra,40(sp)
     8ba:	f022                	sd	s0,32(sp)
     8bc:	ec26                	sd	s1,24(sp)
     8be:	e84a                	sd	s2,16(sp)
     8c0:	e44e                	sd	s3,8(sp)
     8c2:	1800                	addi	s0,sp,48
     8c4:	84aa                	mv	s1,a0
     8c6:	89b2                	mv	s3,a2
     8c8:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     8ca:	09800513          	li	a0,152
     8ce:	00001097          	auipc	ra,0x1
     8d2:	892080e7          	jalr	-1902(ra) # 1160 <malloc>
     8d6:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     8d8:	478d                	li	a5,3
     8da:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     8dc:	609c                	ld	a5,0(s1)
     8de:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
     8e2:	609c                	ld	a5,0(s1)
     8e4:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
     8e8:	6098                	ld	a4,0(s1)
     8ea:	00001797          	auipc	a5,0x1
     8ee:	71678793          	addi	a5,a5,1814 # 2000 <next_tid>
     8f2:	4394                	lw	a3,0(a5)
     8f4:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
     8f8:	4398                	lw	a4,0(a5)
     8fa:	2705                	addiw	a4,a4,1
     8fc:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
     8fe:	6505                	lui	a0,0x1
     900:	00001097          	auipc	ra,0x1
     904:	860080e7          	jalr	-1952(ra) # 1160 <malloc>
     908:	609c                	ld	a5,0(s1)
     90a:	6705                	lui	a4,0x1
     90c:	953a                	add	a0,a0,a4
     90e:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
     910:	609c                	ld	a5,0(s1)
     912:	00000717          	auipc	a4,0x0
     916:	f7270713          	addi	a4,a4,-142 # 884 <thread_wrapper>
     91a:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
     91c:	00001717          	auipc	a4,0x1
     920:	72c70713          	addi	a4,a4,1836 # 2048 <threads>
     924:	4781                	li	a5,0
     926:	4641                	li	a2,16
        if (threads[i] == NULL) {
     928:	6314                	ld	a3,0(a4)
     92a:	ce81                	beqz	a3,942 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
     92c:	2785                	addiw	a5,a5,1
     92e:	0721                	addi	a4,a4,8
     930:	fec79ce3          	bne	a5,a2,928 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
     934:	70a2                	ld	ra,40(sp)
     936:	7402                	ld	s0,32(sp)
     938:	64e2                	ld	s1,24(sp)
     93a:	6942                	ld	s2,16(sp)
     93c:	69a2                	ld	s3,8(sp)
     93e:	6145                	addi	sp,sp,48
     940:	8082                	ret
            threads[i] = *thread;
     942:	6094                	ld	a3,0(s1)
     944:	078e                	slli	a5,a5,0x3
     946:	00001717          	auipc	a4,0x1
     94a:	70270713          	addi	a4,a4,1794 # 2048 <threads>
     94e:	97ba                	add	a5,a5,a4
     950:	e394                	sd	a3,0(a5)
            break;
     952:	b7cd                	j	934 <tcreate+0x7e>

0000000000000954 <tyield>:
    return 0;
}


void tyield()
{
     954:	1141                	addi	sp,sp,-16
     956:	e406                	sd	ra,8(sp)
     958:	e022                	sd	s0,0(sp)
     95a:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
     95c:	00001797          	auipc	a5,0x1
     960:	6bc7b783          	ld	a5,1724(a5) # 2018 <current_thread>
     964:	470d                	li	a4,3
     966:	dfb8                	sw	a4,120(a5)
    tsched();
     968:	00000097          	auipc	ra,0x0
     96c:	e9a080e7          	jalr	-358(ra) # 802 <tsched>
}
     970:	60a2                	ld	ra,8(sp)
     972:	6402                	ld	s0,0(sp)
     974:	0141                	addi	sp,sp,16
     976:	8082                	ret

0000000000000978 <tjoin>:
{
     978:	1101                	addi	sp,sp,-32
     97a:	ec06                	sd	ra,24(sp)
     97c:	e822                	sd	s0,16(sp)
     97e:	e426                	sd	s1,8(sp)
     980:	e04a                	sd	s2,0(sp)
     982:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
     984:	00001797          	auipc	a5,0x1
     988:	6c478793          	addi	a5,a5,1732 # 2048 <threads>
     98c:	00001697          	auipc	a3,0x1
     990:	73c68693          	addi	a3,a3,1852 # 20c8 <base>
     994:	a021                	j	99c <tjoin+0x24>
     996:	07a1                	addi	a5,a5,8
     998:	02d78b63          	beq	a5,a3,9ce <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
     99c:	6384                	ld	s1,0(a5)
     99e:	dce5                	beqz	s1,996 <tjoin+0x1e>
     9a0:	0004c703          	lbu	a4,0(s1)
     9a4:	fea719e3          	bne	a4,a0,996 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
     9a8:	5cb8                	lw	a4,120(s1)
     9aa:	4799                	li	a5,6
     9ac:	4919                	li	s2,6
     9ae:	02f70263          	beq	a4,a5,9d2 <tjoin+0x5a>
        tyield();
     9b2:	00000097          	auipc	ra,0x0
     9b6:	fa2080e7          	jalr	-94(ra) # 954 <tyield>
    while (target_thread->state != EXITED) {
     9ba:	5cbc                	lw	a5,120(s1)
     9bc:	ff279be3          	bne	a5,s2,9b2 <tjoin+0x3a>
    return 0;
     9c0:	4501                	li	a0,0
}
     9c2:	60e2                	ld	ra,24(sp)
     9c4:	6442                	ld	s0,16(sp)
     9c6:	64a2                	ld	s1,8(sp)
     9c8:	6902                	ld	s2,0(sp)
     9ca:	6105                	addi	sp,sp,32
     9cc:	8082                	ret
        return -1;
     9ce:	557d                	li	a0,-1
     9d0:	bfcd                	j	9c2 <tjoin+0x4a>
    return 0;
     9d2:	4501                	li	a0,0
     9d4:	b7fd                	j	9c2 <tjoin+0x4a>

00000000000009d6 <twhoami>:

uint8 twhoami()
{
     9d6:	1141                	addi	sp,sp,-16
     9d8:	e422                	sd	s0,8(sp)
     9da:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
     9dc:	00001797          	auipc	a5,0x1
     9e0:	63c7b783          	ld	a5,1596(a5) # 2018 <current_thread>
     9e4:	0007c503          	lbu	a0,0(a5)
     9e8:	6422                	ld	s0,8(sp)
     9ea:	0141                	addi	sp,sp,16
     9ec:	8082                	ret

00000000000009ee <tswtch>:
     9ee:	00153023          	sd	ra,0(a0) # 1000 <vprintf+0x152>
     9f2:	00253423          	sd	sp,8(a0)
     9f6:	e900                	sd	s0,16(a0)
     9f8:	ed04                	sd	s1,24(a0)
     9fa:	03253023          	sd	s2,32(a0)
     9fe:	03353423          	sd	s3,40(a0)
     a02:	03453823          	sd	s4,48(a0)
     a06:	03553c23          	sd	s5,56(a0)
     a0a:	05653023          	sd	s6,64(a0)
     a0e:	05753423          	sd	s7,72(a0)
     a12:	05853823          	sd	s8,80(a0)
     a16:	05953c23          	sd	s9,88(a0)
     a1a:	07a53023          	sd	s10,96(a0)
     a1e:	07b53423          	sd	s11,104(a0)
     a22:	0005b083          	ld	ra,0(a1)
     a26:	0085b103          	ld	sp,8(a1)
     a2a:	6980                	ld	s0,16(a1)
     a2c:	6d84                	ld	s1,24(a1)
     a2e:	0205b903          	ld	s2,32(a1)
     a32:	0285b983          	ld	s3,40(a1)
     a36:	0305ba03          	ld	s4,48(a1)
     a3a:	0385ba83          	ld	s5,56(a1)
     a3e:	0405bb03          	ld	s6,64(a1)
     a42:	0485bb83          	ld	s7,72(a1)
     a46:	0505bc03          	ld	s8,80(a1)
     a4a:	0585bc83          	ld	s9,88(a1)
     a4e:	0605bd03          	ld	s10,96(a1)
     a52:	0685bd83          	ld	s11,104(a1)
     a56:	8082                	ret

0000000000000a58 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     a58:	1101                	addi	sp,sp,-32
     a5a:	ec06                	sd	ra,24(sp)
     a5c:	e822                	sd	s0,16(sp)
     a5e:	e426                	sd	s1,8(sp)
     a60:	e04a                	sd	s2,0(sp)
     a62:	1000                	addi	s0,sp,32
     a64:	84aa                	mv	s1,a0
     a66:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     a68:	09800513          	li	a0,152
     a6c:	00000097          	auipc	ra,0x0
     a70:	6f4080e7          	jalr	1780(ra) # 1160 <malloc>

    main_thread->tid = 1;
     a74:	4785                	li	a5,1
     a76:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
     a7a:	4791                	li	a5,4
     a7c:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
     a7e:	00001797          	auipc	a5,0x1
     a82:	58a7bd23          	sd	a0,1434(a5) # 2018 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
     a86:	00001797          	auipc	a5,0x1
     a8a:	5c278793          	addi	a5,a5,1474 # 2048 <threads>
     a8e:	00001717          	auipc	a4,0x1
     a92:	63a70713          	addi	a4,a4,1594 # 20c8 <base>
        threads[i] = NULL;
     a96:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
     a9a:	07a1                	addi	a5,a5,8
     a9c:	fee79de3          	bne	a5,a4,a96 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
     aa0:	00001797          	auipc	a5,0x1
     aa4:	5aa7b423          	sd	a0,1448(a5) # 2048 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     aa8:	85ca                	mv	a1,s2
     aaa:	8526                	mv	a0,s1
     aac:	00000097          	auipc	ra,0x0
     ab0:	b94080e7          	jalr	-1132(ra) # 640 <main>
    //tsched();

    exit(res);
     ab4:	00000097          	auipc	ra,0x0
     ab8:	274080e7          	jalr	628(ra) # d28 <exit>

0000000000000abc <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     abc:	1141                	addi	sp,sp,-16
     abe:	e422                	sd	s0,8(sp)
     ac0:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
     ac2:	87aa                	mv	a5,a0
     ac4:	0585                	addi	a1,a1,1
     ac6:	0785                	addi	a5,a5,1
     ac8:	fff5c703          	lbu	a4,-1(a1)
     acc:	fee78fa3          	sb	a4,-1(a5)
     ad0:	fb75                	bnez	a4,ac4 <strcpy+0x8>
        ;
    return os;
}
     ad2:	6422                	ld	s0,8(sp)
     ad4:	0141                	addi	sp,sp,16
     ad6:	8082                	ret

0000000000000ad8 <strcmp>:

int strcmp(const char *p, const char *q)
{
     ad8:	1141                	addi	sp,sp,-16
     ada:	e422                	sd	s0,8(sp)
     adc:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
     ade:	00054783          	lbu	a5,0(a0)
     ae2:	cb91                	beqz	a5,af6 <strcmp+0x1e>
     ae4:	0005c703          	lbu	a4,0(a1)
     ae8:	00f71763          	bne	a4,a5,af6 <strcmp+0x1e>
        p++, q++;
     aec:	0505                	addi	a0,a0,1
     aee:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
     af0:	00054783          	lbu	a5,0(a0)
     af4:	fbe5                	bnez	a5,ae4 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
     af6:	0005c503          	lbu	a0,0(a1)
}
     afa:	40a7853b          	subw	a0,a5,a0
     afe:	6422                	ld	s0,8(sp)
     b00:	0141                	addi	sp,sp,16
     b02:	8082                	ret

0000000000000b04 <strlen>:

uint strlen(const char *s)
{
     b04:	1141                	addi	sp,sp,-16
     b06:	e422                	sd	s0,8(sp)
     b08:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
     b0a:	00054783          	lbu	a5,0(a0)
     b0e:	cf91                	beqz	a5,b2a <strlen+0x26>
     b10:	0505                	addi	a0,a0,1
     b12:	87aa                	mv	a5,a0
     b14:	86be                	mv	a3,a5
     b16:	0785                	addi	a5,a5,1
     b18:	fff7c703          	lbu	a4,-1(a5)
     b1c:	ff65                	bnez	a4,b14 <strlen+0x10>
     b1e:	40a6853b          	subw	a0,a3,a0
     b22:	2505                	addiw	a0,a0,1
        ;
    return n;
}
     b24:	6422                	ld	s0,8(sp)
     b26:	0141                	addi	sp,sp,16
     b28:	8082                	ret
    for (n = 0; s[n]; n++)
     b2a:	4501                	li	a0,0
     b2c:	bfe5                	j	b24 <strlen+0x20>

0000000000000b2e <memset>:

void *
memset(void *dst, int c, uint n)
{
     b2e:	1141                	addi	sp,sp,-16
     b30:	e422                	sd	s0,8(sp)
     b32:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
     b34:	ca19                	beqz	a2,b4a <memset+0x1c>
     b36:	87aa                	mv	a5,a0
     b38:	1602                	slli	a2,a2,0x20
     b3a:	9201                	srli	a2,a2,0x20
     b3c:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
     b40:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
     b44:	0785                	addi	a5,a5,1
     b46:	fee79de3          	bne	a5,a4,b40 <memset+0x12>
    }
    return dst;
}
     b4a:	6422                	ld	s0,8(sp)
     b4c:	0141                	addi	sp,sp,16
     b4e:	8082                	ret

0000000000000b50 <strchr>:

char *
strchr(const char *s, char c)
{
     b50:	1141                	addi	sp,sp,-16
     b52:	e422                	sd	s0,8(sp)
     b54:	0800                	addi	s0,sp,16
    for (; *s; s++)
     b56:	00054783          	lbu	a5,0(a0)
     b5a:	cb99                	beqz	a5,b70 <strchr+0x20>
        if (*s == c)
     b5c:	00f58763          	beq	a1,a5,b6a <strchr+0x1a>
    for (; *s; s++)
     b60:	0505                	addi	a0,a0,1
     b62:	00054783          	lbu	a5,0(a0)
     b66:	fbfd                	bnez	a5,b5c <strchr+0xc>
            return (char *)s;
    return 0;
     b68:	4501                	li	a0,0
}
     b6a:	6422                	ld	s0,8(sp)
     b6c:	0141                	addi	sp,sp,16
     b6e:	8082                	ret
    return 0;
     b70:	4501                	li	a0,0
     b72:	bfe5                	j	b6a <strchr+0x1a>

0000000000000b74 <gets>:

char *
gets(char *buf, int max)
{
     b74:	711d                	addi	sp,sp,-96
     b76:	ec86                	sd	ra,88(sp)
     b78:	e8a2                	sd	s0,80(sp)
     b7a:	e4a6                	sd	s1,72(sp)
     b7c:	e0ca                	sd	s2,64(sp)
     b7e:	fc4e                	sd	s3,56(sp)
     b80:	f852                	sd	s4,48(sp)
     b82:	f456                	sd	s5,40(sp)
     b84:	f05a                	sd	s6,32(sp)
     b86:	ec5e                	sd	s7,24(sp)
     b88:	1080                	addi	s0,sp,96
     b8a:	8baa                	mv	s7,a0
     b8c:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
     b8e:	892a                	mv	s2,a0
     b90:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
     b92:	4aa9                	li	s5,10
     b94:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
     b96:	89a6                	mv	s3,s1
     b98:	2485                	addiw	s1,s1,1
     b9a:	0344d863          	bge	s1,s4,bca <gets+0x56>
        cc = read(0, &c, 1);
     b9e:	4605                	li	a2,1
     ba0:	faf40593          	addi	a1,s0,-81
     ba4:	4501                	li	a0,0
     ba6:	00000097          	auipc	ra,0x0
     baa:	19a080e7          	jalr	410(ra) # d40 <read>
        if (cc < 1)
     bae:	00a05e63          	blez	a0,bca <gets+0x56>
        buf[i++] = c;
     bb2:	faf44783          	lbu	a5,-81(s0)
     bb6:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
     bba:	01578763          	beq	a5,s5,bc8 <gets+0x54>
     bbe:	0905                	addi	s2,s2,1
     bc0:	fd679be3          	bne	a5,s6,b96 <gets+0x22>
    for (i = 0; i + 1 < max;)
     bc4:	89a6                	mv	s3,s1
     bc6:	a011                	j	bca <gets+0x56>
     bc8:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
     bca:	99de                	add	s3,s3,s7
     bcc:	00098023          	sb	zero,0(s3)
    return buf;
}
     bd0:	855e                	mv	a0,s7
     bd2:	60e6                	ld	ra,88(sp)
     bd4:	6446                	ld	s0,80(sp)
     bd6:	64a6                	ld	s1,72(sp)
     bd8:	6906                	ld	s2,64(sp)
     bda:	79e2                	ld	s3,56(sp)
     bdc:	7a42                	ld	s4,48(sp)
     bde:	7aa2                	ld	s5,40(sp)
     be0:	7b02                	ld	s6,32(sp)
     be2:	6be2                	ld	s7,24(sp)
     be4:	6125                	addi	sp,sp,96
     be6:	8082                	ret

0000000000000be8 <stat>:

int stat(const char *n, struct stat *st)
{
     be8:	1101                	addi	sp,sp,-32
     bea:	ec06                	sd	ra,24(sp)
     bec:	e822                	sd	s0,16(sp)
     bee:	e426                	sd	s1,8(sp)
     bf0:	e04a                	sd	s2,0(sp)
     bf2:	1000                	addi	s0,sp,32
     bf4:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     bf6:	4581                	li	a1,0
     bf8:	00000097          	auipc	ra,0x0
     bfc:	170080e7          	jalr	368(ra) # d68 <open>
    if (fd < 0)
     c00:	02054563          	bltz	a0,c2a <stat+0x42>
     c04:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
     c06:	85ca                	mv	a1,s2
     c08:	00000097          	auipc	ra,0x0
     c0c:	178080e7          	jalr	376(ra) # d80 <fstat>
     c10:	892a                	mv	s2,a0
    close(fd);
     c12:	8526                	mv	a0,s1
     c14:	00000097          	auipc	ra,0x0
     c18:	13c080e7          	jalr	316(ra) # d50 <close>
    return r;
}
     c1c:	854a                	mv	a0,s2
     c1e:	60e2                	ld	ra,24(sp)
     c20:	6442                	ld	s0,16(sp)
     c22:	64a2                	ld	s1,8(sp)
     c24:	6902                	ld	s2,0(sp)
     c26:	6105                	addi	sp,sp,32
     c28:	8082                	ret
        return -1;
     c2a:	597d                	li	s2,-1
     c2c:	bfc5                	j	c1c <stat+0x34>

0000000000000c2e <atoi>:

int atoi(const char *s)
{
     c2e:	1141                	addi	sp,sp,-16
     c30:	e422                	sd	s0,8(sp)
     c32:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
     c34:	00054683          	lbu	a3,0(a0)
     c38:	fd06879b          	addiw	a5,a3,-48
     c3c:	0ff7f793          	zext.b	a5,a5
     c40:	4625                	li	a2,9
     c42:	02f66863          	bltu	a2,a5,c72 <atoi+0x44>
     c46:	872a                	mv	a4,a0
    n = 0;
     c48:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
     c4a:	0705                	addi	a4,a4,1
     c4c:	0025179b          	slliw	a5,a0,0x2
     c50:	9fa9                	addw	a5,a5,a0
     c52:	0017979b          	slliw	a5,a5,0x1
     c56:	9fb5                	addw	a5,a5,a3
     c58:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
     c5c:	00074683          	lbu	a3,0(a4)
     c60:	fd06879b          	addiw	a5,a3,-48
     c64:	0ff7f793          	zext.b	a5,a5
     c68:	fef671e3          	bgeu	a2,a5,c4a <atoi+0x1c>
    return n;
}
     c6c:	6422                	ld	s0,8(sp)
     c6e:	0141                	addi	sp,sp,16
     c70:	8082                	ret
    n = 0;
     c72:	4501                	li	a0,0
     c74:	bfe5                	j	c6c <atoi+0x3e>

0000000000000c76 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
     c76:	1141                	addi	sp,sp,-16
     c78:	e422                	sd	s0,8(sp)
     c7a:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
     c7c:	02b57463          	bgeu	a0,a1,ca4 <memmove+0x2e>
    {
        while (n-- > 0)
     c80:	00c05f63          	blez	a2,c9e <memmove+0x28>
     c84:	1602                	slli	a2,a2,0x20
     c86:	9201                	srli	a2,a2,0x20
     c88:	00c507b3          	add	a5,a0,a2
    dst = vdst;
     c8c:	872a                	mv	a4,a0
            *dst++ = *src++;
     c8e:	0585                	addi	a1,a1,1
     c90:	0705                	addi	a4,a4,1
     c92:	fff5c683          	lbu	a3,-1(a1)
     c96:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
     c9a:	fee79ae3          	bne	a5,a4,c8e <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
     c9e:	6422                	ld	s0,8(sp)
     ca0:	0141                	addi	sp,sp,16
     ca2:	8082                	ret
        dst += n;
     ca4:	00c50733          	add	a4,a0,a2
        src += n;
     ca8:	95b2                	add	a1,a1,a2
        while (n-- > 0)
     caa:	fec05ae3          	blez	a2,c9e <memmove+0x28>
     cae:	fff6079b          	addiw	a5,a2,-1
     cb2:	1782                	slli	a5,a5,0x20
     cb4:	9381                	srli	a5,a5,0x20
     cb6:	fff7c793          	not	a5,a5
     cba:	97ba                	add	a5,a5,a4
            *--dst = *--src;
     cbc:	15fd                	addi	a1,a1,-1
     cbe:	177d                	addi	a4,a4,-1
     cc0:	0005c683          	lbu	a3,0(a1)
     cc4:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
     cc8:	fee79ae3          	bne	a5,a4,cbc <memmove+0x46>
     ccc:	bfc9                	j	c9e <memmove+0x28>

0000000000000cce <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
     cce:	1141                	addi	sp,sp,-16
     cd0:	e422                	sd	s0,8(sp)
     cd2:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
     cd4:	ca05                	beqz	a2,d04 <memcmp+0x36>
     cd6:	fff6069b          	addiw	a3,a2,-1
     cda:	1682                	slli	a3,a3,0x20
     cdc:	9281                	srli	a3,a3,0x20
     cde:	0685                	addi	a3,a3,1
     ce0:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
     ce2:	00054783          	lbu	a5,0(a0)
     ce6:	0005c703          	lbu	a4,0(a1)
     cea:	00e79863          	bne	a5,a4,cfa <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
     cee:	0505                	addi	a0,a0,1
        p2++;
     cf0:	0585                	addi	a1,a1,1
    while (n-- > 0)
     cf2:	fed518e3          	bne	a0,a3,ce2 <memcmp+0x14>
    }
    return 0;
     cf6:	4501                	li	a0,0
     cf8:	a019                	j	cfe <memcmp+0x30>
            return *p1 - *p2;
     cfa:	40e7853b          	subw	a0,a5,a4
}
     cfe:	6422                	ld	s0,8(sp)
     d00:	0141                	addi	sp,sp,16
     d02:	8082                	ret
    return 0;
     d04:	4501                	li	a0,0
     d06:	bfe5                	j	cfe <memcmp+0x30>

0000000000000d08 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     d08:	1141                	addi	sp,sp,-16
     d0a:	e406                	sd	ra,8(sp)
     d0c:	e022                	sd	s0,0(sp)
     d0e:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
     d10:	00000097          	auipc	ra,0x0
     d14:	f66080e7          	jalr	-154(ra) # c76 <memmove>
}
     d18:	60a2                	ld	ra,8(sp)
     d1a:	6402                	ld	s0,0(sp)
     d1c:	0141                	addi	sp,sp,16
     d1e:	8082                	ret

0000000000000d20 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     d20:	4885                	li	a7,1
 ecall
     d22:	00000073          	ecall
 ret
     d26:	8082                	ret

0000000000000d28 <exit>:
.global exit
exit:
 li a7, SYS_exit
     d28:	4889                	li	a7,2
 ecall
     d2a:	00000073          	ecall
 ret
     d2e:	8082                	ret

0000000000000d30 <wait>:
.global wait
wait:
 li a7, SYS_wait
     d30:	488d                	li	a7,3
 ecall
     d32:	00000073          	ecall
 ret
     d36:	8082                	ret

0000000000000d38 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     d38:	4891                	li	a7,4
 ecall
     d3a:	00000073          	ecall
 ret
     d3e:	8082                	ret

0000000000000d40 <read>:
.global read
read:
 li a7, SYS_read
     d40:	4895                	li	a7,5
 ecall
     d42:	00000073          	ecall
 ret
     d46:	8082                	ret

0000000000000d48 <write>:
.global write
write:
 li a7, SYS_write
     d48:	48c1                	li	a7,16
 ecall
     d4a:	00000073          	ecall
 ret
     d4e:	8082                	ret

0000000000000d50 <close>:
.global close
close:
 li a7, SYS_close
     d50:	48d5                	li	a7,21
 ecall
     d52:	00000073          	ecall
 ret
     d56:	8082                	ret

0000000000000d58 <kill>:
.global kill
kill:
 li a7, SYS_kill
     d58:	4899                	li	a7,6
 ecall
     d5a:	00000073          	ecall
 ret
     d5e:	8082                	ret

0000000000000d60 <exec>:
.global exec
exec:
 li a7, SYS_exec
     d60:	489d                	li	a7,7
 ecall
     d62:	00000073          	ecall
 ret
     d66:	8082                	ret

0000000000000d68 <open>:
.global open
open:
 li a7, SYS_open
     d68:	48bd                	li	a7,15
 ecall
     d6a:	00000073          	ecall
 ret
     d6e:	8082                	ret

0000000000000d70 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     d70:	48c5                	li	a7,17
 ecall
     d72:	00000073          	ecall
 ret
     d76:	8082                	ret

0000000000000d78 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     d78:	48c9                	li	a7,18
 ecall
     d7a:	00000073          	ecall
 ret
     d7e:	8082                	ret

0000000000000d80 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     d80:	48a1                	li	a7,8
 ecall
     d82:	00000073          	ecall
 ret
     d86:	8082                	ret

0000000000000d88 <link>:
.global link
link:
 li a7, SYS_link
     d88:	48cd                	li	a7,19
 ecall
     d8a:	00000073          	ecall
 ret
     d8e:	8082                	ret

0000000000000d90 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     d90:	48d1                	li	a7,20
 ecall
     d92:	00000073          	ecall
 ret
     d96:	8082                	ret

0000000000000d98 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     d98:	48a5                	li	a7,9
 ecall
     d9a:	00000073          	ecall
 ret
     d9e:	8082                	ret

0000000000000da0 <dup>:
.global dup
dup:
 li a7, SYS_dup
     da0:	48a9                	li	a7,10
 ecall
     da2:	00000073          	ecall
 ret
     da6:	8082                	ret

0000000000000da8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     da8:	48ad                	li	a7,11
 ecall
     daa:	00000073          	ecall
 ret
     dae:	8082                	ret

0000000000000db0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     db0:	48b1                	li	a7,12
 ecall
     db2:	00000073          	ecall
 ret
     db6:	8082                	ret

0000000000000db8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     db8:	48b5                	li	a7,13
 ecall
     dba:	00000073          	ecall
 ret
     dbe:	8082                	ret

0000000000000dc0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     dc0:	48b9                	li	a7,14
 ecall
     dc2:	00000073          	ecall
 ret
     dc6:	8082                	ret

0000000000000dc8 <ps>:
.global ps
ps:
 li a7, SYS_ps
     dc8:	48d9                	li	a7,22
 ecall
     dca:	00000073          	ecall
 ret
     dce:	8082                	ret

0000000000000dd0 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
     dd0:	48dd                	li	a7,23
 ecall
     dd2:	00000073          	ecall
 ret
     dd6:	8082                	ret

0000000000000dd8 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
     dd8:	48e1                	li	a7,24
 ecall
     dda:	00000073          	ecall
 ret
     dde:	8082                	ret

0000000000000de0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     de0:	1101                	addi	sp,sp,-32
     de2:	ec06                	sd	ra,24(sp)
     de4:	e822                	sd	s0,16(sp)
     de6:	1000                	addi	s0,sp,32
     de8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     dec:	4605                	li	a2,1
     dee:	fef40593          	addi	a1,s0,-17
     df2:	00000097          	auipc	ra,0x0
     df6:	f56080e7          	jalr	-170(ra) # d48 <write>
}
     dfa:	60e2                	ld	ra,24(sp)
     dfc:	6442                	ld	s0,16(sp)
     dfe:	6105                	addi	sp,sp,32
     e00:	8082                	ret

0000000000000e02 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     e02:	7139                	addi	sp,sp,-64
     e04:	fc06                	sd	ra,56(sp)
     e06:	f822                	sd	s0,48(sp)
     e08:	f426                	sd	s1,40(sp)
     e0a:	f04a                	sd	s2,32(sp)
     e0c:	ec4e                	sd	s3,24(sp)
     e0e:	0080                	addi	s0,sp,64
     e10:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e12:	c299                	beqz	a3,e18 <printint+0x16>
     e14:	0805c963          	bltz	a1,ea6 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     e18:	2581                	sext.w	a1,a1
  neg = 0;
     e1a:	4881                	li	a7,0
     e1c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     e20:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     e22:	2601                	sext.w	a2,a2
     e24:	00000517          	auipc	a0,0x0
     e28:	67c50513          	addi	a0,a0,1660 # 14a0 <digits>
     e2c:	883a                	mv	a6,a4
     e2e:	2705                	addiw	a4,a4,1
     e30:	02c5f7bb          	remuw	a5,a1,a2
     e34:	1782                	slli	a5,a5,0x20
     e36:	9381                	srli	a5,a5,0x20
     e38:	97aa                	add	a5,a5,a0
     e3a:	0007c783          	lbu	a5,0(a5)
     e3e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     e42:	0005879b          	sext.w	a5,a1
     e46:	02c5d5bb          	divuw	a1,a1,a2
     e4a:	0685                	addi	a3,a3,1
     e4c:	fec7f0e3          	bgeu	a5,a2,e2c <printint+0x2a>
  if(neg)
     e50:	00088c63          	beqz	a7,e68 <printint+0x66>
    buf[i++] = '-';
     e54:	fd070793          	addi	a5,a4,-48
     e58:	00878733          	add	a4,a5,s0
     e5c:	02d00793          	li	a5,45
     e60:	fef70823          	sb	a5,-16(a4)
     e64:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     e68:	02e05863          	blez	a4,e98 <printint+0x96>
     e6c:	fc040793          	addi	a5,s0,-64
     e70:	00e78933          	add	s2,a5,a4
     e74:	fff78993          	addi	s3,a5,-1
     e78:	99ba                	add	s3,s3,a4
     e7a:	377d                	addiw	a4,a4,-1
     e7c:	1702                	slli	a4,a4,0x20
     e7e:	9301                	srli	a4,a4,0x20
     e80:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     e84:	fff94583          	lbu	a1,-1(s2)
     e88:	8526                	mv	a0,s1
     e8a:	00000097          	auipc	ra,0x0
     e8e:	f56080e7          	jalr	-170(ra) # de0 <putc>
  while(--i >= 0)
     e92:	197d                	addi	s2,s2,-1
     e94:	ff3918e3          	bne	s2,s3,e84 <printint+0x82>
}
     e98:	70e2                	ld	ra,56(sp)
     e9a:	7442                	ld	s0,48(sp)
     e9c:	74a2                	ld	s1,40(sp)
     e9e:	7902                	ld	s2,32(sp)
     ea0:	69e2                	ld	s3,24(sp)
     ea2:	6121                	addi	sp,sp,64
     ea4:	8082                	ret
    x = -xx;
     ea6:	40b005bb          	negw	a1,a1
    neg = 1;
     eaa:	4885                	li	a7,1
    x = -xx;
     eac:	bf85                	j	e1c <printint+0x1a>

0000000000000eae <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     eae:	715d                	addi	sp,sp,-80
     eb0:	e486                	sd	ra,72(sp)
     eb2:	e0a2                	sd	s0,64(sp)
     eb4:	fc26                	sd	s1,56(sp)
     eb6:	f84a                	sd	s2,48(sp)
     eb8:	f44e                	sd	s3,40(sp)
     eba:	f052                	sd	s4,32(sp)
     ebc:	ec56                	sd	s5,24(sp)
     ebe:	e85a                	sd	s6,16(sp)
     ec0:	e45e                	sd	s7,8(sp)
     ec2:	e062                	sd	s8,0(sp)
     ec4:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     ec6:	0005c903          	lbu	s2,0(a1)
     eca:	18090c63          	beqz	s2,1062 <vprintf+0x1b4>
     ece:	8aaa                	mv	s5,a0
     ed0:	8bb2                	mv	s7,a2
     ed2:	00158493          	addi	s1,a1,1
  state = 0;
     ed6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     ed8:	02500a13          	li	s4,37
     edc:	4b55                	li	s6,21
     ede:	a839                	j	efc <vprintf+0x4e>
        putc(fd, c);
     ee0:	85ca                	mv	a1,s2
     ee2:	8556                	mv	a0,s5
     ee4:	00000097          	auipc	ra,0x0
     ee8:	efc080e7          	jalr	-260(ra) # de0 <putc>
     eec:	a019                	j	ef2 <vprintf+0x44>
    } else if(state == '%'){
     eee:	01498d63          	beq	s3,s4,f08 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
     ef2:	0485                	addi	s1,s1,1
     ef4:	fff4c903          	lbu	s2,-1(s1)
     ef8:	16090563          	beqz	s2,1062 <vprintf+0x1b4>
    if(state == 0){
     efc:	fe0999e3          	bnez	s3,eee <vprintf+0x40>
      if(c == '%'){
     f00:	ff4910e3          	bne	s2,s4,ee0 <vprintf+0x32>
        state = '%';
     f04:	89d2                	mv	s3,s4
     f06:	b7f5                	j	ef2 <vprintf+0x44>
      if(c == 'd'){
     f08:	13490263          	beq	s2,s4,102c <vprintf+0x17e>
     f0c:	f9d9079b          	addiw	a5,s2,-99
     f10:	0ff7f793          	zext.b	a5,a5
     f14:	12fb6563          	bltu	s6,a5,103e <vprintf+0x190>
     f18:	f9d9079b          	addiw	a5,s2,-99
     f1c:	0ff7f713          	zext.b	a4,a5
     f20:	10eb6f63          	bltu	s6,a4,103e <vprintf+0x190>
     f24:	00271793          	slli	a5,a4,0x2
     f28:	00000717          	auipc	a4,0x0
     f2c:	52070713          	addi	a4,a4,1312 # 1448 <__FUNCTION__.5+0x70>
     f30:	97ba                	add	a5,a5,a4
     f32:	439c                	lw	a5,0(a5)
     f34:	97ba                	add	a5,a5,a4
     f36:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
     f38:	008b8913          	addi	s2,s7,8
     f3c:	4685                	li	a3,1
     f3e:	4629                	li	a2,10
     f40:	000ba583          	lw	a1,0(s7)
     f44:	8556                	mv	a0,s5
     f46:	00000097          	auipc	ra,0x0
     f4a:	ebc080e7          	jalr	-324(ra) # e02 <printint>
     f4e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f50:	4981                	li	s3,0
     f52:	b745                	j	ef2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f54:	008b8913          	addi	s2,s7,8
     f58:	4681                	li	a3,0
     f5a:	4629                	li	a2,10
     f5c:	000ba583          	lw	a1,0(s7)
     f60:	8556                	mv	a0,s5
     f62:	00000097          	auipc	ra,0x0
     f66:	ea0080e7          	jalr	-352(ra) # e02 <printint>
     f6a:	8bca                	mv	s7,s2
      state = 0;
     f6c:	4981                	li	s3,0
     f6e:	b751                	j	ef2 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
     f70:	008b8913          	addi	s2,s7,8
     f74:	4681                	li	a3,0
     f76:	4641                	li	a2,16
     f78:	000ba583          	lw	a1,0(s7)
     f7c:	8556                	mv	a0,s5
     f7e:	00000097          	auipc	ra,0x0
     f82:	e84080e7          	jalr	-380(ra) # e02 <printint>
     f86:	8bca                	mv	s7,s2
      state = 0;
     f88:	4981                	li	s3,0
     f8a:	b7a5                	j	ef2 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
     f8c:	008b8c13          	addi	s8,s7,8
     f90:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     f94:	03000593          	li	a1,48
     f98:	8556                	mv	a0,s5
     f9a:	00000097          	auipc	ra,0x0
     f9e:	e46080e7          	jalr	-442(ra) # de0 <putc>
  putc(fd, 'x');
     fa2:	07800593          	li	a1,120
     fa6:	8556                	mv	a0,s5
     fa8:	00000097          	auipc	ra,0x0
     fac:	e38080e7          	jalr	-456(ra) # de0 <putc>
     fb0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     fb2:	00000b97          	auipc	s7,0x0
     fb6:	4eeb8b93          	addi	s7,s7,1262 # 14a0 <digits>
     fba:	03c9d793          	srli	a5,s3,0x3c
     fbe:	97de                	add	a5,a5,s7
     fc0:	0007c583          	lbu	a1,0(a5)
     fc4:	8556                	mv	a0,s5
     fc6:	00000097          	auipc	ra,0x0
     fca:	e1a080e7          	jalr	-486(ra) # de0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     fce:	0992                	slli	s3,s3,0x4
     fd0:	397d                	addiw	s2,s2,-1
     fd2:	fe0914e3          	bnez	s2,fba <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
     fd6:	8be2                	mv	s7,s8
      state = 0;
     fd8:	4981                	li	s3,0
     fda:	bf21                	j	ef2 <vprintf+0x44>
        s = va_arg(ap, char*);
     fdc:	008b8993          	addi	s3,s7,8
     fe0:	000bb903          	ld	s2,0(s7)
        if(s == 0)
     fe4:	02090163          	beqz	s2,1006 <vprintf+0x158>
        while(*s != 0){
     fe8:	00094583          	lbu	a1,0(s2)
     fec:	c9a5                	beqz	a1,105c <vprintf+0x1ae>
          putc(fd, *s);
     fee:	8556                	mv	a0,s5
     ff0:	00000097          	auipc	ra,0x0
     ff4:	df0080e7          	jalr	-528(ra) # de0 <putc>
          s++;
     ff8:	0905                	addi	s2,s2,1
        while(*s != 0){
     ffa:	00094583          	lbu	a1,0(s2)
     ffe:	f9e5                	bnez	a1,fee <vprintf+0x140>
        s = va_arg(ap, char*);
    1000:	8bce                	mv	s7,s3
      state = 0;
    1002:	4981                	li	s3,0
    1004:	b5fd                	j	ef2 <vprintf+0x44>
          s = "(null)";
    1006:	00000917          	auipc	s2,0x0
    100a:	43a90913          	addi	s2,s2,1082 # 1440 <__FUNCTION__.5+0x68>
        while(*s != 0){
    100e:	02800593          	li	a1,40
    1012:	bff1                	j	fee <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    1014:	008b8913          	addi	s2,s7,8
    1018:	000bc583          	lbu	a1,0(s7)
    101c:	8556                	mv	a0,s5
    101e:	00000097          	auipc	ra,0x0
    1022:	dc2080e7          	jalr	-574(ra) # de0 <putc>
    1026:	8bca                	mv	s7,s2
      state = 0;
    1028:	4981                	li	s3,0
    102a:	b5e1                	j	ef2 <vprintf+0x44>
        putc(fd, c);
    102c:	02500593          	li	a1,37
    1030:	8556                	mv	a0,s5
    1032:	00000097          	auipc	ra,0x0
    1036:	dae080e7          	jalr	-594(ra) # de0 <putc>
      state = 0;
    103a:	4981                	li	s3,0
    103c:	bd5d                	j	ef2 <vprintf+0x44>
        putc(fd, '%');
    103e:	02500593          	li	a1,37
    1042:	8556                	mv	a0,s5
    1044:	00000097          	auipc	ra,0x0
    1048:	d9c080e7          	jalr	-612(ra) # de0 <putc>
        putc(fd, c);
    104c:	85ca                	mv	a1,s2
    104e:	8556                	mv	a0,s5
    1050:	00000097          	auipc	ra,0x0
    1054:	d90080e7          	jalr	-624(ra) # de0 <putc>
      state = 0;
    1058:	4981                	li	s3,0
    105a:	bd61                	j	ef2 <vprintf+0x44>
        s = va_arg(ap, char*);
    105c:	8bce                	mv	s7,s3
      state = 0;
    105e:	4981                	li	s3,0
    1060:	bd49                	j	ef2 <vprintf+0x44>
    }
  }
}
    1062:	60a6                	ld	ra,72(sp)
    1064:	6406                	ld	s0,64(sp)
    1066:	74e2                	ld	s1,56(sp)
    1068:	7942                	ld	s2,48(sp)
    106a:	79a2                	ld	s3,40(sp)
    106c:	7a02                	ld	s4,32(sp)
    106e:	6ae2                	ld	s5,24(sp)
    1070:	6b42                	ld	s6,16(sp)
    1072:	6ba2                	ld	s7,8(sp)
    1074:	6c02                	ld	s8,0(sp)
    1076:	6161                	addi	sp,sp,80
    1078:	8082                	ret

000000000000107a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    107a:	715d                	addi	sp,sp,-80
    107c:	ec06                	sd	ra,24(sp)
    107e:	e822                	sd	s0,16(sp)
    1080:	1000                	addi	s0,sp,32
    1082:	e010                	sd	a2,0(s0)
    1084:	e414                	sd	a3,8(s0)
    1086:	e818                	sd	a4,16(s0)
    1088:	ec1c                	sd	a5,24(s0)
    108a:	03043023          	sd	a6,32(s0)
    108e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1092:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1096:	8622                	mv	a2,s0
    1098:	00000097          	auipc	ra,0x0
    109c:	e16080e7          	jalr	-490(ra) # eae <vprintf>
}
    10a0:	60e2                	ld	ra,24(sp)
    10a2:	6442                	ld	s0,16(sp)
    10a4:	6161                	addi	sp,sp,80
    10a6:	8082                	ret

00000000000010a8 <printf>:

void
printf(const char *fmt, ...)
{
    10a8:	711d                	addi	sp,sp,-96
    10aa:	ec06                	sd	ra,24(sp)
    10ac:	e822                	sd	s0,16(sp)
    10ae:	1000                	addi	s0,sp,32
    10b0:	e40c                	sd	a1,8(s0)
    10b2:	e810                	sd	a2,16(s0)
    10b4:	ec14                	sd	a3,24(s0)
    10b6:	f018                	sd	a4,32(s0)
    10b8:	f41c                	sd	a5,40(s0)
    10ba:	03043823          	sd	a6,48(s0)
    10be:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    10c2:	00840613          	addi	a2,s0,8
    10c6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    10ca:	85aa                	mv	a1,a0
    10cc:	4505                	li	a0,1
    10ce:	00000097          	auipc	ra,0x0
    10d2:	de0080e7          	jalr	-544(ra) # eae <vprintf>
}
    10d6:	60e2                	ld	ra,24(sp)
    10d8:	6442                	ld	s0,16(sp)
    10da:	6125                	addi	sp,sp,96
    10dc:	8082                	ret

00000000000010de <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    10de:	1141                	addi	sp,sp,-16
    10e0:	e422                	sd	s0,8(sp)
    10e2:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    10e4:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10e8:	00001797          	auipc	a5,0x1
    10ec:	f387b783          	ld	a5,-200(a5) # 2020 <freep>
    10f0:	a02d                	j	111a <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    10f2:	4618                	lw	a4,8(a2)
    10f4:	9f2d                	addw	a4,a4,a1
    10f6:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    10fa:	6398                	ld	a4,0(a5)
    10fc:	6310                	ld	a2,0(a4)
    10fe:	a83d                	j	113c <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    1100:	ff852703          	lw	a4,-8(a0)
    1104:	9f31                	addw	a4,a4,a2
    1106:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    1108:	ff053683          	ld	a3,-16(a0)
    110c:	a091                	j	1150 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    110e:	6398                	ld	a4,0(a5)
    1110:	00e7e463          	bltu	a5,a4,1118 <free+0x3a>
    1114:	00e6ea63          	bltu	a3,a4,1128 <free+0x4a>
{
    1118:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    111a:	fed7fae3          	bgeu	a5,a3,110e <free+0x30>
    111e:	6398                	ld	a4,0(a5)
    1120:	00e6e463          	bltu	a3,a4,1128 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1124:	fee7eae3          	bltu	a5,a4,1118 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    1128:	ff852583          	lw	a1,-8(a0)
    112c:	6390                	ld	a2,0(a5)
    112e:	02059813          	slli	a6,a1,0x20
    1132:	01c85713          	srli	a4,a6,0x1c
    1136:	9736                	add	a4,a4,a3
    1138:	fae60de3          	beq	a2,a4,10f2 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    113c:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    1140:	4790                	lw	a2,8(a5)
    1142:	02061593          	slli	a1,a2,0x20
    1146:	01c5d713          	srli	a4,a1,0x1c
    114a:	973e                	add	a4,a4,a5
    114c:	fae68ae3          	beq	a3,a4,1100 <free+0x22>
        p->s.ptr = bp->s.ptr;
    1150:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    1152:	00001717          	auipc	a4,0x1
    1156:	ecf73723          	sd	a5,-306(a4) # 2020 <freep>
}
    115a:	6422                	ld	s0,8(sp)
    115c:	0141                	addi	sp,sp,16
    115e:	8082                	ret

0000000000001160 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    1160:	7139                	addi	sp,sp,-64
    1162:	fc06                	sd	ra,56(sp)
    1164:	f822                	sd	s0,48(sp)
    1166:	f426                	sd	s1,40(sp)
    1168:	f04a                	sd	s2,32(sp)
    116a:	ec4e                	sd	s3,24(sp)
    116c:	e852                	sd	s4,16(sp)
    116e:	e456                	sd	s5,8(sp)
    1170:	e05a                	sd	s6,0(sp)
    1172:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    1174:	02051493          	slli	s1,a0,0x20
    1178:	9081                	srli	s1,s1,0x20
    117a:	04bd                	addi	s1,s1,15
    117c:	8091                	srli	s1,s1,0x4
    117e:	0014899b          	addiw	s3,s1,1
    1182:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    1184:	00001517          	auipc	a0,0x1
    1188:	e9c53503          	ld	a0,-356(a0) # 2020 <freep>
    118c:	c515                	beqz	a0,11b8 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    118e:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    1190:	4798                	lw	a4,8(a5)
    1192:	02977f63          	bgeu	a4,s1,11d0 <malloc+0x70>
    if (nu < 4096)
    1196:	8a4e                	mv	s4,s3
    1198:	0009871b          	sext.w	a4,s3
    119c:	6685                	lui	a3,0x1
    119e:	00d77363          	bgeu	a4,a3,11a4 <malloc+0x44>
    11a2:	6a05                	lui	s4,0x1
    11a4:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    11a8:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    11ac:	00001917          	auipc	s2,0x1
    11b0:	e7490913          	addi	s2,s2,-396 # 2020 <freep>
    if (p == (char *)-1)
    11b4:	5afd                	li	s5,-1
    11b6:	a895                	j	122a <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    11b8:	00001797          	auipc	a5,0x1
    11bc:	f1078793          	addi	a5,a5,-240 # 20c8 <base>
    11c0:	00001717          	auipc	a4,0x1
    11c4:	e6f73023          	sd	a5,-416(a4) # 2020 <freep>
    11c8:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    11ca:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    11ce:	b7e1                	j	1196 <malloc+0x36>
            if (p->s.size == nunits)
    11d0:	02e48c63          	beq	s1,a4,1208 <malloc+0xa8>
                p->s.size -= nunits;
    11d4:	4137073b          	subw	a4,a4,s3
    11d8:	c798                	sw	a4,8(a5)
                p += p->s.size;
    11da:	02071693          	slli	a3,a4,0x20
    11de:	01c6d713          	srli	a4,a3,0x1c
    11e2:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    11e4:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    11e8:	00001717          	auipc	a4,0x1
    11ec:	e2a73c23          	sd	a0,-456(a4) # 2020 <freep>
            return (void *)(p + 1);
    11f0:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    11f4:	70e2                	ld	ra,56(sp)
    11f6:	7442                	ld	s0,48(sp)
    11f8:	74a2                	ld	s1,40(sp)
    11fa:	7902                	ld	s2,32(sp)
    11fc:	69e2                	ld	s3,24(sp)
    11fe:	6a42                	ld	s4,16(sp)
    1200:	6aa2                	ld	s5,8(sp)
    1202:	6b02                	ld	s6,0(sp)
    1204:	6121                	addi	sp,sp,64
    1206:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    1208:	6398                	ld	a4,0(a5)
    120a:	e118                	sd	a4,0(a0)
    120c:	bff1                	j	11e8 <malloc+0x88>
    hp->s.size = nu;
    120e:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    1212:	0541                	addi	a0,a0,16
    1214:	00000097          	auipc	ra,0x0
    1218:	eca080e7          	jalr	-310(ra) # 10de <free>
    return freep;
    121c:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    1220:	d971                	beqz	a0,11f4 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    1222:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    1224:	4798                	lw	a4,8(a5)
    1226:	fa9775e3          	bgeu	a4,s1,11d0 <malloc+0x70>
        if (p == freep)
    122a:	00093703          	ld	a4,0(s2)
    122e:	853e                	mv	a0,a5
    1230:	fef719e3          	bne	a4,a5,1222 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    1234:	8552                	mv	a0,s4
    1236:	00000097          	auipc	ra,0x0
    123a:	b7a080e7          	jalr	-1158(ra) # db0 <sbrk>
    if (p == (char *)-1)
    123e:	fd5518e3          	bne	a0,s5,120e <malloc+0xae>
                return 0;
    1242:	4501                	li	a0,0
    1244:	bf45                	j	11f4 <malloc+0x94>
