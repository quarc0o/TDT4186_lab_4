
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
       c:	2b850513          	addi	a0,a0,696 # 12c0 <__FUNCTION__.4+0x10>
      10:	00001097          	auipc	ra,0x1
      14:	0dc080e7          	jalr	220(ra) # 10ec <printf>
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
      2e:	a28080e7          	jalr	-1496(ra) # a52 <twhoami>
      32:	0005059b          	sext.w	a1,a0
      36:	00001517          	auipc	a0,0x1
      3a:	29a50513          	addi	a0,a0,666 # 12d0 <__FUNCTION__.4+0x20>
      3e:	00001097          	auipc	ra,0x1
      42:	0ae080e7          	jalr	174(ra) # 10ec <printf>
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
      6c:	9ea080e7          	jalr	-1558(ra) # a52 <twhoami>
      70:	00002497          	auipc	s1,0x2
      74:	fa048493          	addi	s1,s1,-96 # 2010 <shared_state>
      78:	4094                	lw	a3,0(s1)
      7a:	0005061b          	sext.w	a2,a0
      7e:	00001597          	auipc	a1,0x1
      82:	38a58593          	addi	a1,a1,906 # 1408 <__FUNCTION__.6>
      86:	00001517          	auipc	a0,0x1
      8a:	26a50513          	addi	a0,a0,618 # 12f0 <__FUNCTION__.4+0x40>
      8e:	00001097          	auipc	ra,0x1
      92:	05e080e7          	jalr	94(ra) # 10ec <printf>
    if (shared_state == 0)
      96:	409c                	lw	a5,0(s1)
      98:	ebb5                	bnez	a5,10c <race_for_state+0xbc>
        tyield();
      9a:	00001097          	auipc	ra,0x1
      9e:	936080e7          	jalr	-1738(ra) # 9d0 <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
      a2:	00001097          	auipc	ra,0x1
      a6:	9b0080e7          	jalr	-1616(ra) # a52 <twhoami>
      aa:	00001917          	auipc	s2,0x1
      ae:	35e90913          	addi	s2,s2,862 # 1408 <__FUNCTION__.6>
      b2:	4094                	lw	a3,0(s1)
      b4:	0005061b          	sext.w	a2,a0
      b8:	85ca                	mv	a1,s2
      ba:	00001517          	auipc	a0,0x1
      be:	23650513          	addi	a0,a0,566 # 12f0 <__FUNCTION__.4+0x40>
      c2:	00001097          	auipc	ra,0x1
      c6:	02a080e7          	jalr	42(ra) # 10ec <printf>
        shared_state += args.a;
      ca:	409c                	lw	a5,0(s1)
      cc:	014787bb          	addw	a5,a5,s4
      d0:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
      d2:	00001097          	auipc	ra,0x1
      d6:	980080e7          	jalr	-1664(ra) # a52 <twhoami>
      da:	4094                	lw	a3,0(s1)
      dc:	0005061b          	sext.w	a2,a0
      e0:	85ca                	mv	a1,s2
      e2:	00001517          	auipc	a0,0x1
      e6:	20e50513          	addi	a0,a0,526 # 12f0 <__FUNCTION__.4+0x40>
      ea:	00001097          	auipc	ra,0x1
      ee:	002080e7          	jalr	2(ra) # 10ec <printf>
        tyield();
      f2:	00001097          	auipc	ra,0x1
      f6:	8de080e7          	jalr	-1826(ra) # 9d0 <tyield>
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
     110:	8c4080e7          	jalr	-1852(ra) # 9d0 <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     114:	00001097          	auipc	ra,0x1
     118:	93e080e7          	jalr	-1730(ra) # a52 <twhoami>
     11c:	00002497          	auipc	s1,0x2
     120:	ef448493          	addi	s1,s1,-268 # 2010 <shared_state>
     124:	00001917          	auipc	s2,0x1
     128:	2e490913          	addi	s2,s2,740 # 1408 <__FUNCTION__.6>
     12c:	4094                	lw	a3,0(s1)
     12e:	0005061b          	sext.w	a2,a0
     132:	85ca                	mv	a1,s2
     134:	00001517          	auipc	a0,0x1
     138:	1bc50513          	addi	a0,a0,444 # 12f0 <__FUNCTION__.4+0x40>
     13c:	00001097          	auipc	ra,0x1
     140:	fb0080e7          	jalr	-80(ra) # 10ec <printf>
        shared_state += args.b;
     144:	409c                	lw	a5,0(s1)
     146:	013787bb          	addw	a5,a5,s3
     14a:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     14c:	00001097          	auipc	ra,0x1
     150:	906080e7          	jalr	-1786(ra) # a52 <twhoami>
     154:	4094                	lw	a3,0(s1)
     156:	0005061b          	sext.w	a2,a0
     15a:	85ca                	mv	a1,s2
     15c:	00001517          	auipc	a0,0x1
     160:	19450513          	addi	a0,a0,404 # 12f0 <__FUNCTION__.4+0x40>
     164:	00001097          	auipc	ra,0x1
     168:	f88080e7          	jalr	-120(ra) # 10ec <printf>
        tyield();
     16c:	00001097          	auipc	ra,0x1
     170:	864080e7          	jalr	-1948(ra) # 9d0 <tyield>
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
     192:	8c4080e7          	jalr	-1852(ra) # a52 <twhoami>
     196:	00002497          	auipc	s1,0x2
     19a:	e7a48493          	addi	s1,s1,-390 # 2010 <shared_state>
     19e:	4094                	lw	a3,0(s1)
     1a0:	0005061b          	sext.w	a2,a0
     1a4:	00001597          	auipc	a1,0x1
     1a8:	27458593          	addi	a1,a1,628 # 1418 <__FUNCTION__.5>
     1ac:	00001517          	auipc	a0,0x1
     1b0:	14450513          	addi	a0,a0,324 # 12f0 <__FUNCTION__.4+0x40>
     1b4:	00001097          	auipc	ra,0x1
     1b8:	f38080e7          	jalr	-200(ra) # 10ec <printf>
    acquire(&shared_state_lock);
     1bc:	00002517          	auipc	a0,0x2
     1c0:	e7450513          	addi	a0,a0,-396 # 2030 <shared_state_lock>
     1c4:	00000097          	auipc	ra,0x0
     1c8:	56a080e7          	jalr	1386(ra) # 72e <acquire>
    if (shared_state == 0)
     1cc:	409c                	lw	a5,0(s1)
     1ce:	e3d1                	bnez	a5,252 <no_race_for_state+0xdc>
        tyield();
     1d0:	00001097          	auipc	ra,0x1
     1d4:	800080e7          	jalr	-2048(ra) # 9d0 <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     1d8:	00001097          	auipc	ra,0x1
     1dc:	87a080e7          	jalr	-1926(ra) # a52 <twhoami>
     1e0:	00001917          	auipc	s2,0x1
     1e4:	23890913          	addi	s2,s2,568 # 1418 <__FUNCTION__.5>
     1e8:	4094                	lw	a3,0(s1)
     1ea:	0005061b          	sext.w	a2,a0
     1ee:	85ca                	mv	a1,s2
     1f0:	00001517          	auipc	a0,0x1
     1f4:	10050513          	addi	a0,a0,256 # 12f0 <__FUNCTION__.4+0x40>
     1f8:	00001097          	auipc	ra,0x1
     1fc:	ef4080e7          	jalr	-268(ra) # 10ec <printf>
        shared_state += args.a;
     200:	409c                	lw	a5,0(s1)
     202:	014787bb          	addw	a5,a5,s4
     206:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     208:	00001097          	auipc	ra,0x1
     20c:	84a080e7          	jalr	-1974(ra) # a52 <twhoami>
     210:	4094                	lw	a3,0(s1)
     212:	0005061b          	sext.w	a2,a0
     216:	85ca                	mv	a1,s2
     218:	00001517          	auipc	a0,0x1
     21c:	0d850513          	addi	a0,a0,216 # 12f0 <__FUNCTION__.4+0x40>
     220:	00001097          	auipc	ra,0x1
     224:	ecc080e7          	jalr	-308(ra) # 10ec <printf>
        tyield();
     228:	00000097          	auipc	ra,0x0
     22c:	7a8080e7          	jalr	1960(ra) # 9d0 <tyield>
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
     256:	77e080e7          	jalr	1918(ra) # 9d0 <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     25a:	00000097          	auipc	ra,0x0
     25e:	7f8080e7          	jalr	2040(ra) # a52 <twhoami>
     262:	00002497          	auipc	s1,0x2
     266:	dae48493          	addi	s1,s1,-594 # 2010 <shared_state>
     26a:	00001917          	auipc	s2,0x1
     26e:	1ae90913          	addi	s2,s2,430 # 1418 <__FUNCTION__.5>
     272:	4094                	lw	a3,0(s1)
     274:	0005061b          	sext.w	a2,a0
     278:	85ca                	mv	a1,s2
     27a:	00001517          	auipc	a0,0x1
     27e:	07650513          	addi	a0,a0,118 # 12f0 <__FUNCTION__.4+0x40>
     282:	00001097          	auipc	ra,0x1
     286:	e6a080e7          	jalr	-406(ra) # 10ec <printf>
        shared_state += args.b;
     28a:	409c                	lw	a5,0(s1)
     28c:	013787bb          	addw	a5,a5,s3
     290:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     292:	00000097          	auipc	ra,0x0
     296:	7c0080e7          	jalr	1984(ra) # a52 <twhoami>
     29a:	4094                	lw	a3,0(s1)
     29c:	0005061b          	sext.w	a2,a0
     2a0:	85ca                	mv	a1,s2
     2a2:	00001517          	auipc	a0,0x1
     2a6:	04e50513          	addi	a0,a0,78 # 12f0 <__FUNCTION__.4+0x40>
     2aa:	00001097          	auipc	ra,0x1
     2ae:	e42080e7          	jalr	-446(ra) # 10ec <printf>
        tyield();
     2b2:	00000097          	auipc	ra,0x0
     2b6:	71e080e7          	jalr	1822(ra) # 9d0 <tyield>
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
     2d8:	02c50513          	addi	a0,a0,44 # 1300 <__FUNCTION__.4+0x50>
     2dc:	00001097          	auipc	ra,0x1
     2e0:	e10080e7          	jalr	-496(ra) # 10ec <printf>
    int *result = (int *)malloc(sizeof(int));
     2e4:	4511                	li	a0,4
     2e6:	00001097          	auipc	ra,0x1
     2ea:	ebe080e7          	jalr	-322(ra) # 11a4 <malloc>
     2ee:	892a                	mv	s2,a0
    *result = args.a + args.b;
     2f0:	013485bb          	addw	a1,s1,s3
     2f4:	c10c                	sw	a1,0(a0)
    printf("child result: %d\n", *result);
     2f6:	2581                	sext.w	a1,a1
     2f8:	00001517          	auipc	a0,0x1
     2fc:	02050513          	addi	a0,a0,32 # 1318 <__FUNCTION__.4+0x68>
     300:	00001097          	auipc	ra,0x1
     304:	dec080e7          	jalr	-532(ra) # 10ec <printf>
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
     324:	f9058593          	addi	a1,a1,-112 # 12b0 <__FUNCTION__.4>
     328:	00001517          	auipc	a0,0x1
     32c:	00850513          	addi	a0,a0,8 # 1330 <__FUNCTION__.4+0x80>
     330:	00001097          	auipc	ra,0x1
     334:	dbc080e7          	jalr	-580(ra) # 10ec <printf>
    struct thread *t;
    tcreate(&t, 0, &print_hello_world, 0);
     338:	4681                	li	a3,0
     33a:	00000617          	auipc	a2,0x0
     33e:	cc660613          	addi	a2,a2,-826 # 0 <print_hello_world>
     342:	4581                	li	a1,0
     344:	fe840513          	addi	a0,s0,-24
     348:	00000097          	auipc	ra,0x0
     34c:	5ce080e7          	jalr	1486(ra) # 916 <tcreate>
    tyield();
     350:	00000097          	auipc	ra,0x0
     354:	680080e7          	jalr	1664(ra) # 9d0 <tyield>
    printf("[%s exit]\n", __FUNCTION__);
     358:	00001597          	auipc	a1,0x1
     35c:	f5858593          	addi	a1,a1,-168 # 12b0 <__FUNCTION__.4>
     360:	00001517          	auipc	a0,0x1
     364:	fe050513          	addi	a0,a0,-32 # 1340 <__FUNCTION__.4+0x90>
     368:	00001097          	auipc	ra,0x1
     36c:	d84080e7          	jalr	-636(ra) # 10ec <printf>
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
     38c:	f2058593          	addi	a1,a1,-224 # 12a8 <__FUNCTION__.3>
     390:	00001517          	auipc	a0,0x1
     394:	fa050513          	addi	a0,a0,-96 # 1330 <__FUNCTION__.4+0x80>
     398:	00001097          	auipc	ra,0x1
     39c:	d54080e7          	jalr	-684(ra) # 10ec <printf>
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
     3de:	53c080e7          	jalr	1340(ra) # 916 <tcreate>
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
     3f6:	602080e7          	jalr	1538(ra) # 9f4 <tjoin>
    for (int i = 0; i < 8; i++)
     3fa:	04a1                	addi	s1,s1,8
     3fc:	ff3496e3          	bne	s1,s3,3e8 <test2+0x70>
    }
    printf("[%s exit]\n", __FUNCTION__);
     400:	00001597          	auipc	a1,0x1
     404:	ea858593          	addi	a1,a1,-344 # 12a8 <__FUNCTION__.3>
     408:	00001517          	auipc	a0,0x1
     40c:	f3850513          	addi	a0,a0,-200 # 1340 <__FUNCTION__.4+0x90>
     410:	00001097          	auipc	ra,0x1
     414:	cdc080e7          	jalr	-804(ra) # 10ec <printf>
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
     434:	e7058593          	addi	a1,a1,-400 # 12a0 <__FUNCTION__.2>
     438:	00001517          	auipc	a0,0x1
     43c:	ef850513          	addi	a0,a0,-264 # 1330 <__FUNCTION__.4+0x80>
     440:	00001097          	auipc	ra,0x1
     444:	cac080e7          	jalr	-852(ra) # 10ec <printf>
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
     47a:	4a0080e7          	jalr	1184(ra) # 916 <tcreate>
    int result;
    tjoin(t->tid, &result, sizeof(int));
     47e:	4611                	li	a2,4
     480:	fd440593          	addi	a1,s0,-44
     484:	fe843783          	ld	a5,-24(s0)
     488:	0007c503          	lbu	a0,0(a5)
     48c:	00000097          	auipc	ra,0x0
     490:	568080e7          	jalr	1384(ra) # 9f4 <tjoin>
    printf("parent result: %d\n", result);
     494:	fd442583          	lw	a1,-44(s0)
     498:	00001517          	auipc	a0,0x1
     49c:	eb850513          	addi	a0,a0,-328 # 1350 <__FUNCTION__.4+0xa0>
     4a0:	00001097          	auipc	ra,0x1
     4a4:	c4c080e7          	jalr	-948(ra) # 10ec <printf>
    printf("[%s exit]\n", __FUNCTION__);
     4a8:	00001597          	auipc	a1,0x1
     4ac:	df858593          	addi	a1,a1,-520 # 12a0 <__FUNCTION__.2>
     4b0:	00001517          	auipc	a0,0x1
     4b4:	e9050513          	addi	a0,a0,-368 # 1340 <__FUNCTION__.4+0x90>
     4b8:	00001097          	auipc	ra,0x1
     4bc:	c34080e7          	jalr	-972(ra) # 10ec <printf>
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
     4d4:	dc858593          	addi	a1,a1,-568 # 1298 <__FUNCTION__.1>
     4d8:	00001517          	auipc	a0,0x1
     4dc:	e5850513          	addi	a0,a0,-424 # 1330 <__FUNCTION__.4+0x80>
     4e0:	00001097          	auipc	ra,0x1
     4e4:	c0c080e7          	jalr	-1012(ra) # 10ec <printf>
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
     50a:	410080e7          	jalr	1040(ra) # 916 <tcreate>
    tcreate(&tb, 0, &race_for_state, &args);
     50e:	fd840693          	addi	a3,s0,-40
     512:	00000617          	auipc	a2,0x0
     516:	b3e60613          	addi	a2,a2,-1218 # 50 <race_for_state>
     51a:	4581                	li	a1,0
     51c:	fe040513          	addi	a0,s0,-32
     520:	00000097          	auipc	ra,0x0
     524:	3f6080e7          	jalr	1014(ra) # 916 <tcreate>
    tyield();
     528:	00000097          	auipc	ra,0x0
     52c:	4a8080e7          	jalr	1192(ra) # 9d0 <tyield>
    tjoin(ta->tid, 0, 0);
     530:	4601                	li	a2,0
     532:	4581                	li	a1,0
     534:	fe843783          	ld	a5,-24(s0)
     538:	0007c503          	lbu	a0,0(a5)
     53c:	00000097          	auipc	ra,0x0
     540:	4b8080e7          	jalr	1208(ra) # 9f4 <tjoin>
    tjoin(tb->tid, 0, 0);
     544:	4601                	li	a2,0
     546:	4581                	li	a1,0
     548:	fe043783          	ld	a5,-32(s0)
     54c:	0007c503          	lbu	a0,0(a5)
     550:	00000097          	auipc	ra,0x0
     554:	4a4080e7          	jalr	1188(ra) # 9f4 <tjoin>
    printf("[%s exit]\n", __FUNCTION__);
     558:	00001597          	auipc	a1,0x1
     55c:	d4058593          	addi	a1,a1,-704 # 1298 <__FUNCTION__.1>
     560:	00001517          	auipc	a0,0x1
     564:	de050513          	addi	a0,a0,-544 # 1340 <__FUNCTION__.4+0x90>
     568:	00001097          	auipc	ra,0x1
     56c:	b84080e7          	jalr	-1148(ra) # 10ec <printf>
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
     584:	d1058593          	addi	a1,a1,-752 # 1290 <__FUNCTION__.0>
     588:	00001517          	auipc	a0,0x1
     58c:	da850513          	addi	a0,a0,-600 # 1330 <__FUNCTION__.4+0x80>
     590:	00001097          	auipc	ra,0x1
     594:	b5c080e7          	jalr	-1188(ra) # 10ec <printf>
    initlock(&shared_state_lock, "sharedstate lock");
     598:	00001597          	auipc	a1,0x1
     59c:	dd058593          	addi	a1,a1,-560 # 1368 <__FUNCTION__.4+0xb8>
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
     5d2:	348080e7          	jalr	840(ra) # 916 <tcreate>
    tcreate(&tb, 0, &no_race_for_state, &args);
     5d6:	fd840693          	addi	a3,s0,-40
     5da:	00000617          	auipc	a2,0x0
     5de:	b9c60613          	addi	a2,a2,-1124 # 176 <no_race_for_state>
     5e2:	4581                	li	a1,0
     5e4:	fe040513          	addi	a0,s0,-32
     5e8:	00000097          	auipc	ra,0x0
     5ec:	32e080e7          	jalr	814(ra) # 916 <tcreate>
    tyield();
     5f0:	00000097          	auipc	ra,0x0
     5f4:	3e0080e7          	jalr	992(ra) # 9d0 <tyield>
    tjoin(ta->tid, 0, 0);
     5f8:	4601                	li	a2,0
     5fa:	4581                	li	a1,0
     5fc:	fe843783          	ld	a5,-24(s0)
     600:	0007c503          	lbu	a0,0(a5)
     604:	00000097          	auipc	ra,0x0
     608:	3f0080e7          	jalr	1008(ra) # 9f4 <tjoin>
    tjoin(tb->tid, 0, 0);
     60c:	4601                	li	a2,0
     60e:	4581                	li	a1,0
     610:	fe043783          	ld	a5,-32(s0)
     614:	0007c503          	lbu	a0,0(a5)
     618:	00000097          	auipc	ra,0x0
     61c:	3dc080e7          	jalr	988(ra) # 9f4 <tjoin>
    printf("[%s exit]\n", __FUNCTION__);
     620:	00001597          	auipc	a1,0x1
     624:	c7058593          	addi	a1,a1,-912 # 1290 <__FUNCTION__.0>
     628:	00001517          	auipc	a0,0x1
     62c:	d1850513          	addi	a0,a0,-744 # 1340 <__FUNCTION__.4+0x90>
     630:	00001097          	auipc	ra,0x1
     634:	abc080e7          	jalr	-1348(ra) # 10ec <printf>
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
     658:	61e080e7          	jalr	1566(ra) # c72 <atoi>
     65c:	4795                	li	a5,5
     65e:	06a7e763          	bltu	a5,a0,6cc <main+0x8c>
     662:	050a                	slli	a0,a0,0x2
     664:	00001717          	auipc	a4,0x1
     668:	d8c70713          	addi	a4,a4,-628 # 13f0 <__FUNCTION__.4+0x140>
     66c:	953a                	add	a0,a0,a4
     66e:	411c                	lw	a5,0(a0)
     670:	97ba                	add	a5,a5,a4
     672:	8782                	jr	a5
        printf("ttest TEST_ID\n TEST ID\tId of the test to run. ID can be any value from 1 to 5\n");
     674:	00001517          	auipc	a0,0x1
     678:	d0c50513          	addi	a0,a0,-756 # 1380 <__FUNCTION__.4+0xd0>
     67c:	00001097          	auipc	ra,0x1
     680:	a70080e7          	jalr	-1424(ra) # 10ec <printf>
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
     6d2:	d0250513          	addi	a0,a0,-766 # 13d0 <__FUNCTION__.4+0x120>
     6d6:	00001097          	auipc	ra,0x1
     6da:	a16080e7          	jalr	-1514(ra) # 10ec <printf>
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
     716:	340080e7          	jalr	832(ra) # a52 <twhoami>
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
     762:	cd250513          	addi	a0,a0,-814 # 1430 <__FUNCTION__.5+0x18>
     766:	00001097          	auipc	ra,0x1
     76a:	986080e7          	jalr	-1658(ra) # 10ec <printf>
        exit(-1);
     76e:	557d                	li	a0,-1
     770:	00000097          	auipc	ra,0x0
     774:	5fc080e7          	jalr	1532(ra) # d6c <exit>
    {
        // give up the cpu for other threads
        tyield();
     778:	00000097          	auipc	ra,0x0
     77c:	258080e7          	jalr	600(ra) # 9d0 <tyield>
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
     796:	2c0080e7          	jalr	704(ra) # a52 <twhoami>
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
     7da:	1fa080e7          	jalr	506(ra) # 9d0 <tyield>
}
     7de:	60e2                	ld	ra,24(sp)
     7e0:	6442                	ld	s0,16(sp)
     7e2:	64a2                	ld	s1,8(sp)
     7e4:	6105                	addi	sp,sp,32
     7e6:	8082                	ret
        printf("releasing lock we are not holding");
     7e8:	00001517          	auipc	a0,0x1
     7ec:	c7050513          	addi	a0,a0,-912 # 1458 <__FUNCTION__.5+0x40>
     7f0:	00001097          	auipc	ra,0x1
     7f4:	8fc080e7          	jalr	-1796(ra) # 10ec <printf>
        exit(-1);
     7f8:	557d                	li	a0,-1
     7fa:	00000097          	auipc	ra,0x0
     7fe:	572080e7          	jalr	1394(ra) # d6c <exit>

0000000000000802 <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
     802:	1141                	addi	sp,sp,-16
     804:	e406                	sd	ra,8(sp)
     806:	e022                	sd	s0,0(sp)
     808:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     80a:	09800513          	li	a0,152
     80e:	00001097          	auipc	ra,0x1
     812:	996080e7          	jalr	-1642(ra) # 11a4 <malloc>

    main_thread->tid = next_tid;
     816:	00001797          	auipc	a5,0x1
     81a:	7ea78793          	addi	a5,a5,2026 # 2000 <next_tid>
     81e:	4398                	lw	a4,0(a5)
     820:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
     824:	4398                	lw	a4,0(a5)
     826:	2705                	addiw	a4,a4,1
     828:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
     82a:	4791                	li	a5,4
     82c:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
     82e:	00001797          	auipc	a5,0x1
     832:	7ea7b523          	sd	a0,2026(a5) # 2018 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
     836:	00002797          	auipc	a5,0x2
     83a:	81278793          	addi	a5,a5,-2030 # 2048 <threads>
     83e:	00002717          	auipc	a4,0x2
     842:	88a70713          	addi	a4,a4,-1910 # 20c8 <base>
        threads[i] = NULL;
     846:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
     84a:	07a1                	addi	a5,a5,8
     84c:	fee79de3          	bne	a5,a4,846 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
     850:	00001797          	auipc	a5,0x1
     854:	7ea7bc23          	sd	a0,2040(a5) # 2048 <threads>
}
     858:	60a2                	ld	ra,8(sp)
     85a:	6402                	ld	s0,0(sp)
     85c:	0141                	addi	sp,sp,16
     85e:	8082                	ret

0000000000000860 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
     860:	00001517          	auipc	a0,0x1
     864:	7b853503          	ld	a0,1976(a0) # 2018 <current_thread>
     868:	00001717          	auipc	a4,0x1
     86c:	7e070713          	addi	a4,a4,2016 # 2048 <threads>
    for (int i = 0; i < 16; i++) {
     870:	4781                	li	a5,0
     872:	4641                	li	a2,16
        if (threads[i] == current_thread) {
     874:	6314                	ld	a3,0(a4)
     876:	00a68763          	beq	a3,a0,884 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
     87a:	2785                	addiw	a5,a5,1
     87c:	0721                	addi	a4,a4,8
     87e:	fec79be3          	bne	a5,a2,874 <tsched+0x14>
    int current_index = 0;
     882:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
     884:	0017869b          	addiw	a3,a5,1
     888:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     88c:	00001817          	auipc	a6,0x1
     890:	7bc80813          	addi	a6,a6,1980 # 2048 <threads>
     894:	488d                	li	a7,3
     896:	a021                	j	89e <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
     898:	2685                	addiw	a3,a3,1
     89a:	04c68363          	beq	a3,a2,8e0 <tsched+0x80>
        int next_index = (current_index + i) % 16;
     89e:	41f6d71b          	sraiw	a4,a3,0x1f
     8a2:	01c7571b          	srliw	a4,a4,0x1c
     8a6:	00d707bb          	addw	a5,a4,a3
     8aa:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     8ac:	9f99                	subw	a5,a5,a4
     8ae:	078e                	slli	a5,a5,0x3
     8b0:	97c2                	add	a5,a5,a6
     8b2:	638c                	ld	a1,0(a5)
     8b4:	d1f5                	beqz	a1,898 <tsched+0x38>
     8b6:	5dbc                	lw	a5,120(a1)
     8b8:	ff1790e3          	bne	a5,a7,898 <tsched+0x38>
{
     8bc:	1141                	addi	sp,sp,-16
     8be:	e406                	sd	ra,8(sp)
     8c0:	e022                	sd	s0,0(sp)
     8c2:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
     8c4:	00001797          	auipc	a5,0x1
     8c8:	74b7ba23          	sd	a1,1876(a5) # 2018 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
     8cc:	05a1                	addi	a1,a1,8
     8ce:	0521                	addi	a0,a0,8
     8d0:	00000097          	auipc	ra,0x0
     8d4:	19a080e7          	jalr	410(ra) # a6a <tswtch>
        //printf("Thread switch complete\n");
    }
}
     8d8:	60a2                	ld	ra,8(sp)
     8da:	6402                	ld	s0,0(sp)
     8dc:	0141                	addi	sp,sp,16
     8de:	8082                	ret
     8e0:	8082                	ret

00000000000008e2 <thread_wrapper>:
{
     8e2:	1101                	addi	sp,sp,-32
     8e4:	ec06                	sd	ra,24(sp)
     8e6:	e822                	sd	s0,16(sp)
     8e8:	e426                	sd	s1,8(sp)
     8ea:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
     8ec:	00001497          	auipc	s1,0x1
     8f0:	72c48493          	addi	s1,s1,1836 # 2018 <current_thread>
     8f4:	609c                	ld	a5,0(s1)
     8f6:	6b9c                	ld	a5,16(a5)
    func(arg);
     8f8:	6398                	ld	a4,0(a5)
     8fa:	6788                	ld	a0,8(a5)
     8fc:	9702                	jalr	a4
    current_thread->state = EXITED;
     8fe:	609c                	ld	a5,0(s1)
     900:	4719                	li	a4,6
     902:	dfb8                	sw	a4,120(a5)
    tsched();
     904:	00000097          	auipc	ra,0x0
     908:	f5c080e7          	jalr	-164(ra) # 860 <tsched>
}
     90c:	60e2                	ld	ra,24(sp)
     90e:	6442                	ld	s0,16(sp)
     910:	64a2                	ld	s1,8(sp)
     912:	6105                	addi	sp,sp,32
     914:	8082                	ret

0000000000000916 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     916:	7179                	addi	sp,sp,-48
     918:	f406                	sd	ra,40(sp)
     91a:	f022                	sd	s0,32(sp)
     91c:	ec26                	sd	s1,24(sp)
     91e:	e84a                	sd	s2,16(sp)
     920:	e44e                	sd	s3,8(sp)
     922:	1800                	addi	s0,sp,48
     924:	84aa                	mv	s1,a0
     926:	8932                	mv	s2,a2
     928:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     92a:	09800513          	li	a0,152
     92e:	00001097          	auipc	ra,0x1
     932:	876080e7          	jalr	-1930(ra) # 11a4 <malloc>
     936:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     938:	478d                	li	a5,3
     93a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     93c:	609c                	ld	a5,0(s1)
     93e:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
     942:	609c                	ld	a5,0(s1)
     944:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
     948:	6098                	ld	a4,0(s1)
     94a:	00001797          	auipc	a5,0x1
     94e:	6b678793          	addi	a5,a5,1718 # 2000 <next_tid>
     952:	4394                	lw	a3,0(a5)
     954:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
     958:	4398                	lw	a4,0(a5)
     95a:	2705                	addiw	a4,a4,1
     95c:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
     95e:	6505                	lui	a0,0x1
     960:	00001097          	auipc	ra,0x1
     964:	844080e7          	jalr	-1980(ra) # 11a4 <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
     968:	6785                	lui	a5,0x1
     96a:	00a78733          	add	a4,a5,a0
     96e:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
     972:	17c1                	addi	a5,a5,-16 # ff0 <vprintf+0xfe>
     974:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
     976:	01253023          	sd	s2,0(a0) # 1000 <vprintf+0x10e>

    (*thread)->tcontext.sp = stack_top;
     97a:	609c                	ld	a5,0(s1)
     97c:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
     97e:	609c                	ld	a5,0(s1)
     980:	00000717          	auipc	a4,0x0
     984:	f6270713          	addi	a4,a4,-158 # 8e2 <thread_wrapper>
     988:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
     98a:	00001717          	auipc	a4,0x1
     98e:	6be70713          	addi	a4,a4,1726 # 2048 <threads>
     992:	4781                	li	a5,0
     994:	4641                	li	a2,16
        if (threads[i] == NULL) {
     996:	6314                	ld	a3,0(a4)
     998:	c29d                	beqz	a3,9be <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
     99a:	2785                	addiw	a5,a5,1
     99c:	0721                	addi	a4,a4,8
     99e:	fec79ce3          	bne	a5,a2,996 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
     9a2:	6088                	ld	a0,0(s1)
     9a4:	00000097          	auipc	ra,0x0
     9a8:	77e080e7          	jalr	1918(ra) # 1122 <free>
        *thread = NULL;
     9ac:	0004b023          	sd	zero,0(s1)
        return;
    }
}
     9b0:	70a2                	ld	ra,40(sp)
     9b2:	7402                	ld	s0,32(sp)
     9b4:	64e2                	ld	s1,24(sp)
     9b6:	6942                	ld	s2,16(sp)
     9b8:	69a2                	ld	s3,8(sp)
     9ba:	6145                	addi	sp,sp,48
     9bc:	8082                	ret
            threads[i] = *thread;
     9be:	6094                	ld	a3,0(s1)
     9c0:	078e                	slli	a5,a5,0x3
     9c2:	00001717          	auipc	a4,0x1
     9c6:	68670713          	addi	a4,a4,1670 # 2048 <threads>
     9ca:	97ba                	add	a5,a5,a4
     9cc:	e394                	sd	a3,0(a5)
    if (!thread_added) {
     9ce:	b7cd                	j	9b0 <tcreate+0x9a>

00000000000009d0 <tyield>:
    return 0;
}


void tyield()
{
     9d0:	1141                	addi	sp,sp,-16
     9d2:	e406                	sd	ra,8(sp)
     9d4:	e022                	sd	s0,0(sp)
     9d6:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
     9d8:	00001797          	auipc	a5,0x1
     9dc:	6407b783          	ld	a5,1600(a5) # 2018 <current_thread>
     9e0:	470d                	li	a4,3
     9e2:	dfb8                	sw	a4,120(a5)
    tsched();
     9e4:	00000097          	auipc	ra,0x0
     9e8:	e7c080e7          	jalr	-388(ra) # 860 <tsched>
}
     9ec:	60a2                	ld	ra,8(sp)
     9ee:	6402                	ld	s0,0(sp)
     9f0:	0141                	addi	sp,sp,16
     9f2:	8082                	ret

00000000000009f4 <tjoin>:
{
     9f4:	1101                	addi	sp,sp,-32
     9f6:	ec06                	sd	ra,24(sp)
     9f8:	e822                	sd	s0,16(sp)
     9fa:	e426                	sd	s1,8(sp)
     9fc:	e04a                	sd	s2,0(sp)
     9fe:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
     a00:	00001797          	auipc	a5,0x1
     a04:	64878793          	addi	a5,a5,1608 # 2048 <threads>
     a08:	00001697          	auipc	a3,0x1
     a0c:	6c068693          	addi	a3,a3,1728 # 20c8 <base>
     a10:	a021                	j	a18 <tjoin+0x24>
     a12:	07a1                	addi	a5,a5,8
     a14:	02d78b63          	beq	a5,a3,a4a <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
     a18:	6384                	ld	s1,0(a5)
     a1a:	dce5                	beqz	s1,a12 <tjoin+0x1e>
     a1c:	0004c703          	lbu	a4,0(s1)
     a20:	fea719e3          	bne	a4,a0,a12 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
     a24:	5cb8                	lw	a4,120(s1)
     a26:	4799                	li	a5,6
     a28:	4919                	li	s2,6
     a2a:	02f70263          	beq	a4,a5,a4e <tjoin+0x5a>
        tyield();
     a2e:	00000097          	auipc	ra,0x0
     a32:	fa2080e7          	jalr	-94(ra) # 9d0 <tyield>
    while (target_thread->state != EXITED) {
     a36:	5cbc                	lw	a5,120(s1)
     a38:	ff279be3          	bne	a5,s2,a2e <tjoin+0x3a>
    return 0;
     a3c:	4501                	li	a0,0
}
     a3e:	60e2                	ld	ra,24(sp)
     a40:	6442                	ld	s0,16(sp)
     a42:	64a2                	ld	s1,8(sp)
     a44:	6902                	ld	s2,0(sp)
     a46:	6105                	addi	sp,sp,32
     a48:	8082                	ret
        return -1;
     a4a:	557d                	li	a0,-1
     a4c:	bfcd                	j	a3e <tjoin+0x4a>
    return 0;
     a4e:	4501                	li	a0,0
     a50:	b7fd                	j	a3e <tjoin+0x4a>

0000000000000a52 <twhoami>:

uint8 twhoami()
{
     a52:	1141                	addi	sp,sp,-16
     a54:	e422                	sd	s0,8(sp)
     a56:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
     a58:	00001797          	auipc	a5,0x1
     a5c:	5c07b783          	ld	a5,1472(a5) # 2018 <current_thread>
     a60:	0007c503          	lbu	a0,0(a5)
     a64:	6422                	ld	s0,8(sp)
     a66:	0141                	addi	sp,sp,16
     a68:	8082                	ret

0000000000000a6a <tswtch>:
     a6a:	00153023          	sd	ra,0(a0)
     a6e:	00253423          	sd	sp,8(a0)
     a72:	e900                	sd	s0,16(a0)
     a74:	ed04                	sd	s1,24(a0)
     a76:	03253023          	sd	s2,32(a0)
     a7a:	03353423          	sd	s3,40(a0)
     a7e:	03453823          	sd	s4,48(a0)
     a82:	03553c23          	sd	s5,56(a0)
     a86:	05653023          	sd	s6,64(a0)
     a8a:	05753423          	sd	s7,72(a0)
     a8e:	05853823          	sd	s8,80(a0)
     a92:	05953c23          	sd	s9,88(a0)
     a96:	07a53023          	sd	s10,96(a0)
     a9a:	07b53423          	sd	s11,104(a0)
     a9e:	0005b083          	ld	ra,0(a1)
     aa2:	0085b103          	ld	sp,8(a1)
     aa6:	6980                	ld	s0,16(a1)
     aa8:	6d84                	ld	s1,24(a1)
     aaa:	0205b903          	ld	s2,32(a1)
     aae:	0285b983          	ld	s3,40(a1)
     ab2:	0305ba03          	ld	s4,48(a1)
     ab6:	0385ba83          	ld	s5,56(a1)
     aba:	0405bb03          	ld	s6,64(a1)
     abe:	0485bb83          	ld	s7,72(a1)
     ac2:	0505bc03          	ld	s8,80(a1)
     ac6:	0585bc83          	ld	s9,88(a1)
     aca:	0605bd03          	ld	s10,96(a1)
     ace:	0685bd83          	ld	s11,104(a1)
     ad2:	8082                	ret

0000000000000ad4 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     ad4:	1101                	addi	sp,sp,-32
     ad6:	ec06                	sd	ra,24(sp)
     ad8:	e822                	sd	s0,16(sp)
     ada:	e426                	sd	s1,8(sp)
     adc:	e04a                	sd	s2,0(sp)
     ade:	1000                	addi	s0,sp,32
     ae0:	84aa                	mv	s1,a0
     ae2:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
     ae4:	00000097          	auipc	ra,0x0
     ae8:	d1e080e7          	jalr	-738(ra) # 802 <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     aec:	85ca                	mv	a1,s2
     aee:	8526                	mv	a0,s1
     af0:	00000097          	auipc	ra,0x0
     af4:	b50080e7          	jalr	-1200(ra) # 640 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
     af8:	00000097          	auipc	ra,0x0
     afc:	274080e7          	jalr	628(ra) # d6c <exit>

0000000000000b00 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     b00:	1141                	addi	sp,sp,-16
     b02:	e422                	sd	s0,8(sp)
     b04:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
     b06:	87aa                	mv	a5,a0
     b08:	0585                	addi	a1,a1,1
     b0a:	0785                	addi	a5,a5,1
     b0c:	fff5c703          	lbu	a4,-1(a1)
     b10:	fee78fa3          	sb	a4,-1(a5)
     b14:	fb75                	bnez	a4,b08 <strcpy+0x8>
        ;
    return os;
}
     b16:	6422                	ld	s0,8(sp)
     b18:	0141                	addi	sp,sp,16
     b1a:	8082                	ret

0000000000000b1c <strcmp>:

int strcmp(const char *p, const char *q)
{
     b1c:	1141                	addi	sp,sp,-16
     b1e:	e422                	sd	s0,8(sp)
     b20:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
     b22:	00054783          	lbu	a5,0(a0)
     b26:	cb91                	beqz	a5,b3a <strcmp+0x1e>
     b28:	0005c703          	lbu	a4,0(a1)
     b2c:	00f71763          	bne	a4,a5,b3a <strcmp+0x1e>
        p++, q++;
     b30:	0505                	addi	a0,a0,1
     b32:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
     b34:	00054783          	lbu	a5,0(a0)
     b38:	fbe5                	bnez	a5,b28 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
     b3a:	0005c503          	lbu	a0,0(a1)
}
     b3e:	40a7853b          	subw	a0,a5,a0
     b42:	6422                	ld	s0,8(sp)
     b44:	0141                	addi	sp,sp,16
     b46:	8082                	ret

0000000000000b48 <strlen>:

uint strlen(const char *s)
{
     b48:	1141                	addi	sp,sp,-16
     b4a:	e422                	sd	s0,8(sp)
     b4c:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
     b4e:	00054783          	lbu	a5,0(a0)
     b52:	cf91                	beqz	a5,b6e <strlen+0x26>
     b54:	0505                	addi	a0,a0,1
     b56:	87aa                	mv	a5,a0
     b58:	86be                	mv	a3,a5
     b5a:	0785                	addi	a5,a5,1
     b5c:	fff7c703          	lbu	a4,-1(a5)
     b60:	ff65                	bnez	a4,b58 <strlen+0x10>
     b62:	40a6853b          	subw	a0,a3,a0
     b66:	2505                	addiw	a0,a0,1
        ;
    return n;
}
     b68:	6422                	ld	s0,8(sp)
     b6a:	0141                	addi	sp,sp,16
     b6c:	8082                	ret
    for (n = 0; s[n]; n++)
     b6e:	4501                	li	a0,0
     b70:	bfe5                	j	b68 <strlen+0x20>

0000000000000b72 <memset>:

void *
memset(void *dst, int c, uint n)
{
     b72:	1141                	addi	sp,sp,-16
     b74:	e422                	sd	s0,8(sp)
     b76:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
     b78:	ca19                	beqz	a2,b8e <memset+0x1c>
     b7a:	87aa                	mv	a5,a0
     b7c:	1602                	slli	a2,a2,0x20
     b7e:	9201                	srli	a2,a2,0x20
     b80:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
     b84:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
     b88:	0785                	addi	a5,a5,1
     b8a:	fee79de3          	bne	a5,a4,b84 <memset+0x12>
    }
    return dst;
}
     b8e:	6422                	ld	s0,8(sp)
     b90:	0141                	addi	sp,sp,16
     b92:	8082                	ret

0000000000000b94 <strchr>:

char *
strchr(const char *s, char c)
{
     b94:	1141                	addi	sp,sp,-16
     b96:	e422                	sd	s0,8(sp)
     b98:	0800                	addi	s0,sp,16
    for (; *s; s++)
     b9a:	00054783          	lbu	a5,0(a0)
     b9e:	cb99                	beqz	a5,bb4 <strchr+0x20>
        if (*s == c)
     ba0:	00f58763          	beq	a1,a5,bae <strchr+0x1a>
    for (; *s; s++)
     ba4:	0505                	addi	a0,a0,1
     ba6:	00054783          	lbu	a5,0(a0)
     baa:	fbfd                	bnez	a5,ba0 <strchr+0xc>
            return (char *)s;
    return 0;
     bac:	4501                	li	a0,0
}
     bae:	6422                	ld	s0,8(sp)
     bb0:	0141                	addi	sp,sp,16
     bb2:	8082                	ret
    return 0;
     bb4:	4501                	li	a0,0
     bb6:	bfe5                	j	bae <strchr+0x1a>

0000000000000bb8 <gets>:

char *
gets(char *buf, int max)
{
     bb8:	711d                	addi	sp,sp,-96
     bba:	ec86                	sd	ra,88(sp)
     bbc:	e8a2                	sd	s0,80(sp)
     bbe:	e4a6                	sd	s1,72(sp)
     bc0:	e0ca                	sd	s2,64(sp)
     bc2:	fc4e                	sd	s3,56(sp)
     bc4:	f852                	sd	s4,48(sp)
     bc6:	f456                	sd	s5,40(sp)
     bc8:	f05a                	sd	s6,32(sp)
     bca:	ec5e                	sd	s7,24(sp)
     bcc:	1080                	addi	s0,sp,96
     bce:	8baa                	mv	s7,a0
     bd0:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
     bd2:	892a                	mv	s2,a0
     bd4:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
     bd6:	4aa9                	li	s5,10
     bd8:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
     bda:	89a6                	mv	s3,s1
     bdc:	2485                	addiw	s1,s1,1
     bde:	0344d863          	bge	s1,s4,c0e <gets+0x56>
        cc = read(0, &c, 1);
     be2:	4605                	li	a2,1
     be4:	faf40593          	addi	a1,s0,-81
     be8:	4501                	li	a0,0
     bea:	00000097          	auipc	ra,0x0
     bee:	19a080e7          	jalr	410(ra) # d84 <read>
        if (cc < 1)
     bf2:	00a05e63          	blez	a0,c0e <gets+0x56>
        buf[i++] = c;
     bf6:	faf44783          	lbu	a5,-81(s0)
     bfa:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
     bfe:	01578763          	beq	a5,s5,c0c <gets+0x54>
     c02:	0905                	addi	s2,s2,1
     c04:	fd679be3          	bne	a5,s6,bda <gets+0x22>
    for (i = 0; i + 1 < max;)
     c08:	89a6                	mv	s3,s1
     c0a:	a011                	j	c0e <gets+0x56>
     c0c:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
     c0e:	99de                	add	s3,s3,s7
     c10:	00098023          	sb	zero,0(s3)
    return buf;
}
     c14:	855e                	mv	a0,s7
     c16:	60e6                	ld	ra,88(sp)
     c18:	6446                	ld	s0,80(sp)
     c1a:	64a6                	ld	s1,72(sp)
     c1c:	6906                	ld	s2,64(sp)
     c1e:	79e2                	ld	s3,56(sp)
     c20:	7a42                	ld	s4,48(sp)
     c22:	7aa2                	ld	s5,40(sp)
     c24:	7b02                	ld	s6,32(sp)
     c26:	6be2                	ld	s7,24(sp)
     c28:	6125                	addi	sp,sp,96
     c2a:	8082                	ret

0000000000000c2c <stat>:

int stat(const char *n, struct stat *st)
{
     c2c:	1101                	addi	sp,sp,-32
     c2e:	ec06                	sd	ra,24(sp)
     c30:	e822                	sd	s0,16(sp)
     c32:	e426                	sd	s1,8(sp)
     c34:	e04a                	sd	s2,0(sp)
     c36:	1000                	addi	s0,sp,32
     c38:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     c3a:	4581                	li	a1,0
     c3c:	00000097          	auipc	ra,0x0
     c40:	170080e7          	jalr	368(ra) # dac <open>
    if (fd < 0)
     c44:	02054563          	bltz	a0,c6e <stat+0x42>
     c48:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
     c4a:	85ca                	mv	a1,s2
     c4c:	00000097          	auipc	ra,0x0
     c50:	178080e7          	jalr	376(ra) # dc4 <fstat>
     c54:	892a                	mv	s2,a0
    close(fd);
     c56:	8526                	mv	a0,s1
     c58:	00000097          	auipc	ra,0x0
     c5c:	13c080e7          	jalr	316(ra) # d94 <close>
    return r;
}
     c60:	854a                	mv	a0,s2
     c62:	60e2                	ld	ra,24(sp)
     c64:	6442                	ld	s0,16(sp)
     c66:	64a2                	ld	s1,8(sp)
     c68:	6902                	ld	s2,0(sp)
     c6a:	6105                	addi	sp,sp,32
     c6c:	8082                	ret
        return -1;
     c6e:	597d                	li	s2,-1
     c70:	bfc5                	j	c60 <stat+0x34>

0000000000000c72 <atoi>:

int atoi(const char *s)
{
     c72:	1141                	addi	sp,sp,-16
     c74:	e422                	sd	s0,8(sp)
     c76:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
     c78:	00054683          	lbu	a3,0(a0)
     c7c:	fd06879b          	addiw	a5,a3,-48
     c80:	0ff7f793          	zext.b	a5,a5
     c84:	4625                	li	a2,9
     c86:	02f66863          	bltu	a2,a5,cb6 <atoi+0x44>
     c8a:	872a                	mv	a4,a0
    n = 0;
     c8c:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
     c8e:	0705                	addi	a4,a4,1
     c90:	0025179b          	slliw	a5,a0,0x2
     c94:	9fa9                	addw	a5,a5,a0
     c96:	0017979b          	slliw	a5,a5,0x1
     c9a:	9fb5                	addw	a5,a5,a3
     c9c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
     ca0:	00074683          	lbu	a3,0(a4)
     ca4:	fd06879b          	addiw	a5,a3,-48
     ca8:	0ff7f793          	zext.b	a5,a5
     cac:	fef671e3          	bgeu	a2,a5,c8e <atoi+0x1c>
    return n;
}
     cb0:	6422                	ld	s0,8(sp)
     cb2:	0141                	addi	sp,sp,16
     cb4:	8082                	ret
    n = 0;
     cb6:	4501                	li	a0,0
     cb8:	bfe5                	j	cb0 <atoi+0x3e>

0000000000000cba <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
     cba:	1141                	addi	sp,sp,-16
     cbc:	e422                	sd	s0,8(sp)
     cbe:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
     cc0:	02b57463          	bgeu	a0,a1,ce8 <memmove+0x2e>
    {
        while (n-- > 0)
     cc4:	00c05f63          	blez	a2,ce2 <memmove+0x28>
     cc8:	1602                	slli	a2,a2,0x20
     cca:	9201                	srli	a2,a2,0x20
     ccc:	00c507b3          	add	a5,a0,a2
    dst = vdst;
     cd0:	872a                	mv	a4,a0
            *dst++ = *src++;
     cd2:	0585                	addi	a1,a1,1
     cd4:	0705                	addi	a4,a4,1
     cd6:	fff5c683          	lbu	a3,-1(a1)
     cda:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
     cde:	fee79ae3          	bne	a5,a4,cd2 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
     ce2:	6422                	ld	s0,8(sp)
     ce4:	0141                	addi	sp,sp,16
     ce6:	8082                	ret
        dst += n;
     ce8:	00c50733          	add	a4,a0,a2
        src += n;
     cec:	95b2                	add	a1,a1,a2
        while (n-- > 0)
     cee:	fec05ae3          	blez	a2,ce2 <memmove+0x28>
     cf2:	fff6079b          	addiw	a5,a2,-1
     cf6:	1782                	slli	a5,a5,0x20
     cf8:	9381                	srli	a5,a5,0x20
     cfa:	fff7c793          	not	a5,a5
     cfe:	97ba                	add	a5,a5,a4
            *--dst = *--src;
     d00:	15fd                	addi	a1,a1,-1
     d02:	177d                	addi	a4,a4,-1
     d04:	0005c683          	lbu	a3,0(a1)
     d08:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
     d0c:	fee79ae3          	bne	a5,a4,d00 <memmove+0x46>
     d10:	bfc9                	j	ce2 <memmove+0x28>

0000000000000d12 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
     d12:	1141                	addi	sp,sp,-16
     d14:	e422                	sd	s0,8(sp)
     d16:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
     d18:	ca05                	beqz	a2,d48 <memcmp+0x36>
     d1a:	fff6069b          	addiw	a3,a2,-1
     d1e:	1682                	slli	a3,a3,0x20
     d20:	9281                	srli	a3,a3,0x20
     d22:	0685                	addi	a3,a3,1
     d24:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
     d26:	00054783          	lbu	a5,0(a0)
     d2a:	0005c703          	lbu	a4,0(a1)
     d2e:	00e79863          	bne	a5,a4,d3e <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
     d32:	0505                	addi	a0,a0,1
        p2++;
     d34:	0585                	addi	a1,a1,1
    while (n-- > 0)
     d36:	fed518e3          	bne	a0,a3,d26 <memcmp+0x14>
    }
    return 0;
     d3a:	4501                	li	a0,0
     d3c:	a019                	j	d42 <memcmp+0x30>
            return *p1 - *p2;
     d3e:	40e7853b          	subw	a0,a5,a4
}
     d42:	6422                	ld	s0,8(sp)
     d44:	0141                	addi	sp,sp,16
     d46:	8082                	ret
    return 0;
     d48:	4501                	li	a0,0
     d4a:	bfe5                	j	d42 <memcmp+0x30>

0000000000000d4c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     d4c:	1141                	addi	sp,sp,-16
     d4e:	e406                	sd	ra,8(sp)
     d50:	e022                	sd	s0,0(sp)
     d52:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
     d54:	00000097          	auipc	ra,0x0
     d58:	f66080e7          	jalr	-154(ra) # cba <memmove>
}
     d5c:	60a2                	ld	ra,8(sp)
     d5e:	6402                	ld	s0,0(sp)
     d60:	0141                	addi	sp,sp,16
     d62:	8082                	ret

0000000000000d64 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     d64:	4885                	li	a7,1
 ecall
     d66:	00000073          	ecall
 ret
     d6a:	8082                	ret

0000000000000d6c <exit>:
.global exit
exit:
 li a7, SYS_exit
     d6c:	4889                	li	a7,2
 ecall
     d6e:	00000073          	ecall
 ret
     d72:	8082                	ret

0000000000000d74 <wait>:
.global wait
wait:
 li a7, SYS_wait
     d74:	488d                	li	a7,3
 ecall
     d76:	00000073          	ecall
 ret
     d7a:	8082                	ret

0000000000000d7c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     d7c:	4891                	li	a7,4
 ecall
     d7e:	00000073          	ecall
 ret
     d82:	8082                	ret

0000000000000d84 <read>:
.global read
read:
 li a7, SYS_read
     d84:	4895                	li	a7,5
 ecall
     d86:	00000073          	ecall
 ret
     d8a:	8082                	ret

0000000000000d8c <write>:
.global write
write:
 li a7, SYS_write
     d8c:	48c1                	li	a7,16
 ecall
     d8e:	00000073          	ecall
 ret
     d92:	8082                	ret

0000000000000d94 <close>:
.global close
close:
 li a7, SYS_close
     d94:	48d5                	li	a7,21
 ecall
     d96:	00000073          	ecall
 ret
     d9a:	8082                	ret

0000000000000d9c <kill>:
.global kill
kill:
 li a7, SYS_kill
     d9c:	4899                	li	a7,6
 ecall
     d9e:	00000073          	ecall
 ret
     da2:	8082                	ret

0000000000000da4 <exec>:
.global exec
exec:
 li a7, SYS_exec
     da4:	489d                	li	a7,7
 ecall
     da6:	00000073          	ecall
 ret
     daa:	8082                	ret

0000000000000dac <open>:
.global open
open:
 li a7, SYS_open
     dac:	48bd                	li	a7,15
 ecall
     dae:	00000073          	ecall
 ret
     db2:	8082                	ret

0000000000000db4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     db4:	48c5                	li	a7,17
 ecall
     db6:	00000073          	ecall
 ret
     dba:	8082                	ret

0000000000000dbc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     dbc:	48c9                	li	a7,18
 ecall
     dbe:	00000073          	ecall
 ret
     dc2:	8082                	ret

0000000000000dc4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     dc4:	48a1                	li	a7,8
 ecall
     dc6:	00000073          	ecall
 ret
     dca:	8082                	ret

0000000000000dcc <link>:
.global link
link:
 li a7, SYS_link
     dcc:	48cd                	li	a7,19
 ecall
     dce:	00000073          	ecall
 ret
     dd2:	8082                	ret

0000000000000dd4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     dd4:	48d1                	li	a7,20
 ecall
     dd6:	00000073          	ecall
 ret
     dda:	8082                	ret

0000000000000ddc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     ddc:	48a5                	li	a7,9
 ecall
     dde:	00000073          	ecall
 ret
     de2:	8082                	ret

0000000000000de4 <dup>:
.global dup
dup:
 li a7, SYS_dup
     de4:	48a9                	li	a7,10
 ecall
     de6:	00000073          	ecall
 ret
     dea:	8082                	ret

0000000000000dec <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     dec:	48ad                	li	a7,11
 ecall
     dee:	00000073          	ecall
 ret
     df2:	8082                	ret

0000000000000df4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     df4:	48b1                	li	a7,12
 ecall
     df6:	00000073          	ecall
 ret
     dfa:	8082                	ret

0000000000000dfc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     dfc:	48b5                	li	a7,13
 ecall
     dfe:	00000073          	ecall
 ret
     e02:	8082                	ret

0000000000000e04 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     e04:	48b9                	li	a7,14
 ecall
     e06:	00000073          	ecall
 ret
     e0a:	8082                	ret

0000000000000e0c <ps>:
.global ps
ps:
 li a7, SYS_ps
     e0c:	48d9                	li	a7,22
 ecall
     e0e:	00000073          	ecall
 ret
     e12:	8082                	ret

0000000000000e14 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
     e14:	48dd                	li	a7,23
 ecall
     e16:	00000073          	ecall
 ret
     e1a:	8082                	ret

0000000000000e1c <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
     e1c:	48e1                	li	a7,24
 ecall
     e1e:	00000073          	ecall
 ret
     e22:	8082                	ret

0000000000000e24 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     e24:	1101                	addi	sp,sp,-32
     e26:	ec06                	sd	ra,24(sp)
     e28:	e822                	sd	s0,16(sp)
     e2a:	1000                	addi	s0,sp,32
     e2c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     e30:	4605                	li	a2,1
     e32:	fef40593          	addi	a1,s0,-17
     e36:	00000097          	auipc	ra,0x0
     e3a:	f56080e7          	jalr	-170(ra) # d8c <write>
}
     e3e:	60e2                	ld	ra,24(sp)
     e40:	6442                	ld	s0,16(sp)
     e42:	6105                	addi	sp,sp,32
     e44:	8082                	ret

0000000000000e46 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     e46:	7139                	addi	sp,sp,-64
     e48:	fc06                	sd	ra,56(sp)
     e4a:	f822                	sd	s0,48(sp)
     e4c:	f426                	sd	s1,40(sp)
     e4e:	f04a                	sd	s2,32(sp)
     e50:	ec4e                	sd	s3,24(sp)
     e52:	0080                	addi	s0,sp,64
     e54:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e56:	c299                	beqz	a3,e5c <printint+0x16>
     e58:	0805c963          	bltz	a1,eea <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     e5c:	2581                	sext.w	a1,a1
  neg = 0;
     e5e:	4881                	li	a7,0
     e60:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     e64:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     e66:	2601                	sext.w	a2,a2
     e68:	00000517          	auipc	a0,0x0
     e6c:	67850513          	addi	a0,a0,1656 # 14e0 <digits>
     e70:	883a                	mv	a6,a4
     e72:	2705                	addiw	a4,a4,1
     e74:	02c5f7bb          	remuw	a5,a1,a2
     e78:	1782                	slli	a5,a5,0x20
     e7a:	9381                	srli	a5,a5,0x20
     e7c:	97aa                	add	a5,a5,a0
     e7e:	0007c783          	lbu	a5,0(a5)
     e82:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     e86:	0005879b          	sext.w	a5,a1
     e8a:	02c5d5bb          	divuw	a1,a1,a2
     e8e:	0685                	addi	a3,a3,1
     e90:	fec7f0e3          	bgeu	a5,a2,e70 <printint+0x2a>
  if(neg)
     e94:	00088c63          	beqz	a7,eac <printint+0x66>
    buf[i++] = '-';
     e98:	fd070793          	addi	a5,a4,-48
     e9c:	00878733          	add	a4,a5,s0
     ea0:	02d00793          	li	a5,45
     ea4:	fef70823          	sb	a5,-16(a4)
     ea8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     eac:	02e05863          	blez	a4,edc <printint+0x96>
     eb0:	fc040793          	addi	a5,s0,-64
     eb4:	00e78933          	add	s2,a5,a4
     eb8:	fff78993          	addi	s3,a5,-1
     ebc:	99ba                	add	s3,s3,a4
     ebe:	377d                	addiw	a4,a4,-1
     ec0:	1702                	slli	a4,a4,0x20
     ec2:	9301                	srli	a4,a4,0x20
     ec4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     ec8:	fff94583          	lbu	a1,-1(s2)
     ecc:	8526                	mv	a0,s1
     ece:	00000097          	auipc	ra,0x0
     ed2:	f56080e7          	jalr	-170(ra) # e24 <putc>
  while(--i >= 0)
     ed6:	197d                	addi	s2,s2,-1
     ed8:	ff3918e3          	bne	s2,s3,ec8 <printint+0x82>
}
     edc:	70e2                	ld	ra,56(sp)
     ede:	7442                	ld	s0,48(sp)
     ee0:	74a2                	ld	s1,40(sp)
     ee2:	7902                	ld	s2,32(sp)
     ee4:	69e2                	ld	s3,24(sp)
     ee6:	6121                	addi	sp,sp,64
     ee8:	8082                	ret
    x = -xx;
     eea:	40b005bb          	negw	a1,a1
    neg = 1;
     eee:	4885                	li	a7,1
    x = -xx;
     ef0:	bf85                	j	e60 <printint+0x1a>

0000000000000ef2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     ef2:	715d                	addi	sp,sp,-80
     ef4:	e486                	sd	ra,72(sp)
     ef6:	e0a2                	sd	s0,64(sp)
     ef8:	fc26                	sd	s1,56(sp)
     efa:	f84a                	sd	s2,48(sp)
     efc:	f44e                	sd	s3,40(sp)
     efe:	f052                	sd	s4,32(sp)
     f00:	ec56                	sd	s5,24(sp)
     f02:	e85a                	sd	s6,16(sp)
     f04:	e45e                	sd	s7,8(sp)
     f06:	e062                	sd	s8,0(sp)
     f08:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f0a:	0005c903          	lbu	s2,0(a1)
     f0e:	18090c63          	beqz	s2,10a6 <vprintf+0x1b4>
     f12:	8aaa                	mv	s5,a0
     f14:	8bb2                	mv	s7,a2
     f16:	00158493          	addi	s1,a1,1
  state = 0;
     f1a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     f1c:	02500a13          	li	s4,37
     f20:	4b55                	li	s6,21
     f22:	a839                	j	f40 <vprintf+0x4e>
        putc(fd, c);
     f24:	85ca                	mv	a1,s2
     f26:	8556                	mv	a0,s5
     f28:	00000097          	auipc	ra,0x0
     f2c:	efc080e7          	jalr	-260(ra) # e24 <putc>
     f30:	a019                	j	f36 <vprintf+0x44>
    } else if(state == '%'){
     f32:	01498d63          	beq	s3,s4,f4c <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
     f36:	0485                	addi	s1,s1,1
     f38:	fff4c903          	lbu	s2,-1(s1)
     f3c:	16090563          	beqz	s2,10a6 <vprintf+0x1b4>
    if(state == 0){
     f40:	fe0999e3          	bnez	s3,f32 <vprintf+0x40>
      if(c == '%'){
     f44:	ff4910e3          	bne	s2,s4,f24 <vprintf+0x32>
        state = '%';
     f48:	89d2                	mv	s3,s4
     f4a:	b7f5                	j	f36 <vprintf+0x44>
      if(c == 'd'){
     f4c:	13490263          	beq	s2,s4,1070 <vprintf+0x17e>
     f50:	f9d9079b          	addiw	a5,s2,-99
     f54:	0ff7f793          	zext.b	a5,a5
     f58:	12fb6563          	bltu	s6,a5,1082 <vprintf+0x190>
     f5c:	f9d9079b          	addiw	a5,s2,-99
     f60:	0ff7f713          	zext.b	a4,a5
     f64:	10eb6f63          	bltu	s6,a4,1082 <vprintf+0x190>
     f68:	00271793          	slli	a5,a4,0x2
     f6c:	00000717          	auipc	a4,0x0
     f70:	51c70713          	addi	a4,a4,1308 # 1488 <__FUNCTION__.5+0x70>
     f74:	97ba                	add	a5,a5,a4
     f76:	439c                	lw	a5,0(a5)
     f78:	97ba                	add	a5,a5,a4
     f7a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
     f7c:	008b8913          	addi	s2,s7,8
     f80:	4685                	li	a3,1
     f82:	4629                	li	a2,10
     f84:	000ba583          	lw	a1,0(s7)
     f88:	8556                	mv	a0,s5
     f8a:	00000097          	auipc	ra,0x0
     f8e:	ebc080e7          	jalr	-324(ra) # e46 <printint>
     f92:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f94:	4981                	li	s3,0
     f96:	b745                	j	f36 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f98:	008b8913          	addi	s2,s7,8
     f9c:	4681                	li	a3,0
     f9e:	4629                	li	a2,10
     fa0:	000ba583          	lw	a1,0(s7)
     fa4:	8556                	mv	a0,s5
     fa6:	00000097          	auipc	ra,0x0
     faa:	ea0080e7          	jalr	-352(ra) # e46 <printint>
     fae:	8bca                	mv	s7,s2
      state = 0;
     fb0:	4981                	li	s3,0
     fb2:	b751                	j	f36 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
     fb4:	008b8913          	addi	s2,s7,8
     fb8:	4681                	li	a3,0
     fba:	4641                	li	a2,16
     fbc:	000ba583          	lw	a1,0(s7)
     fc0:	8556                	mv	a0,s5
     fc2:	00000097          	auipc	ra,0x0
     fc6:	e84080e7          	jalr	-380(ra) # e46 <printint>
     fca:	8bca                	mv	s7,s2
      state = 0;
     fcc:	4981                	li	s3,0
     fce:	b7a5                	j	f36 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
     fd0:	008b8c13          	addi	s8,s7,8
     fd4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     fd8:	03000593          	li	a1,48
     fdc:	8556                	mv	a0,s5
     fde:	00000097          	auipc	ra,0x0
     fe2:	e46080e7          	jalr	-442(ra) # e24 <putc>
  putc(fd, 'x');
     fe6:	07800593          	li	a1,120
     fea:	8556                	mv	a0,s5
     fec:	00000097          	auipc	ra,0x0
     ff0:	e38080e7          	jalr	-456(ra) # e24 <putc>
     ff4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ff6:	00000b97          	auipc	s7,0x0
     ffa:	4eab8b93          	addi	s7,s7,1258 # 14e0 <digits>
     ffe:	03c9d793          	srli	a5,s3,0x3c
    1002:	97de                	add	a5,a5,s7
    1004:	0007c583          	lbu	a1,0(a5)
    1008:	8556                	mv	a0,s5
    100a:	00000097          	auipc	ra,0x0
    100e:	e1a080e7          	jalr	-486(ra) # e24 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1012:	0992                	slli	s3,s3,0x4
    1014:	397d                	addiw	s2,s2,-1
    1016:	fe0914e3          	bnez	s2,ffe <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    101a:	8be2                	mv	s7,s8
      state = 0;
    101c:	4981                	li	s3,0
    101e:	bf21                	j	f36 <vprintf+0x44>
        s = va_arg(ap, char*);
    1020:	008b8993          	addi	s3,s7,8
    1024:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    1028:	02090163          	beqz	s2,104a <vprintf+0x158>
        while(*s != 0){
    102c:	00094583          	lbu	a1,0(s2)
    1030:	c9a5                	beqz	a1,10a0 <vprintf+0x1ae>
          putc(fd, *s);
    1032:	8556                	mv	a0,s5
    1034:	00000097          	auipc	ra,0x0
    1038:	df0080e7          	jalr	-528(ra) # e24 <putc>
          s++;
    103c:	0905                	addi	s2,s2,1
        while(*s != 0){
    103e:	00094583          	lbu	a1,0(s2)
    1042:	f9e5                	bnez	a1,1032 <vprintf+0x140>
        s = va_arg(ap, char*);
    1044:	8bce                	mv	s7,s3
      state = 0;
    1046:	4981                	li	s3,0
    1048:	b5fd                	j	f36 <vprintf+0x44>
          s = "(null)";
    104a:	00000917          	auipc	s2,0x0
    104e:	43690913          	addi	s2,s2,1078 # 1480 <__FUNCTION__.5+0x68>
        while(*s != 0){
    1052:	02800593          	li	a1,40
    1056:	bff1                	j	1032 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    1058:	008b8913          	addi	s2,s7,8
    105c:	000bc583          	lbu	a1,0(s7)
    1060:	8556                	mv	a0,s5
    1062:	00000097          	auipc	ra,0x0
    1066:	dc2080e7          	jalr	-574(ra) # e24 <putc>
    106a:	8bca                	mv	s7,s2
      state = 0;
    106c:	4981                	li	s3,0
    106e:	b5e1                	j	f36 <vprintf+0x44>
        putc(fd, c);
    1070:	02500593          	li	a1,37
    1074:	8556                	mv	a0,s5
    1076:	00000097          	auipc	ra,0x0
    107a:	dae080e7          	jalr	-594(ra) # e24 <putc>
      state = 0;
    107e:	4981                	li	s3,0
    1080:	bd5d                	j	f36 <vprintf+0x44>
        putc(fd, '%');
    1082:	02500593          	li	a1,37
    1086:	8556                	mv	a0,s5
    1088:	00000097          	auipc	ra,0x0
    108c:	d9c080e7          	jalr	-612(ra) # e24 <putc>
        putc(fd, c);
    1090:	85ca                	mv	a1,s2
    1092:	8556                	mv	a0,s5
    1094:	00000097          	auipc	ra,0x0
    1098:	d90080e7          	jalr	-624(ra) # e24 <putc>
      state = 0;
    109c:	4981                	li	s3,0
    109e:	bd61                	j	f36 <vprintf+0x44>
        s = va_arg(ap, char*);
    10a0:	8bce                	mv	s7,s3
      state = 0;
    10a2:	4981                	li	s3,0
    10a4:	bd49                	j	f36 <vprintf+0x44>
    }
  }
}
    10a6:	60a6                	ld	ra,72(sp)
    10a8:	6406                	ld	s0,64(sp)
    10aa:	74e2                	ld	s1,56(sp)
    10ac:	7942                	ld	s2,48(sp)
    10ae:	79a2                	ld	s3,40(sp)
    10b0:	7a02                	ld	s4,32(sp)
    10b2:	6ae2                	ld	s5,24(sp)
    10b4:	6b42                	ld	s6,16(sp)
    10b6:	6ba2                	ld	s7,8(sp)
    10b8:	6c02                	ld	s8,0(sp)
    10ba:	6161                	addi	sp,sp,80
    10bc:	8082                	ret

00000000000010be <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    10be:	715d                	addi	sp,sp,-80
    10c0:	ec06                	sd	ra,24(sp)
    10c2:	e822                	sd	s0,16(sp)
    10c4:	1000                	addi	s0,sp,32
    10c6:	e010                	sd	a2,0(s0)
    10c8:	e414                	sd	a3,8(s0)
    10ca:	e818                	sd	a4,16(s0)
    10cc:	ec1c                	sd	a5,24(s0)
    10ce:	03043023          	sd	a6,32(s0)
    10d2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    10d6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    10da:	8622                	mv	a2,s0
    10dc:	00000097          	auipc	ra,0x0
    10e0:	e16080e7          	jalr	-490(ra) # ef2 <vprintf>
}
    10e4:	60e2                	ld	ra,24(sp)
    10e6:	6442                	ld	s0,16(sp)
    10e8:	6161                	addi	sp,sp,80
    10ea:	8082                	ret

00000000000010ec <printf>:

void
printf(const char *fmt, ...)
{
    10ec:	711d                	addi	sp,sp,-96
    10ee:	ec06                	sd	ra,24(sp)
    10f0:	e822                	sd	s0,16(sp)
    10f2:	1000                	addi	s0,sp,32
    10f4:	e40c                	sd	a1,8(s0)
    10f6:	e810                	sd	a2,16(s0)
    10f8:	ec14                	sd	a3,24(s0)
    10fa:	f018                	sd	a4,32(s0)
    10fc:	f41c                	sd	a5,40(s0)
    10fe:	03043823          	sd	a6,48(s0)
    1102:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1106:	00840613          	addi	a2,s0,8
    110a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    110e:	85aa                	mv	a1,a0
    1110:	4505                	li	a0,1
    1112:	00000097          	auipc	ra,0x0
    1116:	de0080e7          	jalr	-544(ra) # ef2 <vprintf>
}
    111a:	60e2                	ld	ra,24(sp)
    111c:	6442                	ld	s0,16(sp)
    111e:	6125                	addi	sp,sp,96
    1120:	8082                	ret

0000000000001122 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    1122:	1141                	addi	sp,sp,-16
    1124:	e422                	sd	s0,8(sp)
    1126:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    1128:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    112c:	00001797          	auipc	a5,0x1
    1130:	ef47b783          	ld	a5,-268(a5) # 2020 <freep>
    1134:	a02d                	j	115e <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    1136:	4618                	lw	a4,8(a2)
    1138:	9f2d                	addw	a4,a4,a1
    113a:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    113e:	6398                	ld	a4,0(a5)
    1140:	6310                	ld	a2,0(a4)
    1142:	a83d                	j	1180 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    1144:	ff852703          	lw	a4,-8(a0)
    1148:	9f31                	addw	a4,a4,a2
    114a:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    114c:	ff053683          	ld	a3,-16(a0)
    1150:	a091                	j	1194 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1152:	6398                	ld	a4,0(a5)
    1154:	00e7e463          	bltu	a5,a4,115c <free+0x3a>
    1158:	00e6ea63          	bltu	a3,a4,116c <free+0x4a>
{
    115c:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    115e:	fed7fae3          	bgeu	a5,a3,1152 <free+0x30>
    1162:	6398                	ld	a4,0(a5)
    1164:	00e6e463          	bltu	a3,a4,116c <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1168:	fee7eae3          	bltu	a5,a4,115c <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    116c:	ff852583          	lw	a1,-8(a0)
    1170:	6390                	ld	a2,0(a5)
    1172:	02059813          	slli	a6,a1,0x20
    1176:	01c85713          	srli	a4,a6,0x1c
    117a:	9736                	add	a4,a4,a3
    117c:	fae60de3          	beq	a2,a4,1136 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    1180:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    1184:	4790                	lw	a2,8(a5)
    1186:	02061593          	slli	a1,a2,0x20
    118a:	01c5d713          	srli	a4,a1,0x1c
    118e:	973e                	add	a4,a4,a5
    1190:	fae68ae3          	beq	a3,a4,1144 <free+0x22>
        p->s.ptr = bp->s.ptr;
    1194:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    1196:	00001717          	auipc	a4,0x1
    119a:	e8f73523          	sd	a5,-374(a4) # 2020 <freep>
}
    119e:	6422                	ld	s0,8(sp)
    11a0:	0141                	addi	sp,sp,16
    11a2:	8082                	ret

00000000000011a4 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    11a4:	7139                	addi	sp,sp,-64
    11a6:	fc06                	sd	ra,56(sp)
    11a8:	f822                	sd	s0,48(sp)
    11aa:	f426                	sd	s1,40(sp)
    11ac:	f04a                	sd	s2,32(sp)
    11ae:	ec4e                	sd	s3,24(sp)
    11b0:	e852                	sd	s4,16(sp)
    11b2:	e456                	sd	s5,8(sp)
    11b4:	e05a                	sd	s6,0(sp)
    11b6:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    11b8:	02051493          	slli	s1,a0,0x20
    11bc:	9081                	srli	s1,s1,0x20
    11be:	04bd                	addi	s1,s1,15
    11c0:	8091                	srli	s1,s1,0x4
    11c2:	0014899b          	addiw	s3,s1,1
    11c6:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    11c8:	00001517          	auipc	a0,0x1
    11cc:	e5853503          	ld	a0,-424(a0) # 2020 <freep>
    11d0:	c515                	beqz	a0,11fc <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    11d2:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    11d4:	4798                	lw	a4,8(a5)
    11d6:	02977f63          	bgeu	a4,s1,1214 <malloc+0x70>
    if (nu < 4096)
    11da:	8a4e                	mv	s4,s3
    11dc:	0009871b          	sext.w	a4,s3
    11e0:	6685                	lui	a3,0x1
    11e2:	00d77363          	bgeu	a4,a3,11e8 <malloc+0x44>
    11e6:	6a05                	lui	s4,0x1
    11e8:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    11ec:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    11f0:	00001917          	auipc	s2,0x1
    11f4:	e3090913          	addi	s2,s2,-464 # 2020 <freep>
    if (p == (char *)-1)
    11f8:	5afd                	li	s5,-1
    11fa:	a895                	j	126e <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    11fc:	00001797          	auipc	a5,0x1
    1200:	ecc78793          	addi	a5,a5,-308 # 20c8 <base>
    1204:	00001717          	auipc	a4,0x1
    1208:	e0f73e23          	sd	a5,-484(a4) # 2020 <freep>
    120c:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    120e:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    1212:	b7e1                	j	11da <malloc+0x36>
            if (p->s.size == nunits)
    1214:	02e48c63          	beq	s1,a4,124c <malloc+0xa8>
                p->s.size -= nunits;
    1218:	4137073b          	subw	a4,a4,s3
    121c:	c798                	sw	a4,8(a5)
                p += p->s.size;
    121e:	02071693          	slli	a3,a4,0x20
    1222:	01c6d713          	srli	a4,a3,0x1c
    1226:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    1228:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    122c:	00001717          	auipc	a4,0x1
    1230:	dea73a23          	sd	a0,-524(a4) # 2020 <freep>
            return (void *)(p + 1);
    1234:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    1238:	70e2                	ld	ra,56(sp)
    123a:	7442                	ld	s0,48(sp)
    123c:	74a2                	ld	s1,40(sp)
    123e:	7902                	ld	s2,32(sp)
    1240:	69e2                	ld	s3,24(sp)
    1242:	6a42                	ld	s4,16(sp)
    1244:	6aa2                	ld	s5,8(sp)
    1246:	6b02                	ld	s6,0(sp)
    1248:	6121                	addi	sp,sp,64
    124a:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    124c:	6398                	ld	a4,0(a5)
    124e:	e118                	sd	a4,0(a0)
    1250:	bff1                	j	122c <malloc+0x88>
    hp->s.size = nu;
    1252:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    1256:	0541                	addi	a0,a0,16
    1258:	00000097          	auipc	ra,0x0
    125c:	eca080e7          	jalr	-310(ra) # 1122 <free>
    return freep;
    1260:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    1264:	d971                	beqz	a0,1238 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    1266:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    1268:	4798                	lw	a4,8(a5)
    126a:	fa9775e3          	bgeu	a4,s1,1214 <malloc+0x70>
        if (p == freep)
    126e:	00093703          	ld	a4,0(s2)
    1272:	853e                	mv	a0,a5
    1274:	fef719e3          	bne	a4,a5,1266 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    1278:	8552                	mv	a0,s4
    127a:	00000097          	auipc	ra,0x0
    127e:	b7a080e7          	jalr	-1158(ra) # df4 <sbrk>
    if (p == (char *)-1)
    1282:	fd5518e3          	bne	a0,s5,1252 <malloc+0xae>
                return 0;
    1286:	4501                	li	a0,0
    1288:	bf45                	j	1238 <malloc+0x94>
