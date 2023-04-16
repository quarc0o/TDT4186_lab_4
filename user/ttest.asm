
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
       c:	0e850513          	addi	a0,a0,232 # 10f0 <__FUNCTION__.4+0x10>
      10:	00001097          	auipc	ra,0x1
      14:	f0c080e7          	jalr	-244(ra) # f1c <printf>
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
      2e:	85a080e7          	jalr	-1958(ra) # 884 <twhoami>
      32:	0005059b          	sext.w	a1,a0
      36:	00001517          	auipc	a0,0x1
      3a:	0ca50513          	addi	a0,a0,202 # 1100 <__FUNCTION__.4+0x20>
      3e:	00001097          	auipc	ra,0x1
      42:	ede080e7          	jalr	-290(ra) # f1c <printf>
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
      6c:	81c080e7          	jalr	-2020(ra) # 884 <twhoami>
      70:	00002497          	auipc	s1,0x2
      74:	f9048493          	addi	s1,s1,-112 # 2000 <shared_state>
      78:	4094                	lw	a3,0(s1)
      7a:	0005061b          	sext.w	a2,a0
      7e:	00001597          	auipc	a1,0x1
      82:	1ba58593          	addi	a1,a1,442 # 1238 <__FUNCTION__.6>
      86:	00001517          	auipc	a0,0x1
      8a:	09a50513          	addi	a0,a0,154 # 1120 <__FUNCTION__.4+0x40>
      8e:	00001097          	auipc	ra,0x1
      92:	e8e080e7          	jalr	-370(ra) # f1c <printf>
    if (shared_state == 0)
      96:	409c                	lw	a5,0(s1)
      98:	ebb5                	bnez	a5,10c <race_for_state+0xbc>
        tyield();
      9a:	00000097          	auipc	ra,0x0
      9e:	7d2080e7          	jalr	2002(ra) # 86c <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
      a2:	00000097          	auipc	ra,0x0
      a6:	7e2080e7          	jalr	2018(ra) # 884 <twhoami>
      aa:	00001917          	auipc	s2,0x1
      ae:	18e90913          	addi	s2,s2,398 # 1238 <__FUNCTION__.6>
      b2:	4094                	lw	a3,0(s1)
      b4:	0005061b          	sext.w	a2,a0
      b8:	85ca                	mv	a1,s2
      ba:	00001517          	auipc	a0,0x1
      be:	06650513          	addi	a0,a0,102 # 1120 <__FUNCTION__.4+0x40>
      c2:	00001097          	auipc	ra,0x1
      c6:	e5a080e7          	jalr	-422(ra) # f1c <printf>
        shared_state += args.a;
      ca:	409c                	lw	a5,0(s1)
      cc:	014787bb          	addw	a5,a5,s4
      d0:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
      d2:	00000097          	auipc	ra,0x0
      d6:	7b2080e7          	jalr	1970(ra) # 884 <twhoami>
      da:	4094                	lw	a3,0(s1)
      dc:	0005061b          	sext.w	a2,a0
      e0:	85ca                	mv	a1,s2
      e2:	00001517          	auipc	a0,0x1
      e6:	03e50513          	addi	a0,a0,62 # 1120 <__FUNCTION__.4+0x40>
      ea:	00001097          	auipc	ra,0x1
      ee:	e32080e7          	jalr	-462(ra) # f1c <printf>
        tyield();
      f2:	00000097          	auipc	ra,0x0
      f6:	77a080e7          	jalr	1914(ra) # 86c <tyield>
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
     10c:	00000097          	auipc	ra,0x0
     110:	760080e7          	jalr	1888(ra) # 86c <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     114:	00000097          	auipc	ra,0x0
     118:	770080e7          	jalr	1904(ra) # 884 <twhoami>
     11c:	00002497          	auipc	s1,0x2
     120:	ee448493          	addi	s1,s1,-284 # 2000 <shared_state>
     124:	00001917          	auipc	s2,0x1
     128:	11490913          	addi	s2,s2,276 # 1238 <__FUNCTION__.6>
     12c:	4094                	lw	a3,0(s1)
     12e:	0005061b          	sext.w	a2,a0
     132:	85ca                	mv	a1,s2
     134:	00001517          	auipc	a0,0x1
     138:	fec50513          	addi	a0,a0,-20 # 1120 <__FUNCTION__.4+0x40>
     13c:	00001097          	auipc	ra,0x1
     140:	de0080e7          	jalr	-544(ra) # f1c <printf>
        shared_state += args.b;
     144:	409c                	lw	a5,0(s1)
     146:	013787bb          	addw	a5,a5,s3
     14a:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     14c:	00000097          	auipc	ra,0x0
     150:	738080e7          	jalr	1848(ra) # 884 <twhoami>
     154:	4094                	lw	a3,0(s1)
     156:	0005061b          	sext.w	a2,a0
     15a:	85ca                	mv	a1,s2
     15c:	00001517          	auipc	a0,0x1
     160:	fc450513          	addi	a0,a0,-60 # 1120 <__FUNCTION__.4+0x40>
     164:	00001097          	auipc	ra,0x1
     168:	db8080e7          	jalr	-584(ra) # f1c <printf>
        tyield();
     16c:	00000097          	auipc	ra,0x0
     170:	700080e7          	jalr	1792(ra) # 86c <tyield>
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
     18e:	00000097          	auipc	ra,0x0
     192:	6f6080e7          	jalr	1782(ra) # 884 <twhoami>
     196:	00002497          	auipc	s1,0x2
     19a:	e6a48493          	addi	s1,s1,-406 # 2000 <shared_state>
     19e:	4094                	lw	a3,0(s1)
     1a0:	0005061b          	sext.w	a2,a0
     1a4:	00001597          	auipc	a1,0x1
     1a8:	0a458593          	addi	a1,a1,164 # 1248 <__FUNCTION__.5>
     1ac:	00001517          	auipc	a0,0x1
     1b0:	f7450513          	addi	a0,a0,-140 # 1120 <__FUNCTION__.4+0x40>
     1b4:	00001097          	auipc	ra,0x1
     1b8:	d68080e7          	jalr	-664(ra) # f1c <printf>
    acquire(&shared_state_lock);
     1bc:	00002517          	auipc	a0,0x2
     1c0:	e6450513          	addi	a0,a0,-412 # 2020 <shared_state_lock>
     1c4:	00000097          	auipc	ra,0x0
     1c8:	56a080e7          	jalr	1386(ra) # 72e <acquire>
    if (shared_state == 0)
     1cc:	409c                	lw	a5,0(s1)
     1ce:	e3d1                	bnez	a5,252 <no_race_for_state+0xdc>
        tyield();
     1d0:	00000097          	auipc	ra,0x0
     1d4:	69c080e7          	jalr	1692(ra) # 86c <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     1d8:	00000097          	auipc	ra,0x0
     1dc:	6ac080e7          	jalr	1708(ra) # 884 <twhoami>
     1e0:	00001917          	auipc	s2,0x1
     1e4:	06890913          	addi	s2,s2,104 # 1248 <__FUNCTION__.5>
     1e8:	4094                	lw	a3,0(s1)
     1ea:	0005061b          	sext.w	a2,a0
     1ee:	85ca                	mv	a1,s2
     1f0:	00001517          	auipc	a0,0x1
     1f4:	f3050513          	addi	a0,a0,-208 # 1120 <__FUNCTION__.4+0x40>
     1f8:	00001097          	auipc	ra,0x1
     1fc:	d24080e7          	jalr	-732(ra) # f1c <printf>
        shared_state += args.a;
     200:	409c                	lw	a5,0(s1)
     202:	014787bb          	addw	a5,a5,s4
     206:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     208:	00000097          	auipc	ra,0x0
     20c:	67c080e7          	jalr	1660(ra) # 884 <twhoami>
     210:	4094                	lw	a3,0(s1)
     212:	0005061b          	sext.w	a2,a0
     216:	85ca                	mv	a1,s2
     218:	00001517          	auipc	a0,0x1
     21c:	f0850513          	addi	a0,a0,-248 # 1120 <__FUNCTION__.4+0x40>
     220:	00001097          	auipc	ra,0x1
     224:	cfc080e7          	jalr	-772(ra) # f1c <printf>
        tyield();
     228:	00000097          	auipc	ra,0x0
     22c:	644080e7          	jalr	1604(ra) # 86c <tyield>
    release(&shared_state_lock);
     230:	00002517          	auipc	a0,0x2
     234:	df050513          	addi	a0,a0,-528 # 2020 <shared_state_lock>
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
     256:	61a080e7          	jalr	1562(ra) # 86c <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     25a:	00000097          	auipc	ra,0x0
     25e:	62a080e7          	jalr	1578(ra) # 884 <twhoami>
     262:	00002497          	auipc	s1,0x2
     266:	d9e48493          	addi	s1,s1,-610 # 2000 <shared_state>
     26a:	00001917          	auipc	s2,0x1
     26e:	fde90913          	addi	s2,s2,-34 # 1248 <__FUNCTION__.5>
     272:	4094                	lw	a3,0(s1)
     274:	0005061b          	sext.w	a2,a0
     278:	85ca                	mv	a1,s2
     27a:	00001517          	auipc	a0,0x1
     27e:	ea650513          	addi	a0,a0,-346 # 1120 <__FUNCTION__.4+0x40>
     282:	00001097          	auipc	ra,0x1
     286:	c9a080e7          	jalr	-870(ra) # f1c <printf>
        shared_state += args.b;
     28a:	409c                	lw	a5,0(s1)
     28c:	013787bb          	addw	a5,a5,s3
     290:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     292:	00000097          	auipc	ra,0x0
     296:	5f2080e7          	jalr	1522(ra) # 884 <twhoami>
     29a:	4094                	lw	a3,0(s1)
     29c:	0005061b          	sext.w	a2,a0
     2a0:	85ca                	mv	a1,s2
     2a2:	00001517          	auipc	a0,0x1
     2a6:	e7e50513          	addi	a0,a0,-386 # 1120 <__FUNCTION__.4+0x40>
     2aa:	00001097          	auipc	ra,0x1
     2ae:	c72080e7          	jalr	-910(ra) # f1c <printf>
        tyield();
     2b2:	00000097          	auipc	ra,0x0
     2b6:	5ba080e7          	jalr	1466(ra) # 86c <tyield>
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
     2d8:	e5c50513          	addi	a0,a0,-420 # 1130 <__FUNCTION__.4+0x50>
     2dc:	00001097          	auipc	ra,0x1
     2e0:	c40080e7          	jalr	-960(ra) # f1c <printf>
    int *result = (int *)malloc(sizeof(int));
     2e4:	4511                	li	a0,4
     2e6:	00001097          	auipc	ra,0x1
     2ea:	cee080e7          	jalr	-786(ra) # fd4 <malloc>
     2ee:	892a                	mv	s2,a0
    *result = args.a + args.b;
     2f0:	013485bb          	addw	a1,s1,s3
     2f4:	c10c                	sw	a1,0(a0)
    printf("child result: %d\n", *result);
     2f6:	2581                	sext.w	a1,a1
     2f8:	00001517          	auipc	a0,0x1
     2fc:	e5050513          	addi	a0,a0,-432 # 1148 <__FUNCTION__.4+0x68>
     300:	00001097          	auipc	ra,0x1
     304:	c1c080e7          	jalr	-996(ra) # f1c <printf>
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
     324:	dc058593          	addi	a1,a1,-576 # 10e0 <__FUNCTION__.4>
     328:	00001517          	auipc	a0,0x1
     32c:	e3850513          	addi	a0,a0,-456 # 1160 <__FUNCTION__.4+0x80>
     330:	00001097          	auipc	ra,0x1
     334:	bec080e7          	jalr	-1044(ra) # f1c <printf>
    struct thread *t;
    tcreate(&t, 0, &print_hello_world, 0);
     338:	4681                	li	a3,0
     33a:	00000617          	auipc	a2,0x0
     33e:	cc660613          	addi	a2,a2,-826 # 0 <print_hello_world>
     342:	4581                	li	a1,0
     344:	fe840513          	addi	a0,s0,-24
     348:	00000097          	auipc	ra,0x0
     34c:	4d6080e7          	jalr	1238(ra) # 81e <tcreate>
    tyield();
     350:	00000097          	auipc	ra,0x0
     354:	51c080e7          	jalr	1308(ra) # 86c <tyield>
    printf("[%s exit]\n", __FUNCTION__);
     358:	00001597          	auipc	a1,0x1
     35c:	d8858593          	addi	a1,a1,-632 # 10e0 <__FUNCTION__.4>
     360:	00001517          	auipc	a0,0x1
     364:	e1050513          	addi	a0,a0,-496 # 1170 <__FUNCTION__.4+0x90>
     368:	00001097          	auipc	ra,0x1
     36c:	bb4080e7          	jalr	-1100(ra) # f1c <printf>
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
     38c:	d5058593          	addi	a1,a1,-688 # 10d8 <__FUNCTION__.3>
     390:	00001517          	auipc	a0,0x1
     394:	dd050513          	addi	a0,a0,-560 # 1160 <__FUNCTION__.4+0x80>
     398:	00001097          	auipc	ra,0x1
     39c:	b84080e7          	jalr	-1148(ra) # f1c <printf>
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
     3de:	444080e7          	jalr	1092(ra) # 81e <tcreate>
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
     3f6:	46c080e7          	jalr	1132(ra) # 85e <tjoin>
    for (int i = 0; i < 8; i++)
     3fa:	04a1                	addi	s1,s1,8
     3fc:	ff3496e3          	bne	s1,s3,3e8 <test2+0x70>
    }
    printf("[%s exit]\n", __FUNCTION__);
     400:	00001597          	auipc	a1,0x1
     404:	cd858593          	addi	a1,a1,-808 # 10d8 <__FUNCTION__.3>
     408:	00001517          	auipc	a0,0x1
     40c:	d6850513          	addi	a0,a0,-664 # 1170 <__FUNCTION__.4+0x90>
     410:	00001097          	auipc	ra,0x1
     414:	b0c080e7          	jalr	-1268(ra) # f1c <printf>
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
     434:	ca058593          	addi	a1,a1,-864 # 10d0 <__FUNCTION__.2>
     438:	00001517          	auipc	a0,0x1
     43c:	d2850513          	addi	a0,a0,-728 # 1160 <__FUNCTION__.4+0x80>
     440:	00001097          	auipc	ra,0x1
     444:	adc080e7          	jalr	-1316(ra) # f1c <printf>
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
     47a:	3a8080e7          	jalr	936(ra) # 81e <tcreate>
    int result;
    tjoin(t->tid, &result, sizeof(int));
     47e:	4611                	li	a2,4
     480:	fd440593          	addi	a1,s0,-44
     484:	fe843783          	ld	a5,-24(s0)
     488:	0007c503          	lbu	a0,0(a5)
     48c:	00000097          	auipc	ra,0x0
     490:	3d2080e7          	jalr	978(ra) # 85e <tjoin>
    printf("parent result: %d\n", result);
     494:	fd442583          	lw	a1,-44(s0)
     498:	00001517          	auipc	a0,0x1
     49c:	ce850513          	addi	a0,a0,-792 # 1180 <__FUNCTION__.4+0xa0>
     4a0:	00001097          	auipc	ra,0x1
     4a4:	a7c080e7          	jalr	-1412(ra) # f1c <printf>
    printf("[%s exit]\n", __FUNCTION__);
     4a8:	00001597          	auipc	a1,0x1
     4ac:	c2858593          	addi	a1,a1,-984 # 10d0 <__FUNCTION__.2>
     4b0:	00001517          	auipc	a0,0x1
     4b4:	cc050513          	addi	a0,a0,-832 # 1170 <__FUNCTION__.4+0x90>
     4b8:	00001097          	auipc	ra,0x1
     4bc:	a64080e7          	jalr	-1436(ra) # f1c <printf>
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
     4d4:	bf858593          	addi	a1,a1,-1032 # 10c8 <__FUNCTION__.1>
     4d8:	00001517          	auipc	a0,0x1
     4dc:	c8850513          	addi	a0,a0,-888 # 1160 <__FUNCTION__.4+0x80>
     4e0:	00001097          	auipc	ra,0x1
     4e4:	a3c080e7          	jalr	-1476(ra) # f1c <printf>
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
     50a:	318080e7          	jalr	792(ra) # 81e <tcreate>
    tcreate(&tb, 0, &race_for_state, &args);
     50e:	fd840693          	addi	a3,s0,-40
     512:	00000617          	auipc	a2,0x0
     516:	b3e60613          	addi	a2,a2,-1218 # 50 <race_for_state>
     51a:	4581                	li	a1,0
     51c:	fe040513          	addi	a0,s0,-32
     520:	00000097          	auipc	ra,0x0
     524:	2fe080e7          	jalr	766(ra) # 81e <tcreate>
    tyield();
     528:	00000097          	auipc	ra,0x0
     52c:	344080e7          	jalr	836(ra) # 86c <tyield>
    tjoin(ta->tid, 0, 0);
     530:	4601                	li	a2,0
     532:	4581                	li	a1,0
     534:	fe843783          	ld	a5,-24(s0)
     538:	0007c503          	lbu	a0,0(a5)
     53c:	00000097          	auipc	ra,0x0
     540:	322080e7          	jalr	802(ra) # 85e <tjoin>
    tjoin(tb->tid, 0, 0);
     544:	4601                	li	a2,0
     546:	4581                	li	a1,0
     548:	fe043783          	ld	a5,-32(s0)
     54c:	0007c503          	lbu	a0,0(a5)
     550:	00000097          	auipc	ra,0x0
     554:	30e080e7          	jalr	782(ra) # 85e <tjoin>
    printf("[%s exit]\n", __FUNCTION__);
     558:	00001597          	auipc	a1,0x1
     55c:	b7058593          	addi	a1,a1,-1168 # 10c8 <__FUNCTION__.1>
     560:	00001517          	auipc	a0,0x1
     564:	c1050513          	addi	a0,a0,-1008 # 1170 <__FUNCTION__.4+0x90>
     568:	00001097          	auipc	ra,0x1
     56c:	9b4080e7          	jalr	-1612(ra) # f1c <printf>
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
     584:	b4058593          	addi	a1,a1,-1216 # 10c0 <__FUNCTION__.0>
     588:	00001517          	auipc	a0,0x1
     58c:	bd850513          	addi	a0,a0,-1064 # 1160 <__FUNCTION__.4+0x80>
     590:	00001097          	auipc	ra,0x1
     594:	98c080e7          	jalr	-1652(ra) # f1c <printf>
    initlock(&shared_state_lock, "sharedstate lock");
     598:	00001597          	auipc	a1,0x1
     59c:	c0058593          	addi	a1,a1,-1024 # 1198 <__FUNCTION__.4+0xb8>
     5a0:	00002517          	auipc	a0,0x2
     5a4:	a8050513          	addi	a0,a0,-1408 # 2020 <shared_state_lock>
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
     5d2:	250080e7          	jalr	592(ra) # 81e <tcreate>
    tcreate(&tb, 0, &no_race_for_state, &args);
     5d6:	fd840693          	addi	a3,s0,-40
     5da:	00000617          	auipc	a2,0x0
     5de:	b9c60613          	addi	a2,a2,-1124 # 176 <no_race_for_state>
     5e2:	4581                	li	a1,0
     5e4:	fe040513          	addi	a0,s0,-32
     5e8:	00000097          	auipc	ra,0x0
     5ec:	236080e7          	jalr	566(ra) # 81e <tcreate>
    tyield();
     5f0:	00000097          	auipc	ra,0x0
     5f4:	27c080e7          	jalr	636(ra) # 86c <tyield>
    tjoin(ta->tid, 0, 0);
     5f8:	4601                	li	a2,0
     5fa:	4581                	li	a1,0
     5fc:	fe843783          	ld	a5,-24(s0)
     600:	0007c503          	lbu	a0,0(a5)
     604:	00000097          	auipc	ra,0x0
     608:	25a080e7          	jalr	602(ra) # 85e <tjoin>
    tjoin(tb->tid, 0, 0);
     60c:	4601                	li	a2,0
     60e:	4581                	li	a1,0
     610:	fe043783          	ld	a5,-32(s0)
     614:	0007c503          	lbu	a0,0(a5)
     618:	00000097          	auipc	ra,0x0
     61c:	246080e7          	jalr	582(ra) # 85e <tjoin>
    printf("[%s exit]\n", __FUNCTION__);
     620:	00001597          	auipc	a1,0x1
     624:	aa058593          	addi	a1,a1,-1376 # 10c0 <__FUNCTION__.0>
     628:	00001517          	auipc	a0,0x1
     62c:	b4850513          	addi	a0,a0,-1208 # 1170 <__FUNCTION__.4+0x90>
     630:	00001097          	auipc	ra,0x1
     634:	8ec080e7          	jalr	-1812(ra) # f1c <printf>
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
     658:	44e080e7          	jalr	1102(ra) # aa2 <atoi>
     65c:	4795                	li	a5,5
     65e:	06a7e763          	bltu	a5,a0,6cc <main+0x8c>
     662:	050a                	slli	a0,a0,0x2
     664:	00001717          	auipc	a4,0x1
     668:	bbc70713          	addi	a4,a4,-1092 # 1220 <__FUNCTION__.4+0x140>
     66c:	953a                	add	a0,a0,a4
     66e:	411c                	lw	a5,0(a0)
     670:	97ba                	add	a5,a5,a4
     672:	8782                	jr	a5
        printf("ttest TEST_ID\n TEST ID\tId of the test to run. ID can be any value from 1 to 5\n");
     674:	00001517          	auipc	a0,0x1
     678:	b3c50513          	addi	a0,a0,-1220 # 11b0 <__FUNCTION__.4+0xd0>
     67c:	00001097          	auipc	ra,0x1
     680:	8a0080e7          	jalr	-1888(ra) # f1c <printf>
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
     6d2:	b3250513          	addi	a0,a0,-1230 # 1200 <__FUNCTION__.4+0x120>
     6d6:	00001097          	auipc	ra,0x1
     6da:	846080e7          	jalr	-1978(ra) # f1c <printf>
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
     716:	172080e7          	jalr	370(ra) # 884 <twhoami>
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
     762:	b0250513          	addi	a0,a0,-1278 # 1260 <__FUNCTION__.5+0x18>
     766:	00000097          	auipc	ra,0x0
     76a:	7b6080e7          	jalr	1974(ra) # f1c <printf>
        exit(-1);
     76e:	557d                	li	a0,-1
     770:	00000097          	auipc	ra,0x0
     774:	42c080e7          	jalr	1068(ra) # b9c <exit>
    {
        // give up the cpu for other threads
        tyield();
     778:	00000097          	auipc	ra,0x0
     77c:	0f4080e7          	jalr	244(ra) # 86c <tyield>
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
     796:	0f2080e7          	jalr	242(ra) # 884 <twhoami>
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
     7da:	096080e7          	jalr	150(ra) # 86c <tyield>
}
     7de:	60e2                	ld	ra,24(sp)
     7e0:	6442                	ld	s0,16(sp)
     7e2:	64a2                	ld	s1,8(sp)
     7e4:	6105                	addi	sp,sp,32
     7e6:	8082                	ret
        printf("releasing lock we are not holding");
     7e8:	00001517          	auipc	a0,0x1
     7ec:	aa050513          	addi	a0,a0,-1376 # 1288 <__FUNCTION__.5+0x40>
     7f0:	00000097          	auipc	ra,0x0
     7f4:	72c080e7          	jalr	1836(ra) # f1c <printf>
        exit(-1);
     7f8:	557d                	li	a0,-1
     7fa:	00000097          	auipc	ra,0x0
     7fe:	3a2080e7          	jalr	930(ra) # b9c <exit>

0000000000000802 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
     802:	1141                	addi	sp,sp,-16
     804:	e422                	sd	s0,8(sp)
     806:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
     808:	00002717          	auipc	a4,0x2
     80c:	80073703          	ld	a4,-2048(a4) # 2008 <current_thread>
     810:	47c1                	li	a5,16
     812:	c319                	beqz	a4,818 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
     814:	37fd                	addiw	a5,a5,-1
     816:	fff5                	bnez	a5,812 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
     818:	6422                	ld	s0,8(sp)
     81a:	0141                	addi	sp,sp,16
     81c:	8082                	ret

000000000000081e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     81e:	7179                	addi	sp,sp,-48
     820:	f406                	sd	ra,40(sp)
     822:	f022                	sd	s0,32(sp)
     824:	ec26                	sd	s1,24(sp)
     826:	e84a                	sd	s2,16(sp)
     828:	e44e                	sd	s3,8(sp)
     82a:	1800                	addi	s0,sp,48
     82c:	84aa                	mv	s1,a0
     82e:	89b2                	mv	s3,a2
     830:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     832:	09000513          	li	a0,144
     836:	00000097          	auipc	ra,0x0
     83a:	79e080e7          	jalr	1950(ra) # fd4 <malloc>
     83e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     840:	478d                	li	a5,3
     842:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     844:	609c                	ld	a5,0(s1)
     846:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
     84a:	609c                	ld	a5,0(s1)
     84c:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
     850:	70a2                	ld	ra,40(sp)
     852:	7402                	ld	s0,32(sp)
     854:	64e2                	ld	s1,24(sp)
     856:	6942                	ld	s2,16(sp)
     858:	69a2                	ld	s3,8(sp)
     85a:	6145                	addi	sp,sp,48
     85c:	8082                	ret

000000000000085e <tjoin>:

int tjoin(int tid, void *status, uint size)
{
     85e:	1141                	addi	sp,sp,-16
     860:	e422                	sd	s0,8(sp)
     862:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
     864:	4501                	li	a0,0
     866:	6422                	ld	s0,8(sp)
     868:	0141                	addi	sp,sp,16
     86a:	8082                	ret

000000000000086c <tyield>:

void tyield()
{
     86c:	1141                	addi	sp,sp,-16
     86e:	e422                	sd	s0,8(sp)
     870:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
     872:	00001797          	auipc	a5,0x1
     876:	7967b783          	ld	a5,1942(a5) # 2008 <current_thread>
     87a:	470d                	li	a4,3
     87c:	dfb8                	sw	a4,120(a5)
    tsched();
}
     87e:	6422                	ld	s0,8(sp)
     880:	0141                	addi	sp,sp,16
     882:	8082                	ret

0000000000000884 <twhoami>:

uint8 twhoami()
{
     884:	1141                	addi	sp,sp,-16
     886:	e422                	sd	s0,8(sp)
     888:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
     88a:	4501                	li	a0,0
     88c:	6422                	ld	s0,8(sp)
     88e:	0141                	addi	sp,sp,16
     890:	8082                	ret

0000000000000892 <tswtch>:
     892:	00153023          	sd	ra,0(a0)
     896:	00253423          	sd	sp,8(a0)
     89a:	e900                	sd	s0,16(a0)
     89c:	ed04                	sd	s1,24(a0)
     89e:	03253023          	sd	s2,32(a0)
     8a2:	03353423          	sd	s3,40(a0)
     8a6:	03453823          	sd	s4,48(a0)
     8aa:	03553c23          	sd	s5,56(a0)
     8ae:	05653023          	sd	s6,64(a0)
     8b2:	05753423          	sd	s7,72(a0)
     8b6:	05853823          	sd	s8,80(a0)
     8ba:	05953c23          	sd	s9,88(a0)
     8be:	07a53023          	sd	s10,96(a0)
     8c2:	07b53423          	sd	s11,104(a0)
     8c6:	0005b083          	ld	ra,0(a1)
     8ca:	0085b103          	ld	sp,8(a1)
     8ce:	6980                	ld	s0,16(a1)
     8d0:	6d84                	ld	s1,24(a1)
     8d2:	0205b903          	ld	s2,32(a1)
     8d6:	0285b983          	ld	s3,40(a1)
     8da:	0305ba03          	ld	s4,48(a1)
     8de:	0385ba83          	ld	s5,56(a1)
     8e2:	0405bb03          	ld	s6,64(a1)
     8e6:	0485bb83          	ld	s7,72(a1)
     8ea:	0505bc03          	ld	s8,80(a1)
     8ee:	0585bc83          	ld	s9,88(a1)
     8f2:	0605bd03          	ld	s10,96(a1)
     8f6:	0685bd83          	ld	s11,104(a1)
     8fa:	8082                	ret

00000000000008fc <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     8fc:	1101                	addi	sp,sp,-32
     8fe:	ec06                	sd	ra,24(sp)
     900:	e822                	sd	s0,16(sp)
     902:	e426                	sd	s1,8(sp)
     904:	e04a                	sd	s2,0(sp)
     906:	1000                	addi	s0,sp,32
     908:	84aa                	mv	s1,a0
     90a:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     90c:	09000513          	li	a0,144
     910:	00000097          	auipc	ra,0x0
     914:	6c4080e7          	jalr	1732(ra) # fd4 <malloc>

    main_thread->tid = 0;
     918:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     91c:	85ca                	mv	a1,s2
     91e:	8526                	mv	a0,s1
     920:	00000097          	auipc	ra,0x0
     924:	d20080e7          	jalr	-736(ra) # 640 <main>
    exit(res);
     928:	00000097          	auipc	ra,0x0
     92c:	274080e7          	jalr	628(ra) # b9c <exit>

0000000000000930 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     930:	1141                	addi	sp,sp,-16
     932:	e422                	sd	s0,8(sp)
     934:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
     936:	87aa                	mv	a5,a0
     938:	0585                	addi	a1,a1,1
     93a:	0785                	addi	a5,a5,1
     93c:	fff5c703          	lbu	a4,-1(a1)
     940:	fee78fa3          	sb	a4,-1(a5)
     944:	fb75                	bnez	a4,938 <strcpy+0x8>
        ;
    return os;
}
     946:	6422                	ld	s0,8(sp)
     948:	0141                	addi	sp,sp,16
     94a:	8082                	ret

000000000000094c <strcmp>:

int strcmp(const char *p, const char *q)
{
     94c:	1141                	addi	sp,sp,-16
     94e:	e422                	sd	s0,8(sp)
     950:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
     952:	00054783          	lbu	a5,0(a0)
     956:	cb91                	beqz	a5,96a <strcmp+0x1e>
     958:	0005c703          	lbu	a4,0(a1)
     95c:	00f71763          	bne	a4,a5,96a <strcmp+0x1e>
        p++, q++;
     960:	0505                	addi	a0,a0,1
     962:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
     964:	00054783          	lbu	a5,0(a0)
     968:	fbe5                	bnez	a5,958 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
     96a:	0005c503          	lbu	a0,0(a1)
}
     96e:	40a7853b          	subw	a0,a5,a0
     972:	6422                	ld	s0,8(sp)
     974:	0141                	addi	sp,sp,16
     976:	8082                	ret

0000000000000978 <strlen>:

uint strlen(const char *s)
{
     978:	1141                	addi	sp,sp,-16
     97a:	e422                	sd	s0,8(sp)
     97c:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
     97e:	00054783          	lbu	a5,0(a0)
     982:	cf91                	beqz	a5,99e <strlen+0x26>
     984:	0505                	addi	a0,a0,1
     986:	87aa                	mv	a5,a0
     988:	86be                	mv	a3,a5
     98a:	0785                	addi	a5,a5,1
     98c:	fff7c703          	lbu	a4,-1(a5)
     990:	ff65                	bnez	a4,988 <strlen+0x10>
     992:	40a6853b          	subw	a0,a3,a0
     996:	2505                	addiw	a0,a0,1
        ;
    return n;
}
     998:	6422                	ld	s0,8(sp)
     99a:	0141                	addi	sp,sp,16
     99c:	8082                	ret
    for (n = 0; s[n]; n++)
     99e:	4501                	li	a0,0
     9a0:	bfe5                	j	998 <strlen+0x20>

00000000000009a2 <memset>:

void *
memset(void *dst, int c, uint n)
{
     9a2:	1141                	addi	sp,sp,-16
     9a4:	e422                	sd	s0,8(sp)
     9a6:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
     9a8:	ca19                	beqz	a2,9be <memset+0x1c>
     9aa:	87aa                	mv	a5,a0
     9ac:	1602                	slli	a2,a2,0x20
     9ae:	9201                	srli	a2,a2,0x20
     9b0:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
     9b4:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
     9b8:	0785                	addi	a5,a5,1
     9ba:	fee79de3          	bne	a5,a4,9b4 <memset+0x12>
    }
    return dst;
}
     9be:	6422                	ld	s0,8(sp)
     9c0:	0141                	addi	sp,sp,16
     9c2:	8082                	ret

00000000000009c4 <strchr>:

char *
strchr(const char *s, char c)
{
     9c4:	1141                	addi	sp,sp,-16
     9c6:	e422                	sd	s0,8(sp)
     9c8:	0800                	addi	s0,sp,16
    for (; *s; s++)
     9ca:	00054783          	lbu	a5,0(a0)
     9ce:	cb99                	beqz	a5,9e4 <strchr+0x20>
        if (*s == c)
     9d0:	00f58763          	beq	a1,a5,9de <strchr+0x1a>
    for (; *s; s++)
     9d4:	0505                	addi	a0,a0,1
     9d6:	00054783          	lbu	a5,0(a0)
     9da:	fbfd                	bnez	a5,9d0 <strchr+0xc>
            return (char *)s;
    return 0;
     9dc:	4501                	li	a0,0
}
     9de:	6422                	ld	s0,8(sp)
     9e0:	0141                	addi	sp,sp,16
     9e2:	8082                	ret
    return 0;
     9e4:	4501                	li	a0,0
     9e6:	bfe5                	j	9de <strchr+0x1a>

00000000000009e8 <gets>:

char *
gets(char *buf, int max)
{
     9e8:	711d                	addi	sp,sp,-96
     9ea:	ec86                	sd	ra,88(sp)
     9ec:	e8a2                	sd	s0,80(sp)
     9ee:	e4a6                	sd	s1,72(sp)
     9f0:	e0ca                	sd	s2,64(sp)
     9f2:	fc4e                	sd	s3,56(sp)
     9f4:	f852                	sd	s4,48(sp)
     9f6:	f456                	sd	s5,40(sp)
     9f8:	f05a                	sd	s6,32(sp)
     9fa:	ec5e                	sd	s7,24(sp)
     9fc:	1080                	addi	s0,sp,96
     9fe:	8baa                	mv	s7,a0
     a00:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
     a02:	892a                	mv	s2,a0
     a04:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
     a06:	4aa9                	li	s5,10
     a08:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
     a0a:	89a6                	mv	s3,s1
     a0c:	2485                	addiw	s1,s1,1
     a0e:	0344d863          	bge	s1,s4,a3e <gets+0x56>
        cc = read(0, &c, 1);
     a12:	4605                	li	a2,1
     a14:	faf40593          	addi	a1,s0,-81
     a18:	4501                	li	a0,0
     a1a:	00000097          	auipc	ra,0x0
     a1e:	19a080e7          	jalr	410(ra) # bb4 <read>
        if (cc < 1)
     a22:	00a05e63          	blez	a0,a3e <gets+0x56>
        buf[i++] = c;
     a26:	faf44783          	lbu	a5,-81(s0)
     a2a:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
     a2e:	01578763          	beq	a5,s5,a3c <gets+0x54>
     a32:	0905                	addi	s2,s2,1
     a34:	fd679be3          	bne	a5,s6,a0a <gets+0x22>
    for (i = 0; i + 1 < max;)
     a38:	89a6                	mv	s3,s1
     a3a:	a011                	j	a3e <gets+0x56>
     a3c:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
     a3e:	99de                	add	s3,s3,s7
     a40:	00098023          	sb	zero,0(s3)
    return buf;
}
     a44:	855e                	mv	a0,s7
     a46:	60e6                	ld	ra,88(sp)
     a48:	6446                	ld	s0,80(sp)
     a4a:	64a6                	ld	s1,72(sp)
     a4c:	6906                	ld	s2,64(sp)
     a4e:	79e2                	ld	s3,56(sp)
     a50:	7a42                	ld	s4,48(sp)
     a52:	7aa2                	ld	s5,40(sp)
     a54:	7b02                	ld	s6,32(sp)
     a56:	6be2                	ld	s7,24(sp)
     a58:	6125                	addi	sp,sp,96
     a5a:	8082                	ret

0000000000000a5c <stat>:

int stat(const char *n, struct stat *st)
{
     a5c:	1101                	addi	sp,sp,-32
     a5e:	ec06                	sd	ra,24(sp)
     a60:	e822                	sd	s0,16(sp)
     a62:	e426                	sd	s1,8(sp)
     a64:	e04a                	sd	s2,0(sp)
     a66:	1000                	addi	s0,sp,32
     a68:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     a6a:	4581                	li	a1,0
     a6c:	00000097          	auipc	ra,0x0
     a70:	170080e7          	jalr	368(ra) # bdc <open>
    if (fd < 0)
     a74:	02054563          	bltz	a0,a9e <stat+0x42>
     a78:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
     a7a:	85ca                	mv	a1,s2
     a7c:	00000097          	auipc	ra,0x0
     a80:	178080e7          	jalr	376(ra) # bf4 <fstat>
     a84:	892a                	mv	s2,a0
    close(fd);
     a86:	8526                	mv	a0,s1
     a88:	00000097          	auipc	ra,0x0
     a8c:	13c080e7          	jalr	316(ra) # bc4 <close>
    return r;
}
     a90:	854a                	mv	a0,s2
     a92:	60e2                	ld	ra,24(sp)
     a94:	6442                	ld	s0,16(sp)
     a96:	64a2                	ld	s1,8(sp)
     a98:	6902                	ld	s2,0(sp)
     a9a:	6105                	addi	sp,sp,32
     a9c:	8082                	ret
        return -1;
     a9e:	597d                	li	s2,-1
     aa0:	bfc5                	j	a90 <stat+0x34>

0000000000000aa2 <atoi>:

int atoi(const char *s)
{
     aa2:	1141                	addi	sp,sp,-16
     aa4:	e422                	sd	s0,8(sp)
     aa6:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
     aa8:	00054683          	lbu	a3,0(a0)
     aac:	fd06879b          	addiw	a5,a3,-48
     ab0:	0ff7f793          	zext.b	a5,a5
     ab4:	4625                	li	a2,9
     ab6:	02f66863          	bltu	a2,a5,ae6 <atoi+0x44>
     aba:	872a                	mv	a4,a0
    n = 0;
     abc:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
     abe:	0705                	addi	a4,a4,1
     ac0:	0025179b          	slliw	a5,a0,0x2
     ac4:	9fa9                	addw	a5,a5,a0
     ac6:	0017979b          	slliw	a5,a5,0x1
     aca:	9fb5                	addw	a5,a5,a3
     acc:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
     ad0:	00074683          	lbu	a3,0(a4)
     ad4:	fd06879b          	addiw	a5,a3,-48
     ad8:	0ff7f793          	zext.b	a5,a5
     adc:	fef671e3          	bgeu	a2,a5,abe <atoi+0x1c>
    return n;
}
     ae0:	6422                	ld	s0,8(sp)
     ae2:	0141                	addi	sp,sp,16
     ae4:	8082                	ret
    n = 0;
     ae6:	4501                	li	a0,0
     ae8:	bfe5                	j	ae0 <atoi+0x3e>

0000000000000aea <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
     aea:	1141                	addi	sp,sp,-16
     aec:	e422                	sd	s0,8(sp)
     aee:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
     af0:	02b57463          	bgeu	a0,a1,b18 <memmove+0x2e>
    {
        while (n-- > 0)
     af4:	00c05f63          	blez	a2,b12 <memmove+0x28>
     af8:	1602                	slli	a2,a2,0x20
     afa:	9201                	srli	a2,a2,0x20
     afc:	00c507b3          	add	a5,a0,a2
    dst = vdst;
     b00:	872a                	mv	a4,a0
            *dst++ = *src++;
     b02:	0585                	addi	a1,a1,1
     b04:	0705                	addi	a4,a4,1
     b06:	fff5c683          	lbu	a3,-1(a1)
     b0a:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
     b0e:	fee79ae3          	bne	a5,a4,b02 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
     b12:	6422                	ld	s0,8(sp)
     b14:	0141                	addi	sp,sp,16
     b16:	8082                	ret
        dst += n;
     b18:	00c50733          	add	a4,a0,a2
        src += n;
     b1c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
     b1e:	fec05ae3          	blez	a2,b12 <memmove+0x28>
     b22:	fff6079b          	addiw	a5,a2,-1
     b26:	1782                	slli	a5,a5,0x20
     b28:	9381                	srli	a5,a5,0x20
     b2a:	fff7c793          	not	a5,a5
     b2e:	97ba                	add	a5,a5,a4
            *--dst = *--src;
     b30:	15fd                	addi	a1,a1,-1
     b32:	177d                	addi	a4,a4,-1
     b34:	0005c683          	lbu	a3,0(a1)
     b38:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
     b3c:	fee79ae3          	bne	a5,a4,b30 <memmove+0x46>
     b40:	bfc9                	j	b12 <memmove+0x28>

0000000000000b42 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
     b42:	1141                	addi	sp,sp,-16
     b44:	e422                	sd	s0,8(sp)
     b46:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
     b48:	ca05                	beqz	a2,b78 <memcmp+0x36>
     b4a:	fff6069b          	addiw	a3,a2,-1
     b4e:	1682                	slli	a3,a3,0x20
     b50:	9281                	srli	a3,a3,0x20
     b52:	0685                	addi	a3,a3,1
     b54:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
     b56:	00054783          	lbu	a5,0(a0)
     b5a:	0005c703          	lbu	a4,0(a1)
     b5e:	00e79863          	bne	a5,a4,b6e <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
     b62:	0505                	addi	a0,a0,1
        p2++;
     b64:	0585                	addi	a1,a1,1
    while (n-- > 0)
     b66:	fed518e3          	bne	a0,a3,b56 <memcmp+0x14>
    }
    return 0;
     b6a:	4501                	li	a0,0
     b6c:	a019                	j	b72 <memcmp+0x30>
            return *p1 - *p2;
     b6e:	40e7853b          	subw	a0,a5,a4
}
     b72:	6422                	ld	s0,8(sp)
     b74:	0141                	addi	sp,sp,16
     b76:	8082                	ret
    return 0;
     b78:	4501                	li	a0,0
     b7a:	bfe5                	j	b72 <memcmp+0x30>

0000000000000b7c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b7c:	1141                	addi	sp,sp,-16
     b7e:	e406                	sd	ra,8(sp)
     b80:	e022                	sd	s0,0(sp)
     b82:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
     b84:	00000097          	auipc	ra,0x0
     b88:	f66080e7          	jalr	-154(ra) # aea <memmove>
}
     b8c:	60a2                	ld	ra,8(sp)
     b8e:	6402                	ld	s0,0(sp)
     b90:	0141                	addi	sp,sp,16
     b92:	8082                	ret

0000000000000b94 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     b94:	4885                	li	a7,1
 ecall
     b96:	00000073          	ecall
 ret
     b9a:	8082                	ret

0000000000000b9c <exit>:
.global exit
exit:
 li a7, SYS_exit
     b9c:	4889                	li	a7,2
 ecall
     b9e:	00000073          	ecall
 ret
     ba2:	8082                	ret

0000000000000ba4 <wait>:
.global wait
wait:
 li a7, SYS_wait
     ba4:	488d                	li	a7,3
 ecall
     ba6:	00000073          	ecall
 ret
     baa:	8082                	ret

0000000000000bac <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     bac:	4891                	li	a7,4
 ecall
     bae:	00000073          	ecall
 ret
     bb2:	8082                	ret

0000000000000bb4 <read>:
.global read
read:
 li a7, SYS_read
     bb4:	4895                	li	a7,5
 ecall
     bb6:	00000073          	ecall
 ret
     bba:	8082                	ret

0000000000000bbc <write>:
.global write
write:
 li a7, SYS_write
     bbc:	48c1                	li	a7,16
 ecall
     bbe:	00000073          	ecall
 ret
     bc2:	8082                	ret

0000000000000bc4 <close>:
.global close
close:
 li a7, SYS_close
     bc4:	48d5                	li	a7,21
 ecall
     bc6:	00000073          	ecall
 ret
     bca:	8082                	ret

0000000000000bcc <kill>:
.global kill
kill:
 li a7, SYS_kill
     bcc:	4899                	li	a7,6
 ecall
     bce:	00000073          	ecall
 ret
     bd2:	8082                	ret

0000000000000bd4 <exec>:
.global exec
exec:
 li a7, SYS_exec
     bd4:	489d                	li	a7,7
 ecall
     bd6:	00000073          	ecall
 ret
     bda:	8082                	ret

0000000000000bdc <open>:
.global open
open:
 li a7, SYS_open
     bdc:	48bd                	li	a7,15
 ecall
     bde:	00000073          	ecall
 ret
     be2:	8082                	ret

0000000000000be4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     be4:	48c5                	li	a7,17
 ecall
     be6:	00000073          	ecall
 ret
     bea:	8082                	ret

0000000000000bec <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     bec:	48c9                	li	a7,18
 ecall
     bee:	00000073          	ecall
 ret
     bf2:	8082                	ret

0000000000000bf4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     bf4:	48a1                	li	a7,8
 ecall
     bf6:	00000073          	ecall
 ret
     bfa:	8082                	ret

0000000000000bfc <link>:
.global link
link:
 li a7, SYS_link
     bfc:	48cd                	li	a7,19
 ecall
     bfe:	00000073          	ecall
 ret
     c02:	8082                	ret

0000000000000c04 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     c04:	48d1                	li	a7,20
 ecall
     c06:	00000073          	ecall
 ret
     c0a:	8082                	ret

0000000000000c0c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     c0c:	48a5                	li	a7,9
 ecall
     c0e:	00000073          	ecall
 ret
     c12:	8082                	ret

0000000000000c14 <dup>:
.global dup
dup:
 li a7, SYS_dup
     c14:	48a9                	li	a7,10
 ecall
     c16:	00000073          	ecall
 ret
     c1a:	8082                	ret

0000000000000c1c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     c1c:	48ad                	li	a7,11
 ecall
     c1e:	00000073          	ecall
 ret
     c22:	8082                	ret

0000000000000c24 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     c24:	48b1                	li	a7,12
 ecall
     c26:	00000073          	ecall
 ret
     c2a:	8082                	ret

0000000000000c2c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     c2c:	48b5                	li	a7,13
 ecall
     c2e:	00000073          	ecall
 ret
     c32:	8082                	ret

0000000000000c34 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     c34:	48b9                	li	a7,14
 ecall
     c36:	00000073          	ecall
 ret
     c3a:	8082                	ret

0000000000000c3c <ps>:
.global ps
ps:
 li a7, SYS_ps
     c3c:	48d9                	li	a7,22
 ecall
     c3e:	00000073          	ecall
 ret
     c42:	8082                	ret

0000000000000c44 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
     c44:	48dd                	li	a7,23
 ecall
     c46:	00000073          	ecall
 ret
     c4a:	8082                	ret

0000000000000c4c <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
     c4c:	48e1                	li	a7,24
 ecall
     c4e:	00000073          	ecall
 ret
     c52:	8082                	ret

0000000000000c54 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     c54:	1101                	addi	sp,sp,-32
     c56:	ec06                	sd	ra,24(sp)
     c58:	e822                	sd	s0,16(sp)
     c5a:	1000                	addi	s0,sp,32
     c5c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     c60:	4605                	li	a2,1
     c62:	fef40593          	addi	a1,s0,-17
     c66:	00000097          	auipc	ra,0x0
     c6a:	f56080e7          	jalr	-170(ra) # bbc <write>
}
     c6e:	60e2                	ld	ra,24(sp)
     c70:	6442                	ld	s0,16(sp)
     c72:	6105                	addi	sp,sp,32
     c74:	8082                	ret

0000000000000c76 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     c76:	7139                	addi	sp,sp,-64
     c78:	fc06                	sd	ra,56(sp)
     c7a:	f822                	sd	s0,48(sp)
     c7c:	f426                	sd	s1,40(sp)
     c7e:	f04a                	sd	s2,32(sp)
     c80:	ec4e                	sd	s3,24(sp)
     c82:	0080                	addi	s0,sp,64
     c84:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     c86:	c299                	beqz	a3,c8c <printint+0x16>
     c88:	0805c963          	bltz	a1,d1a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     c8c:	2581                	sext.w	a1,a1
  neg = 0;
     c8e:	4881                	li	a7,0
     c90:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     c94:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     c96:	2601                	sext.w	a2,a2
     c98:	00000517          	auipc	a0,0x0
     c9c:	67850513          	addi	a0,a0,1656 # 1310 <digits>
     ca0:	883a                	mv	a6,a4
     ca2:	2705                	addiw	a4,a4,1
     ca4:	02c5f7bb          	remuw	a5,a1,a2
     ca8:	1782                	slli	a5,a5,0x20
     caa:	9381                	srli	a5,a5,0x20
     cac:	97aa                	add	a5,a5,a0
     cae:	0007c783          	lbu	a5,0(a5)
     cb2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     cb6:	0005879b          	sext.w	a5,a1
     cba:	02c5d5bb          	divuw	a1,a1,a2
     cbe:	0685                	addi	a3,a3,1
     cc0:	fec7f0e3          	bgeu	a5,a2,ca0 <printint+0x2a>
  if(neg)
     cc4:	00088c63          	beqz	a7,cdc <printint+0x66>
    buf[i++] = '-';
     cc8:	fd070793          	addi	a5,a4,-48
     ccc:	00878733          	add	a4,a5,s0
     cd0:	02d00793          	li	a5,45
     cd4:	fef70823          	sb	a5,-16(a4)
     cd8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     cdc:	02e05863          	blez	a4,d0c <printint+0x96>
     ce0:	fc040793          	addi	a5,s0,-64
     ce4:	00e78933          	add	s2,a5,a4
     ce8:	fff78993          	addi	s3,a5,-1
     cec:	99ba                	add	s3,s3,a4
     cee:	377d                	addiw	a4,a4,-1
     cf0:	1702                	slli	a4,a4,0x20
     cf2:	9301                	srli	a4,a4,0x20
     cf4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     cf8:	fff94583          	lbu	a1,-1(s2)
     cfc:	8526                	mv	a0,s1
     cfe:	00000097          	auipc	ra,0x0
     d02:	f56080e7          	jalr	-170(ra) # c54 <putc>
  while(--i >= 0)
     d06:	197d                	addi	s2,s2,-1
     d08:	ff3918e3          	bne	s2,s3,cf8 <printint+0x82>
}
     d0c:	70e2                	ld	ra,56(sp)
     d0e:	7442                	ld	s0,48(sp)
     d10:	74a2                	ld	s1,40(sp)
     d12:	7902                	ld	s2,32(sp)
     d14:	69e2                	ld	s3,24(sp)
     d16:	6121                	addi	sp,sp,64
     d18:	8082                	ret
    x = -xx;
     d1a:	40b005bb          	negw	a1,a1
    neg = 1;
     d1e:	4885                	li	a7,1
    x = -xx;
     d20:	bf85                	j	c90 <printint+0x1a>

0000000000000d22 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d22:	715d                	addi	sp,sp,-80
     d24:	e486                	sd	ra,72(sp)
     d26:	e0a2                	sd	s0,64(sp)
     d28:	fc26                	sd	s1,56(sp)
     d2a:	f84a                	sd	s2,48(sp)
     d2c:	f44e                	sd	s3,40(sp)
     d2e:	f052                	sd	s4,32(sp)
     d30:	ec56                	sd	s5,24(sp)
     d32:	e85a                	sd	s6,16(sp)
     d34:	e45e                	sd	s7,8(sp)
     d36:	e062                	sd	s8,0(sp)
     d38:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     d3a:	0005c903          	lbu	s2,0(a1)
     d3e:	18090c63          	beqz	s2,ed6 <vprintf+0x1b4>
     d42:	8aaa                	mv	s5,a0
     d44:	8bb2                	mv	s7,a2
     d46:	00158493          	addi	s1,a1,1
  state = 0;
     d4a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     d4c:	02500a13          	li	s4,37
     d50:	4b55                	li	s6,21
     d52:	a839                	j	d70 <vprintf+0x4e>
        putc(fd, c);
     d54:	85ca                	mv	a1,s2
     d56:	8556                	mv	a0,s5
     d58:	00000097          	auipc	ra,0x0
     d5c:	efc080e7          	jalr	-260(ra) # c54 <putc>
     d60:	a019                	j	d66 <vprintf+0x44>
    } else if(state == '%'){
     d62:	01498d63          	beq	s3,s4,d7c <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
     d66:	0485                	addi	s1,s1,1
     d68:	fff4c903          	lbu	s2,-1(s1)
     d6c:	16090563          	beqz	s2,ed6 <vprintf+0x1b4>
    if(state == 0){
     d70:	fe0999e3          	bnez	s3,d62 <vprintf+0x40>
      if(c == '%'){
     d74:	ff4910e3          	bne	s2,s4,d54 <vprintf+0x32>
        state = '%';
     d78:	89d2                	mv	s3,s4
     d7a:	b7f5                	j	d66 <vprintf+0x44>
      if(c == 'd'){
     d7c:	13490263          	beq	s2,s4,ea0 <vprintf+0x17e>
     d80:	f9d9079b          	addiw	a5,s2,-99
     d84:	0ff7f793          	zext.b	a5,a5
     d88:	12fb6563          	bltu	s6,a5,eb2 <vprintf+0x190>
     d8c:	f9d9079b          	addiw	a5,s2,-99
     d90:	0ff7f713          	zext.b	a4,a5
     d94:	10eb6f63          	bltu	s6,a4,eb2 <vprintf+0x190>
     d98:	00271793          	slli	a5,a4,0x2
     d9c:	00000717          	auipc	a4,0x0
     da0:	51c70713          	addi	a4,a4,1308 # 12b8 <__FUNCTION__.5+0x70>
     da4:	97ba                	add	a5,a5,a4
     da6:	439c                	lw	a5,0(a5)
     da8:	97ba                	add	a5,a5,a4
     daa:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
     dac:	008b8913          	addi	s2,s7,8
     db0:	4685                	li	a3,1
     db2:	4629                	li	a2,10
     db4:	000ba583          	lw	a1,0(s7)
     db8:	8556                	mv	a0,s5
     dba:	00000097          	auipc	ra,0x0
     dbe:	ebc080e7          	jalr	-324(ra) # c76 <printint>
     dc2:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     dc4:	4981                	li	s3,0
     dc6:	b745                	j	d66 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     dc8:	008b8913          	addi	s2,s7,8
     dcc:	4681                	li	a3,0
     dce:	4629                	li	a2,10
     dd0:	000ba583          	lw	a1,0(s7)
     dd4:	8556                	mv	a0,s5
     dd6:	00000097          	auipc	ra,0x0
     dda:	ea0080e7          	jalr	-352(ra) # c76 <printint>
     dde:	8bca                	mv	s7,s2
      state = 0;
     de0:	4981                	li	s3,0
     de2:	b751                	j	d66 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
     de4:	008b8913          	addi	s2,s7,8
     de8:	4681                	li	a3,0
     dea:	4641                	li	a2,16
     dec:	000ba583          	lw	a1,0(s7)
     df0:	8556                	mv	a0,s5
     df2:	00000097          	auipc	ra,0x0
     df6:	e84080e7          	jalr	-380(ra) # c76 <printint>
     dfa:	8bca                	mv	s7,s2
      state = 0;
     dfc:	4981                	li	s3,0
     dfe:	b7a5                	j	d66 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
     e00:	008b8c13          	addi	s8,s7,8
     e04:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     e08:	03000593          	li	a1,48
     e0c:	8556                	mv	a0,s5
     e0e:	00000097          	auipc	ra,0x0
     e12:	e46080e7          	jalr	-442(ra) # c54 <putc>
  putc(fd, 'x');
     e16:	07800593          	li	a1,120
     e1a:	8556                	mv	a0,s5
     e1c:	00000097          	auipc	ra,0x0
     e20:	e38080e7          	jalr	-456(ra) # c54 <putc>
     e24:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     e26:	00000b97          	auipc	s7,0x0
     e2a:	4eab8b93          	addi	s7,s7,1258 # 1310 <digits>
     e2e:	03c9d793          	srli	a5,s3,0x3c
     e32:	97de                	add	a5,a5,s7
     e34:	0007c583          	lbu	a1,0(a5)
     e38:	8556                	mv	a0,s5
     e3a:	00000097          	auipc	ra,0x0
     e3e:	e1a080e7          	jalr	-486(ra) # c54 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     e42:	0992                	slli	s3,s3,0x4
     e44:	397d                	addiw	s2,s2,-1
     e46:	fe0914e3          	bnez	s2,e2e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
     e4a:	8be2                	mv	s7,s8
      state = 0;
     e4c:	4981                	li	s3,0
     e4e:	bf21                	j	d66 <vprintf+0x44>
        s = va_arg(ap, char*);
     e50:	008b8993          	addi	s3,s7,8
     e54:	000bb903          	ld	s2,0(s7)
        if(s == 0)
     e58:	02090163          	beqz	s2,e7a <vprintf+0x158>
        while(*s != 0){
     e5c:	00094583          	lbu	a1,0(s2)
     e60:	c9a5                	beqz	a1,ed0 <vprintf+0x1ae>
          putc(fd, *s);
     e62:	8556                	mv	a0,s5
     e64:	00000097          	auipc	ra,0x0
     e68:	df0080e7          	jalr	-528(ra) # c54 <putc>
          s++;
     e6c:	0905                	addi	s2,s2,1
        while(*s != 0){
     e6e:	00094583          	lbu	a1,0(s2)
     e72:	f9e5                	bnez	a1,e62 <vprintf+0x140>
        s = va_arg(ap, char*);
     e74:	8bce                	mv	s7,s3
      state = 0;
     e76:	4981                	li	s3,0
     e78:	b5fd                	j	d66 <vprintf+0x44>
          s = "(null)";
     e7a:	00000917          	auipc	s2,0x0
     e7e:	43690913          	addi	s2,s2,1078 # 12b0 <__FUNCTION__.5+0x68>
        while(*s != 0){
     e82:	02800593          	li	a1,40
     e86:	bff1                	j	e62 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
     e88:	008b8913          	addi	s2,s7,8
     e8c:	000bc583          	lbu	a1,0(s7)
     e90:	8556                	mv	a0,s5
     e92:	00000097          	auipc	ra,0x0
     e96:	dc2080e7          	jalr	-574(ra) # c54 <putc>
     e9a:	8bca                	mv	s7,s2
      state = 0;
     e9c:	4981                	li	s3,0
     e9e:	b5e1                	j	d66 <vprintf+0x44>
        putc(fd, c);
     ea0:	02500593          	li	a1,37
     ea4:	8556                	mv	a0,s5
     ea6:	00000097          	auipc	ra,0x0
     eaa:	dae080e7          	jalr	-594(ra) # c54 <putc>
      state = 0;
     eae:	4981                	li	s3,0
     eb0:	bd5d                	j	d66 <vprintf+0x44>
        putc(fd, '%');
     eb2:	02500593          	li	a1,37
     eb6:	8556                	mv	a0,s5
     eb8:	00000097          	auipc	ra,0x0
     ebc:	d9c080e7          	jalr	-612(ra) # c54 <putc>
        putc(fd, c);
     ec0:	85ca                	mv	a1,s2
     ec2:	8556                	mv	a0,s5
     ec4:	00000097          	auipc	ra,0x0
     ec8:	d90080e7          	jalr	-624(ra) # c54 <putc>
      state = 0;
     ecc:	4981                	li	s3,0
     ece:	bd61                	j	d66 <vprintf+0x44>
        s = va_arg(ap, char*);
     ed0:	8bce                	mv	s7,s3
      state = 0;
     ed2:	4981                	li	s3,0
     ed4:	bd49                	j	d66 <vprintf+0x44>
    }
  }
}
     ed6:	60a6                	ld	ra,72(sp)
     ed8:	6406                	ld	s0,64(sp)
     eda:	74e2                	ld	s1,56(sp)
     edc:	7942                	ld	s2,48(sp)
     ede:	79a2                	ld	s3,40(sp)
     ee0:	7a02                	ld	s4,32(sp)
     ee2:	6ae2                	ld	s5,24(sp)
     ee4:	6b42                	ld	s6,16(sp)
     ee6:	6ba2                	ld	s7,8(sp)
     ee8:	6c02                	ld	s8,0(sp)
     eea:	6161                	addi	sp,sp,80
     eec:	8082                	ret

0000000000000eee <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     eee:	715d                	addi	sp,sp,-80
     ef0:	ec06                	sd	ra,24(sp)
     ef2:	e822                	sd	s0,16(sp)
     ef4:	1000                	addi	s0,sp,32
     ef6:	e010                	sd	a2,0(s0)
     ef8:	e414                	sd	a3,8(s0)
     efa:	e818                	sd	a4,16(s0)
     efc:	ec1c                	sd	a5,24(s0)
     efe:	03043023          	sd	a6,32(s0)
     f02:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
     f06:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     f0a:	8622                	mv	a2,s0
     f0c:	00000097          	auipc	ra,0x0
     f10:	e16080e7          	jalr	-490(ra) # d22 <vprintf>
}
     f14:	60e2                	ld	ra,24(sp)
     f16:	6442                	ld	s0,16(sp)
     f18:	6161                	addi	sp,sp,80
     f1a:	8082                	ret

0000000000000f1c <printf>:

void
printf(const char *fmt, ...)
{
     f1c:	711d                	addi	sp,sp,-96
     f1e:	ec06                	sd	ra,24(sp)
     f20:	e822                	sd	s0,16(sp)
     f22:	1000                	addi	s0,sp,32
     f24:	e40c                	sd	a1,8(s0)
     f26:	e810                	sd	a2,16(s0)
     f28:	ec14                	sd	a3,24(s0)
     f2a:	f018                	sd	a4,32(s0)
     f2c:	f41c                	sd	a5,40(s0)
     f2e:	03043823          	sd	a6,48(s0)
     f32:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     f36:	00840613          	addi	a2,s0,8
     f3a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
     f3e:	85aa                	mv	a1,a0
     f40:	4505                	li	a0,1
     f42:	00000097          	auipc	ra,0x0
     f46:	de0080e7          	jalr	-544(ra) # d22 <vprintf>
}
     f4a:	60e2                	ld	ra,24(sp)
     f4c:	6442                	ld	s0,16(sp)
     f4e:	6125                	addi	sp,sp,96
     f50:	8082                	ret

0000000000000f52 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
     f52:	1141                	addi	sp,sp,-16
     f54:	e422                	sd	s0,8(sp)
     f56:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
     f58:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f5c:	00001797          	auipc	a5,0x1
     f60:	0b47b783          	ld	a5,180(a5) # 2010 <freep>
     f64:	a02d                	j	f8e <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
     f66:	4618                	lw	a4,8(a2)
     f68:	9f2d                	addw	a4,a4,a1
     f6a:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
     f6e:	6398                	ld	a4,0(a5)
     f70:	6310                	ld	a2,0(a4)
     f72:	a83d                	j	fb0 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
     f74:	ff852703          	lw	a4,-8(a0)
     f78:	9f31                	addw	a4,a4,a2
     f7a:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
     f7c:	ff053683          	ld	a3,-16(a0)
     f80:	a091                	j	fc4 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f82:	6398                	ld	a4,0(a5)
     f84:	00e7e463          	bltu	a5,a4,f8c <free+0x3a>
     f88:	00e6ea63          	bltu	a3,a4,f9c <free+0x4a>
{
     f8c:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f8e:	fed7fae3          	bgeu	a5,a3,f82 <free+0x30>
     f92:	6398                	ld	a4,0(a5)
     f94:	00e6e463          	bltu	a3,a4,f9c <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f98:	fee7eae3          	bltu	a5,a4,f8c <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
     f9c:	ff852583          	lw	a1,-8(a0)
     fa0:	6390                	ld	a2,0(a5)
     fa2:	02059813          	slli	a6,a1,0x20
     fa6:	01c85713          	srli	a4,a6,0x1c
     faa:	9736                	add	a4,a4,a3
     fac:	fae60de3          	beq	a2,a4,f66 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
     fb0:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
     fb4:	4790                	lw	a2,8(a5)
     fb6:	02061593          	slli	a1,a2,0x20
     fba:	01c5d713          	srli	a4,a1,0x1c
     fbe:	973e                	add	a4,a4,a5
     fc0:	fae68ae3          	beq	a3,a4,f74 <free+0x22>
        p->s.ptr = bp->s.ptr;
     fc4:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
     fc6:	00001717          	auipc	a4,0x1
     fca:	04f73523          	sd	a5,74(a4) # 2010 <freep>
}
     fce:	6422                	ld	s0,8(sp)
     fd0:	0141                	addi	sp,sp,16
     fd2:	8082                	ret

0000000000000fd4 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
     fd4:	7139                	addi	sp,sp,-64
     fd6:	fc06                	sd	ra,56(sp)
     fd8:	f822                	sd	s0,48(sp)
     fda:	f426                	sd	s1,40(sp)
     fdc:	f04a                	sd	s2,32(sp)
     fde:	ec4e                	sd	s3,24(sp)
     fe0:	e852                	sd	s4,16(sp)
     fe2:	e456                	sd	s5,8(sp)
     fe4:	e05a                	sd	s6,0(sp)
     fe6:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
     fe8:	02051493          	slli	s1,a0,0x20
     fec:	9081                	srli	s1,s1,0x20
     fee:	04bd                	addi	s1,s1,15
     ff0:	8091                	srli	s1,s1,0x4
     ff2:	0014899b          	addiw	s3,s1,1
     ff6:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
     ff8:	00001517          	auipc	a0,0x1
     ffc:	01853503          	ld	a0,24(a0) # 2010 <freep>
    1000:	c515                	beqz	a0,102c <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    1002:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    1004:	4798                	lw	a4,8(a5)
    1006:	02977f63          	bgeu	a4,s1,1044 <malloc+0x70>
    if (nu < 4096)
    100a:	8a4e                	mv	s4,s3
    100c:	0009871b          	sext.w	a4,s3
    1010:	6685                	lui	a3,0x1
    1012:	00d77363          	bgeu	a4,a3,1018 <malloc+0x44>
    1016:	6a05                	lui	s4,0x1
    1018:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    101c:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    1020:	00001917          	auipc	s2,0x1
    1024:	ff090913          	addi	s2,s2,-16 # 2010 <freep>
    if (p == (char *)-1)
    1028:	5afd                	li	s5,-1
    102a:	a895                	j	109e <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    102c:	00001797          	auipc	a5,0x1
    1030:	00c78793          	addi	a5,a5,12 # 2038 <base>
    1034:	00001717          	auipc	a4,0x1
    1038:	fcf73e23          	sd	a5,-36(a4) # 2010 <freep>
    103c:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    103e:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    1042:	b7e1                	j	100a <malloc+0x36>
            if (p->s.size == nunits)
    1044:	02e48c63          	beq	s1,a4,107c <malloc+0xa8>
                p->s.size -= nunits;
    1048:	4137073b          	subw	a4,a4,s3
    104c:	c798                	sw	a4,8(a5)
                p += p->s.size;
    104e:	02071693          	slli	a3,a4,0x20
    1052:	01c6d713          	srli	a4,a3,0x1c
    1056:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    1058:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    105c:	00001717          	auipc	a4,0x1
    1060:	faa73a23          	sd	a0,-76(a4) # 2010 <freep>
            return (void *)(p + 1);
    1064:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    1068:	70e2                	ld	ra,56(sp)
    106a:	7442                	ld	s0,48(sp)
    106c:	74a2                	ld	s1,40(sp)
    106e:	7902                	ld	s2,32(sp)
    1070:	69e2                	ld	s3,24(sp)
    1072:	6a42                	ld	s4,16(sp)
    1074:	6aa2                	ld	s5,8(sp)
    1076:	6b02                	ld	s6,0(sp)
    1078:	6121                	addi	sp,sp,64
    107a:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    107c:	6398                	ld	a4,0(a5)
    107e:	e118                	sd	a4,0(a0)
    1080:	bff1                	j	105c <malloc+0x88>
    hp->s.size = nu;
    1082:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    1086:	0541                	addi	a0,a0,16
    1088:	00000097          	auipc	ra,0x0
    108c:	eca080e7          	jalr	-310(ra) # f52 <free>
    return freep;
    1090:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    1094:	d971                	beqz	a0,1068 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    1096:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    1098:	4798                	lw	a4,8(a5)
    109a:	fa9775e3          	bgeu	a4,s1,1044 <malloc+0x70>
        if (p == freep)
    109e:	00093703          	ld	a4,0(s2)
    10a2:	853e                	mv	a0,a5
    10a4:	fef719e3          	bne	a4,a5,1096 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    10a8:	8552                	mv	a0,s4
    10aa:	00000097          	auipc	ra,0x0
    10ae:	b7a080e7          	jalr	-1158(ra) # c24 <sbrk>
    if (p == (char *)-1)
    10b2:	fd5518e3          	bne	a0,s5,1082 <malloc+0xae>
                return 0;
    10b6:	4501                	li	a0,0
    10b8:	bf45                	j	1068 <malloc+0x94>
