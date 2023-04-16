
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
       c:	2e850513          	addi	a0,a0,744 # 12f0 <__FUNCTION__.4+0x10>
      10:	00001097          	auipc	ra,0x1
      14:	10e080e7          	jalr	270(ra) # 111e <printf>
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
      2e:	9c4080e7          	jalr	-1596(ra) # 9ee <twhoami>
      32:	0005059b          	sext.w	a1,a0
      36:	00001517          	auipc	a0,0x1
      3a:	2ca50513          	addi	a0,a0,714 # 1300 <__FUNCTION__.4+0x20>
      3e:	00001097          	auipc	ra,0x1
      42:	0e0080e7          	jalr	224(ra) # 111e <printf>
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
      6c:	986080e7          	jalr	-1658(ra) # 9ee <twhoami>
      70:	00002497          	auipc	s1,0x2
      74:	fa048493          	addi	s1,s1,-96 # 2010 <shared_state>
      78:	4094                	lw	a3,0(s1)
      7a:	0005061b          	sext.w	a2,a0
      7e:	00001597          	auipc	a1,0x1
      82:	3ba58593          	addi	a1,a1,954 # 1438 <__FUNCTION__.6>
      86:	00001517          	auipc	a0,0x1
      8a:	29a50513          	addi	a0,a0,666 # 1320 <__FUNCTION__.4+0x40>
      8e:	00001097          	auipc	ra,0x1
      92:	090080e7          	jalr	144(ra) # 111e <printf>
    if (shared_state == 0)
      96:	409c                	lw	a5,0(s1)
      98:	ebb5                	bnez	a5,10c <race_for_state+0xbc>
        tyield();
      9a:	00001097          	auipc	ra,0x1
      9e:	930080e7          	jalr	-1744(ra) # 9ca <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
      a2:	00001097          	auipc	ra,0x1
      a6:	94c080e7          	jalr	-1716(ra) # 9ee <twhoami>
      aa:	00001917          	auipc	s2,0x1
      ae:	38e90913          	addi	s2,s2,910 # 1438 <__FUNCTION__.6>
      b2:	4094                	lw	a3,0(s1)
      b4:	0005061b          	sext.w	a2,a0
      b8:	85ca                	mv	a1,s2
      ba:	00001517          	auipc	a0,0x1
      be:	26650513          	addi	a0,a0,614 # 1320 <__FUNCTION__.4+0x40>
      c2:	00001097          	auipc	ra,0x1
      c6:	05c080e7          	jalr	92(ra) # 111e <printf>
        shared_state += args.a;
      ca:	409c                	lw	a5,0(s1)
      cc:	014787bb          	addw	a5,a5,s4
      d0:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
      d2:	00001097          	auipc	ra,0x1
      d6:	91c080e7          	jalr	-1764(ra) # 9ee <twhoami>
      da:	4094                	lw	a3,0(s1)
      dc:	0005061b          	sext.w	a2,a0
      e0:	85ca                	mv	a1,s2
      e2:	00001517          	auipc	a0,0x1
      e6:	23e50513          	addi	a0,a0,574 # 1320 <__FUNCTION__.4+0x40>
      ea:	00001097          	auipc	ra,0x1
      ee:	034080e7          	jalr	52(ra) # 111e <printf>
        tyield();
      f2:	00001097          	auipc	ra,0x1
      f6:	8d8080e7          	jalr	-1832(ra) # 9ca <tyield>
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
     110:	8be080e7          	jalr	-1858(ra) # 9ca <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     114:	00001097          	auipc	ra,0x1
     118:	8da080e7          	jalr	-1830(ra) # 9ee <twhoami>
     11c:	00002497          	auipc	s1,0x2
     120:	ef448493          	addi	s1,s1,-268 # 2010 <shared_state>
     124:	00001917          	auipc	s2,0x1
     128:	31490913          	addi	s2,s2,788 # 1438 <__FUNCTION__.6>
     12c:	4094                	lw	a3,0(s1)
     12e:	0005061b          	sext.w	a2,a0
     132:	85ca                	mv	a1,s2
     134:	00001517          	auipc	a0,0x1
     138:	1ec50513          	addi	a0,a0,492 # 1320 <__FUNCTION__.4+0x40>
     13c:	00001097          	auipc	ra,0x1
     140:	fe2080e7          	jalr	-30(ra) # 111e <printf>
        shared_state += args.b;
     144:	409c                	lw	a5,0(s1)
     146:	013787bb          	addw	a5,a5,s3
     14a:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     14c:	00001097          	auipc	ra,0x1
     150:	8a2080e7          	jalr	-1886(ra) # 9ee <twhoami>
     154:	4094                	lw	a3,0(s1)
     156:	0005061b          	sext.w	a2,a0
     15a:	85ca                	mv	a1,s2
     15c:	00001517          	auipc	a0,0x1
     160:	1c450513          	addi	a0,a0,452 # 1320 <__FUNCTION__.4+0x40>
     164:	00001097          	auipc	ra,0x1
     168:	fba080e7          	jalr	-70(ra) # 111e <printf>
        tyield();
     16c:	00001097          	auipc	ra,0x1
     170:	85e080e7          	jalr	-1954(ra) # 9ca <tyield>
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
     192:	860080e7          	jalr	-1952(ra) # 9ee <twhoami>
     196:	00002497          	auipc	s1,0x2
     19a:	e7a48493          	addi	s1,s1,-390 # 2010 <shared_state>
     19e:	4094                	lw	a3,0(s1)
     1a0:	0005061b          	sext.w	a2,a0
     1a4:	00001597          	auipc	a1,0x1
     1a8:	2a458593          	addi	a1,a1,676 # 1448 <__FUNCTION__.5>
     1ac:	00001517          	auipc	a0,0x1
     1b0:	17450513          	addi	a0,a0,372 # 1320 <__FUNCTION__.4+0x40>
     1b4:	00001097          	auipc	ra,0x1
     1b8:	f6a080e7          	jalr	-150(ra) # 111e <printf>
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
     1d4:	7fa080e7          	jalr	2042(ra) # 9ca <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     1d8:	00001097          	auipc	ra,0x1
     1dc:	816080e7          	jalr	-2026(ra) # 9ee <twhoami>
     1e0:	00001917          	auipc	s2,0x1
     1e4:	26890913          	addi	s2,s2,616 # 1448 <__FUNCTION__.5>
     1e8:	4094                	lw	a3,0(s1)
     1ea:	0005061b          	sext.w	a2,a0
     1ee:	85ca                	mv	a1,s2
     1f0:	00001517          	auipc	a0,0x1
     1f4:	13050513          	addi	a0,a0,304 # 1320 <__FUNCTION__.4+0x40>
     1f8:	00001097          	auipc	ra,0x1
     1fc:	f26080e7          	jalr	-218(ra) # 111e <printf>
        shared_state += args.a;
     200:	409c                	lw	a5,0(s1)
     202:	014787bb          	addw	a5,a5,s4
     206:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     208:	00000097          	auipc	ra,0x0
     20c:	7e6080e7          	jalr	2022(ra) # 9ee <twhoami>
     210:	4094                	lw	a3,0(s1)
     212:	0005061b          	sext.w	a2,a0
     216:	85ca                	mv	a1,s2
     218:	00001517          	auipc	a0,0x1
     21c:	10850513          	addi	a0,a0,264 # 1320 <__FUNCTION__.4+0x40>
     220:	00001097          	auipc	ra,0x1
     224:	efe080e7          	jalr	-258(ra) # 111e <printf>
        tyield();
     228:	00000097          	auipc	ra,0x0
     22c:	7a2080e7          	jalr	1954(ra) # 9ca <tyield>
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
     256:	778080e7          	jalr	1912(ra) # 9ca <tyield>
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     25a:	00000097          	auipc	ra,0x0
     25e:	794080e7          	jalr	1940(ra) # 9ee <twhoami>
     262:	00002497          	auipc	s1,0x2
     266:	dae48493          	addi	s1,s1,-594 # 2010 <shared_state>
     26a:	00001917          	auipc	s2,0x1
     26e:	1de90913          	addi	s2,s2,478 # 1448 <__FUNCTION__.5>
     272:	4094                	lw	a3,0(s1)
     274:	0005061b          	sext.w	a2,a0
     278:	85ca                	mv	a1,s2
     27a:	00001517          	auipc	a0,0x1
     27e:	0a650513          	addi	a0,a0,166 # 1320 <__FUNCTION__.4+0x40>
     282:	00001097          	auipc	ra,0x1
     286:	e9c080e7          	jalr	-356(ra) # 111e <printf>
        shared_state += args.b;
     28a:	409c                	lw	a5,0(s1)
     28c:	013787bb          	addw	a5,a5,s3
     290:	c09c                	sw	a5,0(s1)
        printf("%s[%d] %d\n", __FUNCTION__, twhoami(), shared_state);
     292:	00000097          	auipc	ra,0x0
     296:	75c080e7          	jalr	1884(ra) # 9ee <twhoami>
     29a:	4094                	lw	a3,0(s1)
     29c:	0005061b          	sext.w	a2,a0
     2a0:	85ca                	mv	a1,s2
     2a2:	00001517          	auipc	a0,0x1
     2a6:	07e50513          	addi	a0,a0,126 # 1320 <__FUNCTION__.4+0x40>
     2aa:	00001097          	auipc	ra,0x1
     2ae:	e74080e7          	jalr	-396(ra) # 111e <printf>
        tyield();
     2b2:	00000097          	auipc	ra,0x0
     2b6:	718080e7          	jalr	1816(ra) # 9ca <tyield>
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
     2d8:	05c50513          	addi	a0,a0,92 # 1330 <__FUNCTION__.4+0x50>
     2dc:	00001097          	auipc	ra,0x1
     2e0:	e42080e7          	jalr	-446(ra) # 111e <printf>
    int *result = (int *)malloc(sizeof(int));
     2e4:	4511                	li	a0,4
     2e6:	00001097          	auipc	ra,0x1
     2ea:	ef0080e7          	jalr	-272(ra) # 11d6 <malloc>
     2ee:	892a                	mv	s2,a0
    *result = args.a + args.b;
     2f0:	013485bb          	addw	a1,s1,s3
     2f4:	c10c                	sw	a1,0(a0)
    printf("child result: %d\n", *result);
     2f6:	2581                	sext.w	a1,a1
     2f8:	00001517          	auipc	a0,0x1
     2fc:	05050513          	addi	a0,a0,80 # 1348 <__FUNCTION__.4+0x68>
     300:	00001097          	auipc	ra,0x1
     304:	e1e080e7          	jalr	-482(ra) # 111e <printf>
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
     324:	fc058593          	addi	a1,a1,-64 # 12e0 <__FUNCTION__.4>
     328:	00001517          	auipc	a0,0x1
     32c:	03850513          	addi	a0,a0,56 # 1360 <__FUNCTION__.4+0x80>
     330:	00001097          	auipc	ra,0x1
     334:	dee080e7          	jalr	-530(ra) # 111e <printf>
    struct thread *t;
    tcreate(&t, 0, &print_hello_world, 0);
     338:	4681                	li	a3,0
     33a:	00000617          	auipc	a2,0x0
     33e:	cc660613          	addi	a2,a2,-826 # 0 <print_hello_world>
     342:	4581                	li	a1,0
     344:	fe840513          	addi	a0,s0,-24
     348:	00000097          	auipc	ra,0x0
     34c:	576080e7          	jalr	1398(ra) # 8be <tcreate>
    tyield();
     350:	00000097          	auipc	ra,0x0
     354:	67a080e7          	jalr	1658(ra) # 9ca <tyield>
    printf("[%s exit]\n", __FUNCTION__);
     358:	00001597          	auipc	a1,0x1
     35c:	f8858593          	addi	a1,a1,-120 # 12e0 <__FUNCTION__.4>
     360:	00001517          	auipc	a0,0x1
     364:	01050513          	addi	a0,a0,16 # 1370 <__FUNCTION__.4+0x90>
     368:	00001097          	auipc	ra,0x1
     36c:	db6080e7          	jalr	-586(ra) # 111e <printf>
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
     38c:	f5058593          	addi	a1,a1,-176 # 12d8 <__FUNCTION__.3>
     390:	00001517          	auipc	a0,0x1
     394:	fd050513          	addi	a0,a0,-48 # 1360 <__FUNCTION__.4+0x80>
     398:	00001097          	auipc	ra,0x1
     39c:	d86080e7          	jalr	-634(ra) # 111e <printf>
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
     3de:	4e4080e7          	jalr	1252(ra) # 8be <tcreate>
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
     3f6:	560080e7          	jalr	1376(ra) # 952 <tjoin>
    for (int i = 0; i < 8; i++)
     3fa:	04a1                	addi	s1,s1,8
     3fc:	ff3496e3          	bne	s1,s3,3e8 <test2+0x70>
    }
    printf("[%s exit]\n", __FUNCTION__);
     400:	00001597          	auipc	a1,0x1
     404:	ed858593          	addi	a1,a1,-296 # 12d8 <__FUNCTION__.3>
     408:	00001517          	auipc	a0,0x1
     40c:	f6850513          	addi	a0,a0,-152 # 1370 <__FUNCTION__.4+0x90>
     410:	00001097          	auipc	ra,0x1
     414:	d0e080e7          	jalr	-754(ra) # 111e <printf>
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
     434:	ea058593          	addi	a1,a1,-352 # 12d0 <__FUNCTION__.2>
     438:	00001517          	auipc	a0,0x1
     43c:	f2850513          	addi	a0,a0,-216 # 1360 <__FUNCTION__.4+0x80>
     440:	00001097          	auipc	ra,0x1
     444:	cde080e7          	jalr	-802(ra) # 111e <printf>
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
     47a:	448080e7          	jalr	1096(ra) # 8be <tcreate>
    int result;
    tjoin(t->tid, &result, sizeof(int));
     47e:	4611                	li	a2,4
     480:	fd440593          	addi	a1,s0,-44
     484:	fe843783          	ld	a5,-24(s0)
     488:	0007c503          	lbu	a0,0(a5)
     48c:	00000097          	auipc	ra,0x0
     490:	4c6080e7          	jalr	1222(ra) # 952 <tjoin>
    printf("parent result: %d\n", result);
     494:	fd442583          	lw	a1,-44(s0)
     498:	00001517          	auipc	a0,0x1
     49c:	ee850513          	addi	a0,a0,-280 # 1380 <__FUNCTION__.4+0xa0>
     4a0:	00001097          	auipc	ra,0x1
     4a4:	c7e080e7          	jalr	-898(ra) # 111e <printf>
    printf("[%s exit]\n", __FUNCTION__);
     4a8:	00001597          	auipc	a1,0x1
     4ac:	e2858593          	addi	a1,a1,-472 # 12d0 <__FUNCTION__.2>
     4b0:	00001517          	auipc	a0,0x1
     4b4:	ec050513          	addi	a0,a0,-320 # 1370 <__FUNCTION__.4+0x90>
     4b8:	00001097          	auipc	ra,0x1
     4bc:	c66080e7          	jalr	-922(ra) # 111e <printf>
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
     4d4:	df858593          	addi	a1,a1,-520 # 12c8 <__FUNCTION__.1>
     4d8:	00001517          	auipc	a0,0x1
     4dc:	e8850513          	addi	a0,a0,-376 # 1360 <__FUNCTION__.4+0x80>
     4e0:	00001097          	auipc	ra,0x1
     4e4:	c3e080e7          	jalr	-962(ra) # 111e <printf>
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
     50a:	3b8080e7          	jalr	952(ra) # 8be <tcreate>
    tcreate(&tb, 0, &race_for_state, &args);
     50e:	fd840693          	addi	a3,s0,-40
     512:	00000617          	auipc	a2,0x0
     516:	b3e60613          	addi	a2,a2,-1218 # 50 <race_for_state>
     51a:	4581                	li	a1,0
     51c:	fe040513          	addi	a0,s0,-32
     520:	00000097          	auipc	ra,0x0
     524:	39e080e7          	jalr	926(ra) # 8be <tcreate>
    tyield();
     528:	00000097          	auipc	ra,0x0
     52c:	4a2080e7          	jalr	1186(ra) # 9ca <tyield>
    tjoin(ta->tid, 0, 0);
     530:	4601                	li	a2,0
     532:	4581                	li	a1,0
     534:	fe843783          	ld	a5,-24(s0)
     538:	0007c503          	lbu	a0,0(a5)
     53c:	00000097          	auipc	ra,0x0
     540:	416080e7          	jalr	1046(ra) # 952 <tjoin>
    tjoin(tb->tid, 0, 0);
     544:	4601                	li	a2,0
     546:	4581                	li	a1,0
     548:	fe043783          	ld	a5,-32(s0)
     54c:	0007c503          	lbu	a0,0(a5)
     550:	00000097          	auipc	ra,0x0
     554:	402080e7          	jalr	1026(ra) # 952 <tjoin>
    printf("[%s exit]\n", __FUNCTION__);
     558:	00001597          	auipc	a1,0x1
     55c:	d7058593          	addi	a1,a1,-656 # 12c8 <__FUNCTION__.1>
     560:	00001517          	auipc	a0,0x1
     564:	e1050513          	addi	a0,a0,-496 # 1370 <__FUNCTION__.4+0x90>
     568:	00001097          	auipc	ra,0x1
     56c:	bb6080e7          	jalr	-1098(ra) # 111e <printf>
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
     584:	d4058593          	addi	a1,a1,-704 # 12c0 <__FUNCTION__.0>
     588:	00001517          	auipc	a0,0x1
     58c:	dd850513          	addi	a0,a0,-552 # 1360 <__FUNCTION__.4+0x80>
     590:	00001097          	auipc	ra,0x1
     594:	b8e080e7          	jalr	-1138(ra) # 111e <printf>
    initlock(&shared_state_lock, "sharedstate lock");
     598:	00001597          	auipc	a1,0x1
     59c:	e0058593          	addi	a1,a1,-512 # 1398 <__FUNCTION__.4+0xb8>
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
     5d2:	2f0080e7          	jalr	752(ra) # 8be <tcreate>
    tcreate(&tb, 0, &no_race_for_state, &args);
     5d6:	fd840693          	addi	a3,s0,-40
     5da:	00000617          	auipc	a2,0x0
     5de:	b9c60613          	addi	a2,a2,-1124 # 176 <no_race_for_state>
     5e2:	4581                	li	a1,0
     5e4:	fe040513          	addi	a0,s0,-32
     5e8:	00000097          	auipc	ra,0x0
     5ec:	2d6080e7          	jalr	726(ra) # 8be <tcreate>
    tyield();
     5f0:	00000097          	auipc	ra,0x0
     5f4:	3da080e7          	jalr	986(ra) # 9ca <tyield>
    tjoin(ta->tid, 0, 0);
     5f8:	4601                	li	a2,0
     5fa:	4581                	li	a1,0
     5fc:	fe843783          	ld	a5,-24(s0)
     600:	0007c503          	lbu	a0,0(a5)
     604:	00000097          	auipc	ra,0x0
     608:	34e080e7          	jalr	846(ra) # 952 <tjoin>
    tjoin(tb->tid, 0, 0);
     60c:	4601                	li	a2,0
     60e:	4581                	li	a1,0
     610:	fe043783          	ld	a5,-32(s0)
     614:	0007c503          	lbu	a0,0(a5)
     618:	00000097          	auipc	ra,0x0
     61c:	33a080e7          	jalr	826(ra) # 952 <tjoin>
    printf("[%s exit]\n", __FUNCTION__);
     620:	00001597          	auipc	a1,0x1
     624:	ca058593          	addi	a1,a1,-864 # 12c0 <__FUNCTION__.0>
     628:	00001517          	auipc	a0,0x1
     62c:	d4850513          	addi	a0,a0,-696 # 1370 <__FUNCTION__.4+0x90>
     630:	00001097          	auipc	ra,0x1
     634:	aee080e7          	jalr	-1298(ra) # 111e <printf>
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
     658:	650080e7          	jalr	1616(ra) # ca4 <atoi>
     65c:	4795                	li	a5,5
     65e:	06a7e763          	bltu	a5,a0,6cc <main+0x8c>
     662:	050a                	slli	a0,a0,0x2
     664:	00001717          	auipc	a4,0x1
     668:	dbc70713          	addi	a4,a4,-580 # 1420 <__FUNCTION__.4+0x140>
     66c:	953a                	add	a0,a0,a4
     66e:	411c                	lw	a5,0(a0)
     670:	97ba                	add	a5,a5,a4
     672:	8782                	jr	a5
        printf("ttest TEST_ID\n TEST ID\tId of the test to run. ID can be any value from 1 to 5\n");
     674:	00001517          	auipc	a0,0x1
     678:	d3c50513          	addi	a0,a0,-708 # 13b0 <__FUNCTION__.4+0xd0>
     67c:	00001097          	auipc	ra,0x1
     680:	aa2080e7          	jalr	-1374(ra) # 111e <printf>
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
     6d2:	d3250513          	addi	a0,a0,-718 # 1400 <__FUNCTION__.4+0x120>
     6d6:	00001097          	auipc	ra,0x1
     6da:	a48080e7          	jalr	-1464(ra) # 111e <printf>
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
     716:	2dc080e7          	jalr	732(ra) # 9ee <twhoami>
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
     762:	d0250513          	addi	a0,a0,-766 # 1460 <__FUNCTION__.5+0x18>
     766:	00001097          	auipc	ra,0x1
     76a:	9b8080e7          	jalr	-1608(ra) # 111e <printf>
        exit(-1);
     76e:	557d                	li	a0,-1
     770:	00000097          	auipc	ra,0x0
     774:	62e080e7          	jalr	1582(ra) # d9e <exit>
    {
        // give up the cpu for other threads
        tyield();
     778:	00000097          	auipc	ra,0x0
     77c:	252080e7          	jalr	594(ra) # 9ca <tyield>
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
     796:	25c080e7          	jalr	604(ra) # 9ee <twhoami>
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
     7da:	1f4080e7          	jalr	500(ra) # 9ca <tyield>
}
     7de:	60e2                	ld	ra,24(sp)
     7e0:	6442                	ld	s0,16(sp)
     7e2:	64a2                	ld	s1,8(sp)
     7e4:	6105                	addi	sp,sp,32
     7e6:	8082                	ret
        printf("releasing lock we are not holding");
     7e8:	00001517          	auipc	a0,0x1
     7ec:	ca050513          	addi	a0,a0,-864 # 1488 <__FUNCTION__.5+0x40>
     7f0:	00001097          	auipc	ra,0x1
     7f4:	92e080e7          	jalr	-1746(ra) # 111e <printf>
        exit(-1);
     7f8:	557d                	li	a0,-1
     7fa:	00000097          	auipc	ra,0x0
     7fe:	5a4080e7          	jalr	1444(ra) # d9e <exit>

0000000000000802 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
     802:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     804:	00002617          	auipc	a2,0x2
     808:	84460613          	addi	a2,a2,-1980 # 2048 <threads>
     80c:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
     80e:	45c1                	li	a1,16
     810:	a021                	j	818 <tsched+0x16>
     812:	2685                	addiw	a3,a3,1
     814:	08b68c63          	beq	a3,a1,8ac <tsched+0xaa>
        int next_index = (current_index + i) % 16;
     818:	41f6d71b          	sraiw	a4,a3,0x1f
     81c:	01c7571b          	srliw	a4,a4,0x1c
     820:	00d707bb          	addw	a5,a4,a3
     824:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     826:	9f99                	subw	a5,a5,a4
     828:	078e                	slli	a5,a5,0x3
     82a:	97b2                	add	a5,a5,a2
     82c:	639c                	ld	a5,0(a5)
     82e:	d3f5                	beqz	a5,812 <tsched+0x10>
     830:	5fb8                	lw	a4,120(a5)
     832:	fea710e3          	bne	a4,a0,812 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
     836:	00002717          	auipc	a4,0x2
     83a:	81273703          	ld	a4,-2030(a4) # 2048 <threads>
     83e:	5f30                	lw	a2,120(a4)
     840:	468d                	li	a3,3
     842:	06d60363          	beq	a2,a3,8a8 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
     846:	c3a5                	beqz	a5,8a6 <tsched+0xa4>
{
     848:	1101                	addi	sp,sp,-32
     84a:	ec06                	sd	ra,24(sp)
     84c:	e822                	sd	s0,16(sp)
     84e:	e426                	sd	s1,8(sp)
     850:	e04a                	sd	s2,0(sp)
     852:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
     854:	00001497          	auipc	s1,0x1
     858:	7c448493          	addi	s1,s1,1988 # 2018 <current_thread>
     85c:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
     860:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
     862:	0007c603          	lbu	a2,0(a5)
     866:	00094583          	lbu	a1,0(s2)
     86a:	00001517          	auipc	a0,0x1
     86e:	c4650513          	addi	a0,a0,-954 # 14b0 <__FUNCTION__.5+0x68>
     872:	00001097          	auipc	ra,0x1
     876:	8ac080e7          	jalr	-1876(ra) # 111e <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
     87a:	608c                	ld	a1,0(s1)
     87c:	05a1                	addi	a1,a1,8
     87e:	00890513          	addi	a0,s2,8
     882:	00000097          	auipc	ra,0x0
     886:	184080e7          	jalr	388(ra) # a06 <tswtch>
        printf("Thread switch complete\n");
     88a:	00001517          	auipc	a0,0x1
     88e:	c4e50513          	addi	a0,a0,-946 # 14d8 <__FUNCTION__.5+0x90>
     892:	00001097          	auipc	ra,0x1
     896:	88c080e7          	jalr	-1908(ra) # 111e <printf>
    }
}
     89a:	60e2                	ld	ra,24(sp)
     89c:	6442                	ld	s0,16(sp)
     89e:	64a2                	ld	s1,8(sp)
     8a0:	6902                	ld	s2,0(sp)
     8a2:	6105                	addi	sp,sp,32
     8a4:	8082                	ret
     8a6:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
     8a8:	87ba                	mv	a5,a4
     8aa:	bf79                	j	848 <tsched+0x46>
     8ac:	00001797          	auipc	a5,0x1
     8b0:	79c7b783          	ld	a5,1948(a5) # 2048 <threads>
     8b4:	5fb4                	lw	a3,120(a5)
     8b6:	470d                	li	a4,3
     8b8:	f8e688e3          	beq	a3,a4,848 <tsched+0x46>
     8bc:	8082                	ret

00000000000008be <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     8be:	7179                	addi	sp,sp,-48
     8c0:	f406                	sd	ra,40(sp)
     8c2:	f022                	sd	s0,32(sp)
     8c4:	ec26                	sd	s1,24(sp)
     8c6:	e84a                	sd	s2,16(sp)
     8c8:	e44e                	sd	s3,8(sp)
     8ca:	1800                	addi	s0,sp,48
     8cc:	84aa                	mv	s1,a0
     8ce:	89b2                	mv	s3,a2
     8d0:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     8d2:	09000513          	li	a0,144
     8d6:	00001097          	auipc	ra,0x1
     8da:	900080e7          	jalr	-1792(ra) # 11d6 <malloc>
     8de:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     8e0:	478d                	li	a5,3
     8e2:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     8e4:	609c                	ld	a5,0(s1)
     8e6:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
     8ea:	609c                	ld	a5,0(s1)
     8ec:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
     8f0:	00001717          	auipc	a4,0x1
     8f4:	71070713          	addi	a4,a4,1808 # 2000 <next_tid>
     8f8:	431c                	lw	a5,0(a4)
     8fa:	0017869b          	addiw	a3,a5,1
     8fe:	c314                	sw	a3,0(a4)
     900:	6098                	ld	a4,0(s1)
     902:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
     906:	00001717          	auipc	a4,0x1
     90a:	74270713          	addi	a4,a4,1858 # 2048 <threads>
     90e:	4781                	li	a5,0
     910:	4641                	li	a2,16
    if (threads[i] == NULL) {
     912:	6314                	ld	a3,0(a4)
     914:	ce81                	beqz	a3,92c <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
     916:	2785                	addiw	a5,a5,1
     918:	0721                	addi	a4,a4,8
     91a:	fec79ce3          	bne	a5,a2,912 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
     91e:	70a2                	ld	ra,40(sp)
     920:	7402                	ld	s0,32(sp)
     922:	64e2                	ld	s1,24(sp)
     924:	6942                	ld	s2,16(sp)
     926:	69a2                	ld	s3,8(sp)
     928:	6145                	addi	sp,sp,48
     92a:	8082                	ret
        threads[i] = *thread;
     92c:	6094                	ld	a3,0(s1)
     92e:	078e                	slli	a5,a5,0x3
     930:	00001717          	auipc	a4,0x1
     934:	71870713          	addi	a4,a4,1816 # 2048 <threads>
     938:	97ba                	add	a5,a5,a4
     93a:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
     93c:	0006c583          	lbu	a1,0(a3)
     940:	00001517          	auipc	a0,0x1
     944:	bb050513          	addi	a0,a0,-1104 # 14f0 <__FUNCTION__.5+0xa8>
     948:	00000097          	auipc	ra,0x0
     94c:	7d6080e7          	jalr	2006(ra) # 111e <printf>
        break;
     950:	b7f9                	j	91e <tcreate+0x60>

0000000000000952 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
     952:	7179                	addi	sp,sp,-48
     954:	f406                	sd	ra,40(sp)
     956:	f022                	sd	s0,32(sp)
     958:	ec26                	sd	s1,24(sp)
     95a:	e84a                	sd	s2,16(sp)
     95c:	e44e                	sd	s3,8(sp)
     95e:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
     960:	00001797          	auipc	a5,0x1
     964:	6e878793          	addi	a5,a5,1768 # 2048 <threads>
     968:	00001697          	auipc	a3,0x1
     96c:	76068693          	addi	a3,a3,1888 # 20c8 <base>
     970:	a021                	j	978 <tjoin+0x26>
     972:	07a1                	addi	a5,a5,8
     974:	04d78763          	beq	a5,a3,9c2 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
     978:	6384                	ld	s1,0(a5)
     97a:	dce5                	beqz	s1,972 <tjoin+0x20>
     97c:	0004c703          	lbu	a4,0(s1)
     980:	fea719e3          	bne	a4,a0,972 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
     984:	5cb8                	lw	a4,120(s1)
     986:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
     988:	00001997          	auipc	s3,0x1
     98c:	b9898993          	addi	s3,s3,-1128 # 1520 <__FUNCTION__.5+0xd8>
    while (target_thread->state != EXITED) {
     990:	4919                	li	s2,6
     992:	02f70a63          	beq	a4,a5,9c6 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
     996:	0004c583          	lbu	a1,0(s1)
     99a:	854e                	mv	a0,s3
     99c:	00000097          	auipc	ra,0x0
     9a0:	782080e7          	jalr	1922(ra) # 111e <printf>
        tsched();
     9a4:	00000097          	auipc	ra,0x0
     9a8:	e5e080e7          	jalr	-418(ra) # 802 <tsched>
    while (target_thread->state != EXITED) {
     9ac:	5cbc                	lw	a5,120(s1)
     9ae:	ff2794e3          	bne	a5,s2,996 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
     9b2:	4501                	li	a0,0
}
     9b4:	70a2                	ld	ra,40(sp)
     9b6:	7402                	ld	s0,32(sp)
     9b8:	64e2                	ld	s1,24(sp)
     9ba:	6942                	ld	s2,16(sp)
     9bc:	69a2                	ld	s3,8(sp)
     9be:	6145                	addi	sp,sp,48
     9c0:	8082                	ret
        return -1;
     9c2:	557d                	li	a0,-1
     9c4:	bfc5                	j	9b4 <tjoin+0x62>
    return 0;
     9c6:	4501                	li	a0,0
     9c8:	b7f5                	j	9b4 <tjoin+0x62>

00000000000009ca <tyield>:


void tyield()
{
     9ca:	1141                	addi	sp,sp,-16
     9cc:	e406                	sd	ra,8(sp)
     9ce:	e022                	sd	s0,0(sp)
     9d0:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
     9d2:	00001797          	auipc	a5,0x1
     9d6:	6467b783          	ld	a5,1606(a5) # 2018 <current_thread>
     9da:	470d                	li	a4,3
     9dc:	dfb8                	sw	a4,120(a5)
    tsched();
     9de:	00000097          	auipc	ra,0x0
     9e2:	e24080e7          	jalr	-476(ra) # 802 <tsched>
}
     9e6:	60a2                	ld	ra,8(sp)
     9e8:	6402                	ld	s0,0(sp)
     9ea:	0141                	addi	sp,sp,16
     9ec:	8082                	ret

00000000000009ee <twhoami>:

uint8 twhoami()
{
     9ee:	1141                	addi	sp,sp,-16
     9f0:	e422                	sd	s0,8(sp)
     9f2:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
     9f4:	00001797          	auipc	a5,0x1
     9f8:	6247b783          	ld	a5,1572(a5) # 2018 <current_thread>
     9fc:	0007c503          	lbu	a0,0(a5)
     a00:	6422                	ld	s0,8(sp)
     a02:	0141                	addi	sp,sp,16
     a04:	8082                	ret

0000000000000a06 <tswtch>:
     a06:	00153023          	sd	ra,0(a0)
     a0a:	00253423          	sd	sp,8(a0)
     a0e:	e900                	sd	s0,16(a0)
     a10:	ed04                	sd	s1,24(a0)
     a12:	03253023          	sd	s2,32(a0)
     a16:	03353423          	sd	s3,40(a0)
     a1a:	03453823          	sd	s4,48(a0)
     a1e:	03553c23          	sd	s5,56(a0)
     a22:	05653023          	sd	s6,64(a0)
     a26:	05753423          	sd	s7,72(a0)
     a2a:	05853823          	sd	s8,80(a0)
     a2e:	05953c23          	sd	s9,88(a0)
     a32:	07a53023          	sd	s10,96(a0)
     a36:	07b53423          	sd	s11,104(a0)
     a3a:	0005b083          	ld	ra,0(a1)
     a3e:	0085b103          	ld	sp,8(a1)
     a42:	6980                	ld	s0,16(a1)
     a44:	6d84                	ld	s1,24(a1)
     a46:	0205b903          	ld	s2,32(a1)
     a4a:	0285b983          	ld	s3,40(a1)
     a4e:	0305ba03          	ld	s4,48(a1)
     a52:	0385ba83          	ld	s5,56(a1)
     a56:	0405bb03          	ld	s6,64(a1)
     a5a:	0485bb83          	ld	s7,72(a1)
     a5e:	0505bc03          	ld	s8,80(a1)
     a62:	0585bc83          	ld	s9,88(a1)
     a66:	0605bd03          	ld	s10,96(a1)
     a6a:	0685bd83          	ld	s11,104(a1)
     a6e:	8082                	ret

0000000000000a70 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     a70:	715d                	addi	sp,sp,-80
     a72:	e486                	sd	ra,72(sp)
     a74:	e0a2                	sd	s0,64(sp)
     a76:	fc26                	sd	s1,56(sp)
     a78:	f84a                	sd	s2,48(sp)
     a7a:	f44e                	sd	s3,40(sp)
     a7c:	f052                	sd	s4,32(sp)
     a7e:	ec56                	sd	s5,24(sp)
     a80:	e85a                	sd	s6,16(sp)
     a82:	e45e                	sd	s7,8(sp)
     a84:	0880                	addi	s0,sp,80
     a86:	892a                	mv	s2,a0
     a88:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
     a8a:	00001517          	auipc	a0,0x1
     a8e:	ab650513          	addi	a0,a0,-1354 # 1540 <__FUNCTION__.5+0xf8>
     a92:	00000097          	auipc	ra,0x0
     a96:	68c080e7          	jalr	1676(ra) # 111e <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     a9a:	09000513          	li	a0,144
     a9e:	00000097          	auipc	ra,0x0
     aa2:	738080e7          	jalr	1848(ra) # 11d6 <malloc>

    main_thread->tid = 0;
     aa6:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
     aaa:	4791                	li	a5,4
     aac:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
     aae:	00001797          	auipc	a5,0x1
     ab2:	56a7b523          	sd	a0,1386(a5) # 2018 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
     ab6:	00001a17          	auipc	s4,0x1
     aba:	592a0a13          	addi	s4,s4,1426 # 2048 <threads>
     abe:	00001497          	auipc	s1,0x1
     ac2:	60a48493          	addi	s1,s1,1546 # 20c8 <base>
    current_thread = main_thread;
     ac6:	87d2                	mv	a5,s4
        threads[i] = NULL;
     ac8:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
     acc:	07a1                	addi	a5,a5,8
     ace:	fe979de3          	bne	a5,s1,ac8 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
     ad2:	00001797          	auipc	a5,0x1
     ad6:	56a7bb23          	sd	a0,1398(a5) # 2048 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     ada:	85ce                	mv	a1,s3
     adc:	854a                	mv	a0,s2
     ade:	00000097          	auipc	ra,0x0
     ae2:	b62080e7          	jalr	-1182(ra) # 640 <main>
     ae6:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
     ae8:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
     aea:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
     aec:	00001a97          	auipc	s5,0x1
     af0:	a74a8a93          	addi	s5,s5,-1420 # 1560 <__FUNCTION__.5+0x118>
     af4:	a03d                	j	b22 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
     af6:	07a1                	addi	a5,a5,8
     af8:	00978963          	beq	a5,s1,b0a <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
     afc:	6398                	ld	a4,0(a5)
     afe:	df65                	beqz	a4,af6 <_main+0x86>
     b00:	5f38                	lw	a4,120(a4)
     b02:	ff370ae3          	beq	a4,s3,af6 <_main+0x86>
                running_threads++;
     b06:	2905                	addiw	s2,s2,1
     b08:	b7fd                	j	af6 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
     b0a:	85ca                	mv	a1,s2
     b0c:	8556                	mv	a0,s5
     b0e:	00000097          	auipc	ra,0x0
     b12:	610080e7          	jalr	1552(ra) # 111e <printf>
        if (running_threads > 0) {
     b16:	01205963          	blez	s2,b28 <_main+0xb8>
            tsched(); // Schedule another thread to run
     b1a:	00000097          	auipc	ra,0x0
     b1e:	ce8080e7          	jalr	-792(ra) # 802 <tsched>
    current_thread = main_thread;
     b22:	87d2                	mv	a5,s4
        running_threads = 0;
     b24:	895a                	mv	s2,s6
     b26:	bfd9                	j	afc <_main+0x8c>
        }
    }

    exit(res);
     b28:	855e                	mv	a0,s7
     b2a:	00000097          	auipc	ra,0x0
     b2e:	274080e7          	jalr	628(ra) # d9e <exit>

0000000000000b32 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     b32:	1141                	addi	sp,sp,-16
     b34:	e422                	sd	s0,8(sp)
     b36:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
     b38:	87aa                	mv	a5,a0
     b3a:	0585                	addi	a1,a1,1
     b3c:	0785                	addi	a5,a5,1
     b3e:	fff5c703          	lbu	a4,-1(a1)
     b42:	fee78fa3          	sb	a4,-1(a5)
     b46:	fb75                	bnez	a4,b3a <strcpy+0x8>
        ;
    return os;
}
     b48:	6422                	ld	s0,8(sp)
     b4a:	0141                	addi	sp,sp,16
     b4c:	8082                	ret

0000000000000b4e <strcmp>:

int strcmp(const char *p, const char *q)
{
     b4e:	1141                	addi	sp,sp,-16
     b50:	e422                	sd	s0,8(sp)
     b52:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
     b54:	00054783          	lbu	a5,0(a0)
     b58:	cb91                	beqz	a5,b6c <strcmp+0x1e>
     b5a:	0005c703          	lbu	a4,0(a1)
     b5e:	00f71763          	bne	a4,a5,b6c <strcmp+0x1e>
        p++, q++;
     b62:	0505                	addi	a0,a0,1
     b64:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
     b66:	00054783          	lbu	a5,0(a0)
     b6a:	fbe5                	bnez	a5,b5a <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
     b6c:	0005c503          	lbu	a0,0(a1)
}
     b70:	40a7853b          	subw	a0,a5,a0
     b74:	6422                	ld	s0,8(sp)
     b76:	0141                	addi	sp,sp,16
     b78:	8082                	ret

0000000000000b7a <strlen>:

uint strlen(const char *s)
{
     b7a:	1141                	addi	sp,sp,-16
     b7c:	e422                	sd	s0,8(sp)
     b7e:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
     b80:	00054783          	lbu	a5,0(a0)
     b84:	cf91                	beqz	a5,ba0 <strlen+0x26>
     b86:	0505                	addi	a0,a0,1
     b88:	87aa                	mv	a5,a0
     b8a:	86be                	mv	a3,a5
     b8c:	0785                	addi	a5,a5,1
     b8e:	fff7c703          	lbu	a4,-1(a5)
     b92:	ff65                	bnez	a4,b8a <strlen+0x10>
     b94:	40a6853b          	subw	a0,a3,a0
     b98:	2505                	addiw	a0,a0,1
        ;
    return n;
}
     b9a:	6422                	ld	s0,8(sp)
     b9c:	0141                	addi	sp,sp,16
     b9e:	8082                	ret
    for (n = 0; s[n]; n++)
     ba0:	4501                	li	a0,0
     ba2:	bfe5                	j	b9a <strlen+0x20>

0000000000000ba4 <memset>:

void *
memset(void *dst, int c, uint n)
{
     ba4:	1141                	addi	sp,sp,-16
     ba6:	e422                	sd	s0,8(sp)
     ba8:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
     baa:	ca19                	beqz	a2,bc0 <memset+0x1c>
     bac:	87aa                	mv	a5,a0
     bae:	1602                	slli	a2,a2,0x20
     bb0:	9201                	srli	a2,a2,0x20
     bb2:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
     bb6:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
     bba:	0785                	addi	a5,a5,1
     bbc:	fee79de3          	bne	a5,a4,bb6 <memset+0x12>
    }
    return dst;
}
     bc0:	6422                	ld	s0,8(sp)
     bc2:	0141                	addi	sp,sp,16
     bc4:	8082                	ret

0000000000000bc6 <strchr>:

char *
strchr(const char *s, char c)
{
     bc6:	1141                	addi	sp,sp,-16
     bc8:	e422                	sd	s0,8(sp)
     bca:	0800                	addi	s0,sp,16
    for (; *s; s++)
     bcc:	00054783          	lbu	a5,0(a0)
     bd0:	cb99                	beqz	a5,be6 <strchr+0x20>
        if (*s == c)
     bd2:	00f58763          	beq	a1,a5,be0 <strchr+0x1a>
    for (; *s; s++)
     bd6:	0505                	addi	a0,a0,1
     bd8:	00054783          	lbu	a5,0(a0)
     bdc:	fbfd                	bnez	a5,bd2 <strchr+0xc>
            return (char *)s;
    return 0;
     bde:	4501                	li	a0,0
}
     be0:	6422                	ld	s0,8(sp)
     be2:	0141                	addi	sp,sp,16
     be4:	8082                	ret
    return 0;
     be6:	4501                	li	a0,0
     be8:	bfe5                	j	be0 <strchr+0x1a>

0000000000000bea <gets>:

char *
gets(char *buf, int max)
{
     bea:	711d                	addi	sp,sp,-96
     bec:	ec86                	sd	ra,88(sp)
     bee:	e8a2                	sd	s0,80(sp)
     bf0:	e4a6                	sd	s1,72(sp)
     bf2:	e0ca                	sd	s2,64(sp)
     bf4:	fc4e                	sd	s3,56(sp)
     bf6:	f852                	sd	s4,48(sp)
     bf8:	f456                	sd	s5,40(sp)
     bfa:	f05a                	sd	s6,32(sp)
     bfc:	ec5e                	sd	s7,24(sp)
     bfe:	1080                	addi	s0,sp,96
     c00:	8baa                	mv	s7,a0
     c02:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
     c04:	892a                	mv	s2,a0
     c06:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
     c08:	4aa9                	li	s5,10
     c0a:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
     c0c:	89a6                	mv	s3,s1
     c0e:	2485                	addiw	s1,s1,1
     c10:	0344d863          	bge	s1,s4,c40 <gets+0x56>
        cc = read(0, &c, 1);
     c14:	4605                	li	a2,1
     c16:	faf40593          	addi	a1,s0,-81
     c1a:	4501                	li	a0,0
     c1c:	00000097          	auipc	ra,0x0
     c20:	19a080e7          	jalr	410(ra) # db6 <read>
        if (cc < 1)
     c24:	00a05e63          	blez	a0,c40 <gets+0x56>
        buf[i++] = c;
     c28:	faf44783          	lbu	a5,-81(s0)
     c2c:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
     c30:	01578763          	beq	a5,s5,c3e <gets+0x54>
     c34:	0905                	addi	s2,s2,1
     c36:	fd679be3          	bne	a5,s6,c0c <gets+0x22>
    for (i = 0; i + 1 < max;)
     c3a:	89a6                	mv	s3,s1
     c3c:	a011                	j	c40 <gets+0x56>
     c3e:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
     c40:	99de                	add	s3,s3,s7
     c42:	00098023          	sb	zero,0(s3)
    return buf;
}
     c46:	855e                	mv	a0,s7
     c48:	60e6                	ld	ra,88(sp)
     c4a:	6446                	ld	s0,80(sp)
     c4c:	64a6                	ld	s1,72(sp)
     c4e:	6906                	ld	s2,64(sp)
     c50:	79e2                	ld	s3,56(sp)
     c52:	7a42                	ld	s4,48(sp)
     c54:	7aa2                	ld	s5,40(sp)
     c56:	7b02                	ld	s6,32(sp)
     c58:	6be2                	ld	s7,24(sp)
     c5a:	6125                	addi	sp,sp,96
     c5c:	8082                	ret

0000000000000c5e <stat>:

int stat(const char *n, struct stat *st)
{
     c5e:	1101                	addi	sp,sp,-32
     c60:	ec06                	sd	ra,24(sp)
     c62:	e822                	sd	s0,16(sp)
     c64:	e426                	sd	s1,8(sp)
     c66:	e04a                	sd	s2,0(sp)
     c68:	1000                	addi	s0,sp,32
     c6a:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     c6c:	4581                	li	a1,0
     c6e:	00000097          	auipc	ra,0x0
     c72:	170080e7          	jalr	368(ra) # dde <open>
    if (fd < 0)
     c76:	02054563          	bltz	a0,ca0 <stat+0x42>
     c7a:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
     c7c:	85ca                	mv	a1,s2
     c7e:	00000097          	auipc	ra,0x0
     c82:	178080e7          	jalr	376(ra) # df6 <fstat>
     c86:	892a                	mv	s2,a0
    close(fd);
     c88:	8526                	mv	a0,s1
     c8a:	00000097          	auipc	ra,0x0
     c8e:	13c080e7          	jalr	316(ra) # dc6 <close>
    return r;
}
     c92:	854a                	mv	a0,s2
     c94:	60e2                	ld	ra,24(sp)
     c96:	6442                	ld	s0,16(sp)
     c98:	64a2                	ld	s1,8(sp)
     c9a:	6902                	ld	s2,0(sp)
     c9c:	6105                	addi	sp,sp,32
     c9e:	8082                	ret
        return -1;
     ca0:	597d                	li	s2,-1
     ca2:	bfc5                	j	c92 <stat+0x34>

0000000000000ca4 <atoi>:

int atoi(const char *s)
{
     ca4:	1141                	addi	sp,sp,-16
     ca6:	e422                	sd	s0,8(sp)
     ca8:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
     caa:	00054683          	lbu	a3,0(a0)
     cae:	fd06879b          	addiw	a5,a3,-48
     cb2:	0ff7f793          	zext.b	a5,a5
     cb6:	4625                	li	a2,9
     cb8:	02f66863          	bltu	a2,a5,ce8 <atoi+0x44>
     cbc:	872a                	mv	a4,a0
    n = 0;
     cbe:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
     cc0:	0705                	addi	a4,a4,1
     cc2:	0025179b          	slliw	a5,a0,0x2
     cc6:	9fa9                	addw	a5,a5,a0
     cc8:	0017979b          	slliw	a5,a5,0x1
     ccc:	9fb5                	addw	a5,a5,a3
     cce:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
     cd2:	00074683          	lbu	a3,0(a4)
     cd6:	fd06879b          	addiw	a5,a3,-48
     cda:	0ff7f793          	zext.b	a5,a5
     cde:	fef671e3          	bgeu	a2,a5,cc0 <atoi+0x1c>
    return n;
}
     ce2:	6422                	ld	s0,8(sp)
     ce4:	0141                	addi	sp,sp,16
     ce6:	8082                	ret
    n = 0;
     ce8:	4501                	li	a0,0
     cea:	bfe5                	j	ce2 <atoi+0x3e>

0000000000000cec <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
     cec:	1141                	addi	sp,sp,-16
     cee:	e422                	sd	s0,8(sp)
     cf0:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
     cf2:	02b57463          	bgeu	a0,a1,d1a <memmove+0x2e>
    {
        while (n-- > 0)
     cf6:	00c05f63          	blez	a2,d14 <memmove+0x28>
     cfa:	1602                	slli	a2,a2,0x20
     cfc:	9201                	srli	a2,a2,0x20
     cfe:	00c507b3          	add	a5,a0,a2
    dst = vdst;
     d02:	872a                	mv	a4,a0
            *dst++ = *src++;
     d04:	0585                	addi	a1,a1,1
     d06:	0705                	addi	a4,a4,1
     d08:	fff5c683          	lbu	a3,-1(a1)
     d0c:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
     d10:	fee79ae3          	bne	a5,a4,d04 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
     d14:	6422                	ld	s0,8(sp)
     d16:	0141                	addi	sp,sp,16
     d18:	8082                	ret
        dst += n;
     d1a:	00c50733          	add	a4,a0,a2
        src += n;
     d1e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
     d20:	fec05ae3          	blez	a2,d14 <memmove+0x28>
     d24:	fff6079b          	addiw	a5,a2,-1
     d28:	1782                	slli	a5,a5,0x20
     d2a:	9381                	srli	a5,a5,0x20
     d2c:	fff7c793          	not	a5,a5
     d30:	97ba                	add	a5,a5,a4
            *--dst = *--src;
     d32:	15fd                	addi	a1,a1,-1
     d34:	177d                	addi	a4,a4,-1
     d36:	0005c683          	lbu	a3,0(a1)
     d3a:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
     d3e:	fee79ae3          	bne	a5,a4,d32 <memmove+0x46>
     d42:	bfc9                	j	d14 <memmove+0x28>

0000000000000d44 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
     d44:	1141                	addi	sp,sp,-16
     d46:	e422                	sd	s0,8(sp)
     d48:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
     d4a:	ca05                	beqz	a2,d7a <memcmp+0x36>
     d4c:	fff6069b          	addiw	a3,a2,-1
     d50:	1682                	slli	a3,a3,0x20
     d52:	9281                	srli	a3,a3,0x20
     d54:	0685                	addi	a3,a3,1
     d56:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
     d58:	00054783          	lbu	a5,0(a0)
     d5c:	0005c703          	lbu	a4,0(a1)
     d60:	00e79863          	bne	a5,a4,d70 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
     d64:	0505                	addi	a0,a0,1
        p2++;
     d66:	0585                	addi	a1,a1,1
    while (n-- > 0)
     d68:	fed518e3          	bne	a0,a3,d58 <memcmp+0x14>
    }
    return 0;
     d6c:	4501                	li	a0,0
     d6e:	a019                	j	d74 <memcmp+0x30>
            return *p1 - *p2;
     d70:	40e7853b          	subw	a0,a5,a4
}
     d74:	6422                	ld	s0,8(sp)
     d76:	0141                	addi	sp,sp,16
     d78:	8082                	ret
    return 0;
     d7a:	4501                	li	a0,0
     d7c:	bfe5                	j	d74 <memcmp+0x30>

0000000000000d7e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     d7e:	1141                	addi	sp,sp,-16
     d80:	e406                	sd	ra,8(sp)
     d82:	e022                	sd	s0,0(sp)
     d84:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
     d86:	00000097          	auipc	ra,0x0
     d8a:	f66080e7          	jalr	-154(ra) # cec <memmove>
}
     d8e:	60a2                	ld	ra,8(sp)
     d90:	6402                	ld	s0,0(sp)
     d92:	0141                	addi	sp,sp,16
     d94:	8082                	ret

0000000000000d96 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     d96:	4885                	li	a7,1
 ecall
     d98:	00000073          	ecall
 ret
     d9c:	8082                	ret

0000000000000d9e <exit>:
.global exit
exit:
 li a7, SYS_exit
     d9e:	4889                	li	a7,2
 ecall
     da0:	00000073          	ecall
 ret
     da4:	8082                	ret

0000000000000da6 <wait>:
.global wait
wait:
 li a7, SYS_wait
     da6:	488d                	li	a7,3
 ecall
     da8:	00000073          	ecall
 ret
     dac:	8082                	ret

0000000000000dae <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     dae:	4891                	li	a7,4
 ecall
     db0:	00000073          	ecall
 ret
     db4:	8082                	ret

0000000000000db6 <read>:
.global read
read:
 li a7, SYS_read
     db6:	4895                	li	a7,5
 ecall
     db8:	00000073          	ecall
 ret
     dbc:	8082                	ret

0000000000000dbe <write>:
.global write
write:
 li a7, SYS_write
     dbe:	48c1                	li	a7,16
 ecall
     dc0:	00000073          	ecall
 ret
     dc4:	8082                	ret

0000000000000dc6 <close>:
.global close
close:
 li a7, SYS_close
     dc6:	48d5                	li	a7,21
 ecall
     dc8:	00000073          	ecall
 ret
     dcc:	8082                	ret

0000000000000dce <kill>:
.global kill
kill:
 li a7, SYS_kill
     dce:	4899                	li	a7,6
 ecall
     dd0:	00000073          	ecall
 ret
     dd4:	8082                	ret

0000000000000dd6 <exec>:
.global exec
exec:
 li a7, SYS_exec
     dd6:	489d                	li	a7,7
 ecall
     dd8:	00000073          	ecall
 ret
     ddc:	8082                	ret

0000000000000dde <open>:
.global open
open:
 li a7, SYS_open
     dde:	48bd                	li	a7,15
 ecall
     de0:	00000073          	ecall
 ret
     de4:	8082                	ret

0000000000000de6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     de6:	48c5                	li	a7,17
 ecall
     de8:	00000073          	ecall
 ret
     dec:	8082                	ret

0000000000000dee <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     dee:	48c9                	li	a7,18
 ecall
     df0:	00000073          	ecall
 ret
     df4:	8082                	ret

0000000000000df6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     df6:	48a1                	li	a7,8
 ecall
     df8:	00000073          	ecall
 ret
     dfc:	8082                	ret

0000000000000dfe <link>:
.global link
link:
 li a7, SYS_link
     dfe:	48cd                	li	a7,19
 ecall
     e00:	00000073          	ecall
 ret
     e04:	8082                	ret

0000000000000e06 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e06:	48d1                	li	a7,20
 ecall
     e08:	00000073          	ecall
 ret
     e0c:	8082                	ret

0000000000000e0e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e0e:	48a5                	li	a7,9
 ecall
     e10:	00000073          	ecall
 ret
     e14:	8082                	ret

0000000000000e16 <dup>:
.global dup
dup:
 li a7, SYS_dup
     e16:	48a9                	li	a7,10
 ecall
     e18:	00000073          	ecall
 ret
     e1c:	8082                	ret

0000000000000e1e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     e1e:	48ad                	li	a7,11
 ecall
     e20:	00000073          	ecall
 ret
     e24:	8082                	ret

0000000000000e26 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     e26:	48b1                	li	a7,12
 ecall
     e28:	00000073          	ecall
 ret
     e2c:	8082                	ret

0000000000000e2e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     e2e:	48b5                	li	a7,13
 ecall
     e30:	00000073          	ecall
 ret
     e34:	8082                	ret

0000000000000e36 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     e36:	48b9                	li	a7,14
 ecall
     e38:	00000073          	ecall
 ret
     e3c:	8082                	ret

0000000000000e3e <ps>:
.global ps
ps:
 li a7, SYS_ps
     e3e:	48d9                	li	a7,22
 ecall
     e40:	00000073          	ecall
 ret
     e44:	8082                	ret

0000000000000e46 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
     e46:	48dd                	li	a7,23
 ecall
     e48:	00000073          	ecall
 ret
     e4c:	8082                	ret

0000000000000e4e <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
     e4e:	48e1                	li	a7,24
 ecall
     e50:	00000073          	ecall
 ret
     e54:	8082                	ret

0000000000000e56 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     e56:	1101                	addi	sp,sp,-32
     e58:	ec06                	sd	ra,24(sp)
     e5a:	e822                	sd	s0,16(sp)
     e5c:	1000                	addi	s0,sp,32
     e5e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     e62:	4605                	li	a2,1
     e64:	fef40593          	addi	a1,s0,-17
     e68:	00000097          	auipc	ra,0x0
     e6c:	f56080e7          	jalr	-170(ra) # dbe <write>
}
     e70:	60e2                	ld	ra,24(sp)
     e72:	6442                	ld	s0,16(sp)
     e74:	6105                	addi	sp,sp,32
     e76:	8082                	ret

0000000000000e78 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     e78:	7139                	addi	sp,sp,-64
     e7a:	fc06                	sd	ra,56(sp)
     e7c:	f822                	sd	s0,48(sp)
     e7e:	f426                	sd	s1,40(sp)
     e80:	f04a                	sd	s2,32(sp)
     e82:	ec4e                	sd	s3,24(sp)
     e84:	0080                	addi	s0,sp,64
     e86:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e88:	c299                	beqz	a3,e8e <printint+0x16>
     e8a:	0805c963          	bltz	a1,f1c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     e8e:	2581                	sext.w	a1,a1
  neg = 0;
     e90:	4881                	li	a7,0
     e92:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     e96:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     e98:	2601                	sext.w	a2,a2
     e9a:	00000517          	auipc	a0,0x0
     e9e:	74650513          	addi	a0,a0,1862 # 15e0 <digits>
     ea2:	883a                	mv	a6,a4
     ea4:	2705                	addiw	a4,a4,1
     ea6:	02c5f7bb          	remuw	a5,a1,a2
     eaa:	1782                	slli	a5,a5,0x20
     eac:	9381                	srli	a5,a5,0x20
     eae:	97aa                	add	a5,a5,a0
     eb0:	0007c783          	lbu	a5,0(a5)
     eb4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     eb8:	0005879b          	sext.w	a5,a1
     ebc:	02c5d5bb          	divuw	a1,a1,a2
     ec0:	0685                	addi	a3,a3,1
     ec2:	fec7f0e3          	bgeu	a5,a2,ea2 <printint+0x2a>
  if(neg)
     ec6:	00088c63          	beqz	a7,ede <printint+0x66>
    buf[i++] = '-';
     eca:	fd070793          	addi	a5,a4,-48
     ece:	00878733          	add	a4,a5,s0
     ed2:	02d00793          	li	a5,45
     ed6:	fef70823          	sb	a5,-16(a4)
     eda:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     ede:	02e05863          	blez	a4,f0e <printint+0x96>
     ee2:	fc040793          	addi	a5,s0,-64
     ee6:	00e78933          	add	s2,a5,a4
     eea:	fff78993          	addi	s3,a5,-1
     eee:	99ba                	add	s3,s3,a4
     ef0:	377d                	addiw	a4,a4,-1
     ef2:	1702                	slli	a4,a4,0x20
     ef4:	9301                	srli	a4,a4,0x20
     ef6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     efa:	fff94583          	lbu	a1,-1(s2)
     efe:	8526                	mv	a0,s1
     f00:	00000097          	auipc	ra,0x0
     f04:	f56080e7          	jalr	-170(ra) # e56 <putc>
  while(--i >= 0)
     f08:	197d                	addi	s2,s2,-1
     f0a:	ff3918e3          	bne	s2,s3,efa <printint+0x82>
}
     f0e:	70e2                	ld	ra,56(sp)
     f10:	7442                	ld	s0,48(sp)
     f12:	74a2                	ld	s1,40(sp)
     f14:	7902                	ld	s2,32(sp)
     f16:	69e2                	ld	s3,24(sp)
     f18:	6121                	addi	sp,sp,64
     f1a:	8082                	ret
    x = -xx;
     f1c:	40b005bb          	negw	a1,a1
    neg = 1;
     f20:	4885                	li	a7,1
    x = -xx;
     f22:	bf85                	j	e92 <printint+0x1a>

0000000000000f24 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f24:	715d                	addi	sp,sp,-80
     f26:	e486                	sd	ra,72(sp)
     f28:	e0a2                	sd	s0,64(sp)
     f2a:	fc26                	sd	s1,56(sp)
     f2c:	f84a                	sd	s2,48(sp)
     f2e:	f44e                	sd	s3,40(sp)
     f30:	f052                	sd	s4,32(sp)
     f32:	ec56                	sd	s5,24(sp)
     f34:	e85a                	sd	s6,16(sp)
     f36:	e45e                	sd	s7,8(sp)
     f38:	e062                	sd	s8,0(sp)
     f3a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f3c:	0005c903          	lbu	s2,0(a1)
     f40:	18090c63          	beqz	s2,10d8 <vprintf+0x1b4>
     f44:	8aaa                	mv	s5,a0
     f46:	8bb2                	mv	s7,a2
     f48:	00158493          	addi	s1,a1,1
  state = 0;
     f4c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     f4e:	02500a13          	li	s4,37
     f52:	4b55                	li	s6,21
     f54:	a839                	j	f72 <vprintf+0x4e>
        putc(fd, c);
     f56:	85ca                	mv	a1,s2
     f58:	8556                	mv	a0,s5
     f5a:	00000097          	auipc	ra,0x0
     f5e:	efc080e7          	jalr	-260(ra) # e56 <putc>
     f62:	a019                	j	f68 <vprintf+0x44>
    } else if(state == '%'){
     f64:	01498d63          	beq	s3,s4,f7e <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
     f68:	0485                	addi	s1,s1,1
     f6a:	fff4c903          	lbu	s2,-1(s1)
     f6e:	16090563          	beqz	s2,10d8 <vprintf+0x1b4>
    if(state == 0){
     f72:	fe0999e3          	bnez	s3,f64 <vprintf+0x40>
      if(c == '%'){
     f76:	ff4910e3          	bne	s2,s4,f56 <vprintf+0x32>
        state = '%';
     f7a:	89d2                	mv	s3,s4
     f7c:	b7f5                	j	f68 <vprintf+0x44>
      if(c == 'd'){
     f7e:	13490263          	beq	s2,s4,10a2 <vprintf+0x17e>
     f82:	f9d9079b          	addiw	a5,s2,-99
     f86:	0ff7f793          	zext.b	a5,a5
     f8a:	12fb6563          	bltu	s6,a5,10b4 <vprintf+0x190>
     f8e:	f9d9079b          	addiw	a5,s2,-99
     f92:	0ff7f713          	zext.b	a4,a5
     f96:	10eb6f63          	bltu	s6,a4,10b4 <vprintf+0x190>
     f9a:	00271793          	slli	a5,a4,0x2
     f9e:	00000717          	auipc	a4,0x0
     fa2:	5ea70713          	addi	a4,a4,1514 # 1588 <__FUNCTION__.5+0x140>
     fa6:	97ba                	add	a5,a5,a4
     fa8:	439c                	lw	a5,0(a5)
     faa:	97ba                	add	a5,a5,a4
     fac:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
     fae:	008b8913          	addi	s2,s7,8
     fb2:	4685                	li	a3,1
     fb4:	4629                	li	a2,10
     fb6:	000ba583          	lw	a1,0(s7)
     fba:	8556                	mv	a0,s5
     fbc:	00000097          	auipc	ra,0x0
     fc0:	ebc080e7          	jalr	-324(ra) # e78 <printint>
     fc4:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     fc6:	4981                	li	s3,0
     fc8:	b745                	j	f68 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     fca:	008b8913          	addi	s2,s7,8
     fce:	4681                	li	a3,0
     fd0:	4629                	li	a2,10
     fd2:	000ba583          	lw	a1,0(s7)
     fd6:	8556                	mv	a0,s5
     fd8:	00000097          	auipc	ra,0x0
     fdc:	ea0080e7          	jalr	-352(ra) # e78 <printint>
     fe0:	8bca                	mv	s7,s2
      state = 0;
     fe2:	4981                	li	s3,0
     fe4:	b751                	j	f68 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
     fe6:	008b8913          	addi	s2,s7,8
     fea:	4681                	li	a3,0
     fec:	4641                	li	a2,16
     fee:	000ba583          	lw	a1,0(s7)
     ff2:	8556                	mv	a0,s5
     ff4:	00000097          	auipc	ra,0x0
     ff8:	e84080e7          	jalr	-380(ra) # e78 <printint>
     ffc:	8bca                	mv	s7,s2
      state = 0;
     ffe:	4981                	li	s3,0
    1000:	b7a5                	j	f68 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    1002:	008b8c13          	addi	s8,s7,8
    1006:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    100a:	03000593          	li	a1,48
    100e:	8556                	mv	a0,s5
    1010:	00000097          	auipc	ra,0x0
    1014:	e46080e7          	jalr	-442(ra) # e56 <putc>
  putc(fd, 'x');
    1018:	07800593          	li	a1,120
    101c:	8556                	mv	a0,s5
    101e:	00000097          	auipc	ra,0x0
    1022:	e38080e7          	jalr	-456(ra) # e56 <putc>
    1026:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1028:	00000b97          	auipc	s7,0x0
    102c:	5b8b8b93          	addi	s7,s7,1464 # 15e0 <digits>
    1030:	03c9d793          	srli	a5,s3,0x3c
    1034:	97de                	add	a5,a5,s7
    1036:	0007c583          	lbu	a1,0(a5)
    103a:	8556                	mv	a0,s5
    103c:	00000097          	auipc	ra,0x0
    1040:	e1a080e7          	jalr	-486(ra) # e56 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1044:	0992                	slli	s3,s3,0x4
    1046:	397d                	addiw	s2,s2,-1
    1048:	fe0914e3          	bnez	s2,1030 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    104c:	8be2                	mv	s7,s8
      state = 0;
    104e:	4981                	li	s3,0
    1050:	bf21                	j	f68 <vprintf+0x44>
        s = va_arg(ap, char*);
    1052:	008b8993          	addi	s3,s7,8
    1056:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    105a:	02090163          	beqz	s2,107c <vprintf+0x158>
        while(*s != 0){
    105e:	00094583          	lbu	a1,0(s2)
    1062:	c9a5                	beqz	a1,10d2 <vprintf+0x1ae>
          putc(fd, *s);
    1064:	8556                	mv	a0,s5
    1066:	00000097          	auipc	ra,0x0
    106a:	df0080e7          	jalr	-528(ra) # e56 <putc>
          s++;
    106e:	0905                	addi	s2,s2,1
        while(*s != 0){
    1070:	00094583          	lbu	a1,0(s2)
    1074:	f9e5                	bnez	a1,1064 <vprintf+0x140>
        s = va_arg(ap, char*);
    1076:	8bce                	mv	s7,s3
      state = 0;
    1078:	4981                	li	s3,0
    107a:	b5fd                	j	f68 <vprintf+0x44>
          s = "(null)";
    107c:	00000917          	auipc	s2,0x0
    1080:	50490913          	addi	s2,s2,1284 # 1580 <__FUNCTION__.5+0x138>
        while(*s != 0){
    1084:	02800593          	li	a1,40
    1088:	bff1                	j	1064 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    108a:	008b8913          	addi	s2,s7,8
    108e:	000bc583          	lbu	a1,0(s7)
    1092:	8556                	mv	a0,s5
    1094:	00000097          	auipc	ra,0x0
    1098:	dc2080e7          	jalr	-574(ra) # e56 <putc>
    109c:	8bca                	mv	s7,s2
      state = 0;
    109e:	4981                	li	s3,0
    10a0:	b5e1                	j	f68 <vprintf+0x44>
        putc(fd, c);
    10a2:	02500593          	li	a1,37
    10a6:	8556                	mv	a0,s5
    10a8:	00000097          	auipc	ra,0x0
    10ac:	dae080e7          	jalr	-594(ra) # e56 <putc>
      state = 0;
    10b0:	4981                	li	s3,0
    10b2:	bd5d                	j	f68 <vprintf+0x44>
        putc(fd, '%');
    10b4:	02500593          	li	a1,37
    10b8:	8556                	mv	a0,s5
    10ba:	00000097          	auipc	ra,0x0
    10be:	d9c080e7          	jalr	-612(ra) # e56 <putc>
        putc(fd, c);
    10c2:	85ca                	mv	a1,s2
    10c4:	8556                	mv	a0,s5
    10c6:	00000097          	auipc	ra,0x0
    10ca:	d90080e7          	jalr	-624(ra) # e56 <putc>
      state = 0;
    10ce:	4981                	li	s3,0
    10d0:	bd61                	j	f68 <vprintf+0x44>
        s = va_arg(ap, char*);
    10d2:	8bce                	mv	s7,s3
      state = 0;
    10d4:	4981                	li	s3,0
    10d6:	bd49                	j	f68 <vprintf+0x44>
    }
  }
}
    10d8:	60a6                	ld	ra,72(sp)
    10da:	6406                	ld	s0,64(sp)
    10dc:	74e2                	ld	s1,56(sp)
    10de:	7942                	ld	s2,48(sp)
    10e0:	79a2                	ld	s3,40(sp)
    10e2:	7a02                	ld	s4,32(sp)
    10e4:	6ae2                	ld	s5,24(sp)
    10e6:	6b42                	ld	s6,16(sp)
    10e8:	6ba2                	ld	s7,8(sp)
    10ea:	6c02                	ld	s8,0(sp)
    10ec:	6161                	addi	sp,sp,80
    10ee:	8082                	ret

00000000000010f0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    10f0:	715d                	addi	sp,sp,-80
    10f2:	ec06                	sd	ra,24(sp)
    10f4:	e822                	sd	s0,16(sp)
    10f6:	1000                	addi	s0,sp,32
    10f8:	e010                	sd	a2,0(s0)
    10fa:	e414                	sd	a3,8(s0)
    10fc:	e818                	sd	a4,16(s0)
    10fe:	ec1c                	sd	a5,24(s0)
    1100:	03043023          	sd	a6,32(s0)
    1104:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1108:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    110c:	8622                	mv	a2,s0
    110e:	00000097          	auipc	ra,0x0
    1112:	e16080e7          	jalr	-490(ra) # f24 <vprintf>
}
    1116:	60e2                	ld	ra,24(sp)
    1118:	6442                	ld	s0,16(sp)
    111a:	6161                	addi	sp,sp,80
    111c:	8082                	ret

000000000000111e <printf>:

void
printf(const char *fmt, ...)
{
    111e:	711d                	addi	sp,sp,-96
    1120:	ec06                	sd	ra,24(sp)
    1122:	e822                	sd	s0,16(sp)
    1124:	1000                	addi	s0,sp,32
    1126:	e40c                	sd	a1,8(s0)
    1128:	e810                	sd	a2,16(s0)
    112a:	ec14                	sd	a3,24(s0)
    112c:	f018                	sd	a4,32(s0)
    112e:	f41c                	sd	a5,40(s0)
    1130:	03043823          	sd	a6,48(s0)
    1134:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1138:	00840613          	addi	a2,s0,8
    113c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1140:	85aa                	mv	a1,a0
    1142:	4505                	li	a0,1
    1144:	00000097          	auipc	ra,0x0
    1148:	de0080e7          	jalr	-544(ra) # f24 <vprintf>
}
    114c:	60e2                	ld	ra,24(sp)
    114e:	6442                	ld	s0,16(sp)
    1150:	6125                	addi	sp,sp,96
    1152:	8082                	ret

0000000000001154 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    1154:	1141                	addi	sp,sp,-16
    1156:	e422                	sd	s0,8(sp)
    1158:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    115a:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    115e:	00001797          	auipc	a5,0x1
    1162:	ec27b783          	ld	a5,-318(a5) # 2020 <freep>
    1166:	a02d                	j	1190 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    1168:	4618                	lw	a4,8(a2)
    116a:	9f2d                	addw	a4,a4,a1
    116c:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    1170:	6398                	ld	a4,0(a5)
    1172:	6310                	ld	a2,0(a4)
    1174:	a83d                	j	11b2 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    1176:	ff852703          	lw	a4,-8(a0)
    117a:	9f31                	addw	a4,a4,a2
    117c:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    117e:	ff053683          	ld	a3,-16(a0)
    1182:	a091                	j	11c6 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1184:	6398                	ld	a4,0(a5)
    1186:	00e7e463          	bltu	a5,a4,118e <free+0x3a>
    118a:	00e6ea63          	bltu	a3,a4,119e <free+0x4a>
{
    118e:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1190:	fed7fae3          	bgeu	a5,a3,1184 <free+0x30>
    1194:	6398                	ld	a4,0(a5)
    1196:	00e6e463          	bltu	a3,a4,119e <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    119a:	fee7eae3          	bltu	a5,a4,118e <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    119e:	ff852583          	lw	a1,-8(a0)
    11a2:	6390                	ld	a2,0(a5)
    11a4:	02059813          	slli	a6,a1,0x20
    11a8:	01c85713          	srli	a4,a6,0x1c
    11ac:	9736                	add	a4,a4,a3
    11ae:	fae60de3          	beq	a2,a4,1168 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    11b2:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    11b6:	4790                	lw	a2,8(a5)
    11b8:	02061593          	slli	a1,a2,0x20
    11bc:	01c5d713          	srli	a4,a1,0x1c
    11c0:	973e                	add	a4,a4,a5
    11c2:	fae68ae3          	beq	a3,a4,1176 <free+0x22>
        p->s.ptr = bp->s.ptr;
    11c6:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    11c8:	00001717          	auipc	a4,0x1
    11cc:	e4f73c23          	sd	a5,-424(a4) # 2020 <freep>
}
    11d0:	6422                	ld	s0,8(sp)
    11d2:	0141                	addi	sp,sp,16
    11d4:	8082                	ret

00000000000011d6 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    11d6:	7139                	addi	sp,sp,-64
    11d8:	fc06                	sd	ra,56(sp)
    11da:	f822                	sd	s0,48(sp)
    11dc:	f426                	sd	s1,40(sp)
    11de:	f04a                	sd	s2,32(sp)
    11e0:	ec4e                	sd	s3,24(sp)
    11e2:	e852                	sd	s4,16(sp)
    11e4:	e456                	sd	s5,8(sp)
    11e6:	e05a                	sd	s6,0(sp)
    11e8:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    11ea:	02051493          	slli	s1,a0,0x20
    11ee:	9081                	srli	s1,s1,0x20
    11f0:	04bd                	addi	s1,s1,15
    11f2:	8091                	srli	s1,s1,0x4
    11f4:	0014899b          	addiw	s3,s1,1
    11f8:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    11fa:	00001517          	auipc	a0,0x1
    11fe:	e2653503          	ld	a0,-474(a0) # 2020 <freep>
    1202:	c515                	beqz	a0,122e <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    1204:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    1206:	4798                	lw	a4,8(a5)
    1208:	02977f63          	bgeu	a4,s1,1246 <malloc+0x70>
    if (nu < 4096)
    120c:	8a4e                	mv	s4,s3
    120e:	0009871b          	sext.w	a4,s3
    1212:	6685                	lui	a3,0x1
    1214:	00d77363          	bgeu	a4,a3,121a <malloc+0x44>
    1218:	6a05                	lui	s4,0x1
    121a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    121e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    1222:	00001917          	auipc	s2,0x1
    1226:	dfe90913          	addi	s2,s2,-514 # 2020 <freep>
    if (p == (char *)-1)
    122a:	5afd                	li	s5,-1
    122c:	a895                	j	12a0 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    122e:	00001797          	auipc	a5,0x1
    1232:	e9a78793          	addi	a5,a5,-358 # 20c8 <base>
    1236:	00001717          	auipc	a4,0x1
    123a:	def73523          	sd	a5,-534(a4) # 2020 <freep>
    123e:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    1240:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    1244:	b7e1                	j	120c <malloc+0x36>
            if (p->s.size == nunits)
    1246:	02e48c63          	beq	s1,a4,127e <malloc+0xa8>
                p->s.size -= nunits;
    124a:	4137073b          	subw	a4,a4,s3
    124e:	c798                	sw	a4,8(a5)
                p += p->s.size;
    1250:	02071693          	slli	a3,a4,0x20
    1254:	01c6d713          	srli	a4,a3,0x1c
    1258:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    125a:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    125e:	00001717          	auipc	a4,0x1
    1262:	dca73123          	sd	a0,-574(a4) # 2020 <freep>
            return (void *)(p + 1);
    1266:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    126a:	70e2                	ld	ra,56(sp)
    126c:	7442                	ld	s0,48(sp)
    126e:	74a2                	ld	s1,40(sp)
    1270:	7902                	ld	s2,32(sp)
    1272:	69e2                	ld	s3,24(sp)
    1274:	6a42                	ld	s4,16(sp)
    1276:	6aa2                	ld	s5,8(sp)
    1278:	6b02                	ld	s6,0(sp)
    127a:	6121                	addi	sp,sp,64
    127c:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    127e:	6398                	ld	a4,0(a5)
    1280:	e118                	sd	a4,0(a0)
    1282:	bff1                	j	125e <malloc+0x88>
    hp->s.size = nu;
    1284:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    1288:	0541                	addi	a0,a0,16
    128a:	00000097          	auipc	ra,0x0
    128e:	eca080e7          	jalr	-310(ra) # 1154 <free>
    return freep;
    1292:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    1296:	d971                	beqz	a0,126a <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    1298:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    129a:	4798                	lw	a4,8(a5)
    129c:	fa9775e3          	bgeu	a4,s1,1246 <malloc+0x70>
        if (p == freep)
    12a0:	00093703          	ld	a4,0(s2)
    12a4:	853e                	mv	a0,a5
    12a6:	fef719e3          	bne	a4,a5,1298 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    12aa:	8552                	mv	a0,s4
    12ac:	00000097          	auipc	ra,0x0
    12b0:	b7a080e7          	jalr	-1158(ra) # e26 <sbrk>
    if (p == (char *)-1)
    12b4:	fd5518e3          	bne	a0,s5,1284 <malloc+0xae>
                return 0;
    12b8:	4501                	li	a0,0
    12ba:	bf45                	j	126a <malloc+0x94>
