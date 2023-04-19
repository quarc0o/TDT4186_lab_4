
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1ce95>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <base+0x1d1f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd064>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	addi	a0,a0,-96 # 2000 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	addi	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	addi	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	addi	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	1e6080e7          	jalr	486(ra) # 1276 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	67650513          	addi	a0,a0,1654 # 1710 <malloc+0xea>
      a2:	00001097          	auipc	ra,0x1
      a6:	1b4080e7          	jalr	436(ra) # 1256 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	66650513          	addi	a0,a0,1638 # 1710 <malloc+0xea>
      b2:	00001097          	auipc	ra,0x1
      b6:	1ac080e7          	jalr	428(ra) # 125e <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	65c50513          	addi	a0,a0,1628 # 1718 <malloc+0xf2>
      c4:	00001097          	auipc	ra,0x1
      c8:	4aa080e7          	jalr	1194(ra) # 156e <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	120080e7          	jalr	288(ra) # 11ee <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	66250513          	addi	a0,a0,1634 # 1738 <malloc+0x112>
      de:	00001097          	auipc	ra,0x1
      e2:	180080e7          	jalr	384(ra) # 125e <chdir>
      e6:	00001997          	auipc	s3,0x1
      ea:	66298993          	addi	s3,s3,1634 # 1748 <malloc+0x122>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	65098993          	addi	s3,s3,1616 # 1740 <malloc+0x11a>
  uint64 iters = 0;
      f8:	4481                	li	s1,0
  int fd = -1;
      fa:	5a7d                	li	s4,-1
      fc:	00002917          	auipc	s2,0x2
     100:	8fc90913          	addi	s2,s2,-1796 # 19f8 <malloc+0x3d2>
     104:	a839                	j	122 <go+0xaa>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	64650513          	addi	a0,a0,1606 # 1750 <malloc+0x12a>
     112:	00001097          	auipc	ra,0x1
     116:	11c080e7          	jalr	284(ra) # 122e <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	0fc080e7          	jalr	252(ra) # 1216 <close>
    iters++;
     122:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     124:	1f400793          	li	a5,500
     128:	02f4f7b3          	remu	a5,s1,a5
     12c:	eb81                	bnez	a5,13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
     12e:	4605                	li	a2,1
     130:	85ce                	mv	a1,s3
     132:	4505                	li	a0,1
     134:	00001097          	auipc	ra,0x1
     138:	0da080e7          	jalr	218(ra) # 120e <write>
    int what = rand() % 23;
     13c:	00000097          	auipc	ra,0x0
     140:	f1c080e7          	jalr	-228(ra) # 58 <rand>
     144:	47dd                	li	a5,23
     146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14a:	4785                	li	a5,1
     14c:	faf50de3          	beq	a0,a5,106 <go+0x8e>
    } else if(what == 2){
     150:	47d9                	li	a5,22
     152:	fca7e8e3          	bltu	a5,a0,122 <go+0xaa>
     156:	050a                	slli	a0,a0,0x2
     158:	954a                	add	a0,a0,s2
     15a:	411c                	lw	a5,0(a0)
     15c:	97ca                	add	a5,a5,s2
     15e:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     160:	20200593          	li	a1,514
     164:	00001517          	auipc	a0,0x1
     168:	5fc50513          	addi	a0,a0,1532 # 1760 <malloc+0x13a>
     16c:	00001097          	auipc	ra,0x1
     170:	0c2080e7          	jalr	194(ra) # 122e <open>
     174:	00001097          	auipc	ra,0x1
     178:	0a2080e7          	jalr	162(ra) # 1216 <close>
     17c:	b75d                	j	122 <go+0xaa>
    } else if(what == 3){
      unlink("grindir/../a");
     17e:	00001517          	auipc	a0,0x1
     182:	5d250513          	addi	a0,a0,1490 # 1750 <malloc+0x12a>
     186:	00001097          	auipc	ra,0x1
     18a:	0b8080e7          	jalr	184(ra) # 123e <unlink>
     18e:	bf51                	j	122 <go+0xaa>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     190:	00001517          	auipc	a0,0x1
     194:	58050513          	addi	a0,a0,1408 # 1710 <malloc+0xea>
     198:	00001097          	auipc	ra,0x1
     19c:	0c6080e7          	jalr	198(ra) # 125e <chdir>
     1a0:	e115                	bnez	a0,1c4 <go+0x14c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     1a2:	00001517          	auipc	a0,0x1
     1a6:	5d650513          	addi	a0,a0,1494 # 1778 <malloc+0x152>
     1aa:	00001097          	auipc	ra,0x1
     1ae:	094080e7          	jalr	148(ra) # 123e <unlink>
      chdir("/");
     1b2:	00001517          	auipc	a0,0x1
     1b6:	58650513          	addi	a0,a0,1414 # 1738 <malloc+0x112>
     1ba:	00001097          	auipc	ra,0x1
     1be:	0a4080e7          	jalr	164(ra) # 125e <chdir>
     1c2:	b785                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     1c4:	00001517          	auipc	a0,0x1
     1c8:	55450513          	addi	a0,a0,1364 # 1718 <malloc+0xf2>
     1cc:	00001097          	auipc	ra,0x1
     1d0:	3a2080e7          	jalr	930(ra) # 156e <printf>
        exit(1);
     1d4:	4505                	li	a0,1
     1d6:	00001097          	auipc	ra,0x1
     1da:	018080e7          	jalr	24(ra) # 11ee <exit>
    } else if(what == 5){
      close(fd);
     1de:	8552                	mv	a0,s4
     1e0:	00001097          	auipc	ra,0x1
     1e4:	036080e7          	jalr	54(ra) # 1216 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1e8:	20200593          	li	a1,514
     1ec:	00001517          	auipc	a0,0x1
     1f0:	59450513          	addi	a0,a0,1428 # 1780 <malloc+0x15a>
     1f4:	00001097          	auipc	ra,0x1
     1f8:	03a080e7          	jalr	58(ra) # 122e <open>
     1fc:	8a2a                	mv	s4,a0
     1fe:	b715                	j	122 <go+0xaa>
    } else if(what == 6){
      close(fd);
     200:	8552                	mv	a0,s4
     202:	00001097          	auipc	ra,0x1
     206:	014080e7          	jalr	20(ra) # 1216 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	58250513          	addi	a0,a0,1410 # 1790 <malloc+0x16a>
     216:	00001097          	auipc	ra,0x1
     21a:	018080e7          	jalr	24(ra) # 122e <open>
     21e:	8a2a                	mv	s4,a0
     220:	b709                	j	122 <go+0xaa>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     222:	3e700613          	li	a2,999
     226:	00002597          	auipc	a1,0x2
     22a:	dfa58593          	addi	a1,a1,-518 # 2020 <buf.0>
     22e:	8552                	mv	a0,s4
     230:	00001097          	auipc	ra,0x1
     234:	fde080e7          	jalr	-34(ra) # 120e <write>
     238:	b5ed                	j	122 <go+0xaa>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     23a:	3e700613          	li	a2,999
     23e:	00002597          	auipc	a1,0x2
     242:	de258593          	addi	a1,a1,-542 # 2020 <buf.0>
     246:	8552                	mv	a0,s4
     248:	00001097          	auipc	ra,0x1
     24c:	fbe080e7          	jalr	-66(ra) # 1206 <read>
     250:	bdc9                	j	122 <go+0xaa>
    } else if(what == 9){
      mkdir("grindir/../a");
     252:	00001517          	auipc	a0,0x1
     256:	4fe50513          	addi	a0,a0,1278 # 1750 <malloc+0x12a>
     25a:	00001097          	auipc	ra,0x1
     25e:	ffc080e7          	jalr	-4(ra) # 1256 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     262:	20200593          	li	a1,514
     266:	00001517          	auipc	a0,0x1
     26a:	54250513          	addi	a0,a0,1346 # 17a8 <malloc+0x182>
     26e:	00001097          	auipc	ra,0x1
     272:	fc0080e7          	jalr	-64(ra) # 122e <open>
     276:	00001097          	auipc	ra,0x1
     27a:	fa0080e7          	jalr	-96(ra) # 1216 <close>
      unlink("a/a");
     27e:	00001517          	auipc	a0,0x1
     282:	53a50513          	addi	a0,a0,1338 # 17b8 <malloc+0x192>
     286:	00001097          	auipc	ra,0x1
     28a:	fb8080e7          	jalr	-72(ra) # 123e <unlink>
     28e:	bd51                	j	122 <go+0xaa>
    } else if(what == 10){
      mkdir("/../b");
     290:	00001517          	auipc	a0,0x1
     294:	53050513          	addi	a0,a0,1328 # 17c0 <malloc+0x19a>
     298:	00001097          	auipc	ra,0x1
     29c:	fbe080e7          	jalr	-66(ra) # 1256 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2a0:	20200593          	li	a1,514
     2a4:	00001517          	auipc	a0,0x1
     2a8:	52450513          	addi	a0,a0,1316 # 17c8 <malloc+0x1a2>
     2ac:	00001097          	auipc	ra,0x1
     2b0:	f82080e7          	jalr	-126(ra) # 122e <open>
     2b4:	00001097          	auipc	ra,0x1
     2b8:	f62080e7          	jalr	-158(ra) # 1216 <close>
      unlink("b/b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	51c50513          	addi	a0,a0,1308 # 17d8 <malloc+0x1b2>
     2c4:	00001097          	auipc	ra,0x1
     2c8:	f7a080e7          	jalr	-134(ra) # 123e <unlink>
     2cc:	bd99                	j	122 <go+0xaa>
    } else if(what == 11){
      unlink("b");
     2ce:	00001517          	auipc	a0,0x1
     2d2:	4d250513          	addi	a0,a0,1234 # 17a0 <malloc+0x17a>
     2d6:	00001097          	auipc	ra,0x1
     2da:	f68080e7          	jalr	-152(ra) # 123e <unlink>
      link("../grindir/./../a", "../b");
     2de:	00001597          	auipc	a1,0x1
     2e2:	49a58593          	addi	a1,a1,1178 # 1778 <malloc+0x152>
     2e6:	00001517          	auipc	a0,0x1
     2ea:	4fa50513          	addi	a0,a0,1274 # 17e0 <malloc+0x1ba>
     2ee:	00001097          	auipc	ra,0x1
     2f2:	f60080e7          	jalr	-160(ra) # 124e <link>
     2f6:	b535                	j	122 <go+0xaa>
    } else if(what == 12){
      unlink("../grindir/../a");
     2f8:	00001517          	auipc	a0,0x1
     2fc:	50050513          	addi	a0,a0,1280 # 17f8 <malloc+0x1d2>
     300:	00001097          	auipc	ra,0x1
     304:	f3e080e7          	jalr	-194(ra) # 123e <unlink>
      link(".././b", "/grindir/../a");
     308:	00001597          	auipc	a1,0x1
     30c:	47858593          	addi	a1,a1,1144 # 1780 <malloc+0x15a>
     310:	00001517          	auipc	a0,0x1
     314:	4f850513          	addi	a0,a0,1272 # 1808 <malloc+0x1e2>
     318:	00001097          	auipc	ra,0x1
     31c:	f36080e7          	jalr	-202(ra) # 124e <link>
     320:	b509                	j	122 <go+0xaa>
    } else if(what == 13){
      int pid = fork();
     322:	00001097          	auipc	ra,0x1
     326:	ec4080e7          	jalr	-316(ra) # 11e6 <fork>
      if(pid == 0){
     32a:	c909                	beqz	a0,33c <go+0x2c4>
        exit(0);
      } else if(pid < 0){
     32c:	00054c63          	bltz	a0,344 <go+0x2cc>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     330:	4501                	li	a0,0
     332:	00001097          	auipc	ra,0x1
     336:	ec4080e7          	jalr	-316(ra) # 11f6 <wait>
     33a:	b3e5                	j	122 <go+0xaa>
        exit(0);
     33c:	00001097          	auipc	ra,0x1
     340:	eb2080e7          	jalr	-334(ra) # 11ee <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	4cc50513          	addi	a0,a0,1228 # 1810 <malloc+0x1ea>
     34c:	00001097          	auipc	ra,0x1
     350:	222080e7          	jalr	546(ra) # 156e <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	00001097          	auipc	ra,0x1
     35a:	e98080e7          	jalr	-360(ra) # 11ee <exit>
    } else if(what == 14){
      int pid = fork();
     35e:	00001097          	auipc	ra,0x1
     362:	e88080e7          	jalr	-376(ra) # 11e6 <fork>
      if(pid == 0){
     366:	c909                	beqz	a0,378 <go+0x300>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     368:	02054563          	bltz	a0,392 <go+0x31a>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     36c:	4501                	li	a0,0
     36e:	00001097          	auipc	ra,0x1
     372:	e88080e7          	jalr	-376(ra) # 11f6 <wait>
     376:	b375                	j	122 <go+0xaa>
        fork();
     378:	00001097          	auipc	ra,0x1
     37c:	e6e080e7          	jalr	-402(ra) # 11e6 <fork>
        fork();
     380:	00001097          	auipc	ra,0x1
     384:	e66080e7          	jalr	-410(ra) # 11e6 <fork>
        exit(0);
     388:	4501                	li	a0,0
     38a:	00001097          	auipc	ra,0x1
     38e:	e64080e7          	jalr	-412(ra) # 11ee <exit>
        printf("grind: fork failed\n");
     392:	00001517          	auipc	a0,0x1
     396:	47e50513          	addi	a0,a0,1150 # 1810 <malloc+0x1ea>
     39a:	00001097          	auipc	ra,0x1
     39e:	1d4080e7          	jalr	468(ra) # 156e <printf>
        exit(1);
     3a2:	4505                	li	a0,1
     3a4:	00001097          	auipc	ra,0x1
     3a8:	e4a080e7          	jalr	-438(ra) # 11ee <exit>
    } else if(what == 15){
      sbrk(6011);
     3ac:	6505                	lui	a0,0x1
     3ae:	77b50513          	addi	a0,a0,1915 # 177b <malloc+0x155>
     3b2:	00001097          	auipc	ra,0x1
     3b6:	ec4080e7          	jalr	-316(ra) # 1276 <sbrk>
     3ba:	b3a5                	j	122 <go+0xaa>
    } else if(what == 16){
      if(sbrk(0) > break0)
     3bc:	4501                	li	a0,0
     3be:	00001097          	auipc	ra,0x1
     3c2:	eb8080e7          	jalr	-328(ra) # 1276 <sbrk>
     3c6:	d4aafee3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     3ca:	4501                	li	a0,0
     3cc:	00001097          	auipc	ra,0x1
     3d0:	eaa080e7          	jalr	-342(ra) # 1276 <sbrk>
     3d4:	40aa853b          	subw	a0,s5,a0
     3d8:	00001097          	auipc	ra,0x1
     3dc:	e9e080e7          	jalr	-354(ra) # 1276 <sbrk>
     3e0:	b389                	j	122 <go+0xaa>
    } else if(what == 17){
      int pid = fork();
     3e2:	00001097          	auipc	ra,0x1
     3e6:	e04080e7          	jalr	-508(ra) # 11e6 <fork>
     3ea:	8b2a                	mv	s6,a0
      if(pid == 0){
     3ec:	c51d                	beqz	a0,41a <go+0x3a2>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     3ee:	04054963          	bltz	a0,440 <go+0x3c8>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     3f2:	00001517          	auipc	a0,0x1
     3f6:	43650513          	addi	a0,a0,1078 # 1828 <malloc+0x202>
     3fa:	00001097          	auipc	ra,0x1
     3fe:	e64080e7          	jalr	-412(ra) # 125e <chdir>
     402:	ed21                	bnez	a0,45a <go+0x3e2>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     404:	855a                	mv	a0,s6
     406:	00001097          	auipc	ra,0x1
     40a:	e18080e7          	jalr	-488(ra) # 121e <kill>
      wait(0);
     40e:	4501                	li	a0,0
     410:	00001097          	auipc	ra,0x1
     414:	de6080e7          	jalr	-538(ra) # 11f6 <wait>
     418:	b329                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     41a:	20200593          	li	a1,514
     41e:	00001517          	auipc	a0,0x1
     422:	3d250513          	addi	a0,a0,978 # 17f0 <malloc+0x1ca>
     426:	00001097          	auipc	ra,0x1
     42a:	e08080e7          	jalr	-504(ra) # 122e <open>
     42e:	00001097          	auipc	ra,0x1
     432:	de8080e7          	jalr	-536(ra) # 1216 <close>
        exit(0);
     436:	4501                	li	a0,0
     438:	00001097          	auipc	ra,0x1
     43c:	db6080e7          	jalr	-586(ra) # 11ee <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	3d050513          	addi	a0,a0,976 # 1810 <malloc+0x1ea>
     448:	00001097          	auipc	ra,0x1
     44c:	126080e7          	jalr	294(ra) # 156e <printf>
        exit(1);
     450:	4505                	li	a0,1
     452:	00001097          	auipc	ra,0x1
     456:	d9c080e7          	jalr	-612(ra) # 11ee <exit>
        printf("grind: chdir failed\n");
     45a:	00001517          	auipc	a0,0x1
     45e:	3de50513          	addi	a0,a0,990 # 1838 <malloc+0x212>
     462:	00001097          	auipc	ra,0x1
     466:	10c080e7          	jalr	268(ra) # 156e <printf>
        exit(1);
     46a:	4505                	li	a0,1
     46c:	00001097          	auipc	ra,0x1
     470:	d82080e7          	jalr	-638(ra) # 11ee <exit>
    } else if(what == 18){
      int pid = fork();
     474:	00001097          	auipc	ra,0x1
     478:	d72080e7          	jalr	-654(ra) # 11e6 <fork>
      if(pid == 0){
     47c:	c909                	beqz	a0,48e <go+0x416>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     47e:	02054563          	bltz	a0,4a8 <go+0x430>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     482:	4501                	li	a0,0
     484:	00001097          	auipc	ra,0x1
     488:	d72080e7          	jalr	-654(ra) # 11f6 <wait>
     48c:	b959                	j	122 <go+0xaa>
        kill(getpid());
     48e:	00001097          	auipc	ra,0x1
     492:	de0080e7          	jalr	-544(ra) # 126e <getpid>
     496:	00001097          	auipc	ra,0x1
     49a:	d88080e7          	jalr	-632(ra) # 121e <kill>
        exit(0);
     49e:	4501                	li	a0,0
     4a0:	00001097          	auipc	ra,0x1
     4a4:	d4e080e7          	jalr	-690(ra) # 11ee <exit>
        printf("grind: fork failed\n");
     4a8:	00001517          	auipc	a0,0x1
     4ac:	36850513          	addi	a0,a0,872 # 1810 <malloc+0x1ea>
     4b0:	00001097          	auipc	ra,0x1
     4b4:	0be080e7          	jalr	190(ra) # 156e <printf>
        exit(1);
     4b8:	4505                	li	a0,1
     4ba:	00001097          	auipc	ra,0x1
     4be:	d34080e7          	jalr	-716(ra) # 11ee <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     4c2:	fa840513          	addi	a0,s0,-88
     4c6:	00001097          	auipc	ra,0x1
     4ca:	d38080e7          	jalr	-712(ra) # 11fe <pipe>
     4ce:	02054b63          	bltz	a0,504 <go+0x48c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     4d2:	00001097          	auipc	ra,0x1
     4d6:	d14080e7          	jalr	-748(ra) # 11e6 <fork>
      if(pid == 0){
     4da:	c131                	beqz	a0,51e <go+0x4a6>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     4dc:	0a054a63          	bltz	a0,590 <go+0x518>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     4e0:	fa842503          	lw	a0,-88(s0)
     4e4:	00001097          	auipc	ra,0x1
     4e8:	d32080e7          	jalr	-718(ra) # 1216 <close>
      close(fds[1]);
     4ec:	fac42503          	lw	a0,-84(s0)
     4f0:	00001097          	auipc	ra,0x1
     4f4:	d26080e7          	jalr	-730(ra) # 1216 <close>
      wait(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	cfc080e7          	jalr	-772(ra) # 11f6 <wait>
     502:	b105                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     504:	00001517          	auipc	a0,0x1
     508:	34c50513          	addi	a0,a0,844 # 1850 <malloc+0x22a>
     50c:	00001097          	auipc	ra,0x1
     510:	062080e7          	jalr	98(ra) # 156e <printf>
        exit(1);
     514:	4505                	li	a0,1
     516:	00001097          	auipc	ra,0x1
     51a:	cd8080e7          	jalr	-808(ra) # 11ee <exit>
        fork();
     51e:	00001097          	auipc	ra,0x1
     522:	cc8080e7          	jalr	-824(ra) # 11e6 <fork>
        fork();
     526:	00001097          	auipc	ra,0x1
     52a:	cc0080e7          	jalr	-832(ra) # 11e6 <fork>
        if(write(fds[1], "x", 1) != 1)
     52e:	4605                	li	a2,1
     530:	00001597          	auipc	a1,0x1
     534:	33858593          	addi	a1,a1,824 # 1868 <malloc+0x242>
     538:	fac42503          	lw	a0,-84(s0)
     53c:	00001097          	auipc	ra,0x1
     540:	cd2080e7          	jalr	-814(ra) # 120e <write>
     544:	4785                	li	a5,1
     546:	02f51363          	bne	a0,a5,56c <go+0x4f4>
        if(read(fds[0], &c, 1) != 1)
     54a:	4605                	li	a2,1
     54c:	fa040593          	addi	a1,s0,-96
     550:	fa842503          	lw	a0,-88(s0)
     554:	00001097          	auipc	ra,0x1
     558:	cb2080e7          	jalr	-846(ra) # 1206 <read>
     55c:	4785                	li	a5,1
     55e:	02f51063          	bne	a0,a5,57e <go+0x506>
        exit(0);
     562:	4501                	li	a0,0
     564:	00001097          	auipc	ra,0x1
     568:	c8a080e7          	jalr	-886(ra) # 11ee <exit>
          printf("grind: pipe write failed\n");
     56c:	00001517          	auipc	a0,0x1
     570:	30450513          	addi	a0,a0,772 # 1870 <malloc+0x24a>
     574:	00001097          	auipc	ra,0x1
     578:	ffa080e7          	jalr	-6(ra) # 156e <printf>
     57c:	b7f9                	j	54a <go+0x4d2>
          printf("grind: pipe read failed\n");
     57e:	00001517          	auipc	a0,0x1
     582:	31250513          	addi	a0,a0,786 # 1890 <malloc+0x26a>
     586:	00001097          	auipc	ra,0x1
     58a:	fe8080e7          	jalr	-24(ra) # 156e <printf>
     58e:	bfd1                	j	562 <go+0x4ea>
        printf("grind: fork failed\n");
     590:	00001517          	auipc	a0,0x1
     594:	28050513          	addi	a0,a0,640 # 1810 <malloc+0x1ea>
     598:	00001097          	auipc	ra,0x1
     59c:	fd6080e7          	jalr	-42(ra) # 156e <printf>
        exit(1);
     5a0:	4505                	li	a0,1
     5a2:	00001097          	auipc	ra,0x1
     5a6:	c4c080e7          	jalr	-948(ra) # 11ee <exit>
    } else if(what == 20){
      int pid = fork();
     5aa:	00001097          	auipc	ra,0x1
     5ae:	c3c080e7          	jalr	-964(ra) # 11e6 <fork>
      if(pid == 0){
     5b2:	c909                	beqz	a0,5c4 <go+0x54c>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     5b4:	06054f63          	bltz	a0,632 <go+0x5ba>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     5b8:	4501                	li	a0,0
     5ba:	00001097          	auipc	ra,0x1
     5be:	c3c080e7          	jalr	-964(ra) # 11f6 <wait>
     5c2:	b685                	j	122 <go+0xaa>
        unlink("a");
     5c4:	00001517          	auipc	a0,0x1
     5c8:	22c50513          	addi	a0,a0,556 # 17f0 <malloc+0x1ca>
     5cc:	00001097          	auipc	ra,0x1
     5d0:	c72080e7          	jalr	-910(ra) # 123e <unlink>
        mkdir("a");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	21c50513          	addi	a0,a0,540 # 17f0 <malloc+0x1ca>
     5dc:	00001097          	auipc	ra,0x1
     5e0:	c7a080e7          	jalr	-902(ra) # 1256 <mkdir>
        chdir("a");
     5e4:	00001517          	auipc	a0,0x1
     5e8:	20c50513          	addi	a0,a0,524 # 17f0 <malloc+0x1ca>
     5ec:	00001097          	auipc	ra,0x1
     5f0:	c72080e7          	jalr	-910(ra) # 125e <chdir>
        unlink("../a");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	16450513          	addi	a0,a0,356 # 1758 <malloc+0x132>
     5fc:	00001097          	auipc	ra,0x1
     600:	c42080e7          	jalr	-958(ra) # 123e <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     604:	20200593          	li	a1,514
     608:	00001517          	auipc	a0,0x1
     60c:	26050513          	addi	a0,a0,608 # 1868 <malloc+0x242>
     610:	00001097          	auipc	ra,0x1
     614:	c1e080e7          	jalr	-994(ra) # 122e <open>
        unlink("x");
     618:	00001517          	auipc	a0,0x1
     61c:	25050513          	addi	a0,a0,592 # 1868 <malloc+0x242>
     620:	00001097          	auipc	ra,0x1
     624:	c1e080e7          	jalr	-994(ra) # 123e <unlink>
        exit(0);
     628:	4501                	li	a0,0
     62a:	00001097          	auipc	ra,0x1
     62e:	bc4080e7          	jalr	-1084(ra) # 11ee <exit>
        printf("grind: fork failed\n");
     632:	00001517          	auipc	a0,0x1
     636:	1de50513          	addi	a0,a0,478 # 1810 <malloc+0x1ea>
     63a:	00001097          	auipc	ra,0x1
     63e:	f34080e7          	jalr	-204(ra) # 156e <printf>
        exit(1);
     642:	4505                	li	a0,1
     644:	00001097          	auipc	ra,0x1
     648:	baa080e7          	jalr	-1110(ra) # 11ee <exit>
    } else if(what == 21){
      unlink("c");
     64c:	00001517          	auipc	a0,0x1
     650:	26450513          	addi	a0,a0,612 # 18b0 <malloc+0x28a>
     654:	00001097          	auipc	ra,0x1
     658:	bea080e7          	jalr	-1046(ra) # 123e <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     65c:	20200593          	li	a1,514
     660:	00001517          	auipc	a0,0x1
     664:	25050513          	addi	a0,a0,592 # 18b0 <malloc+0x28a>
     668:	00001097          	auipc	ra,0x1
     66c:	bc6080e7          	jalr	-1082(ra) # 122e <open>
     670:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     672:	04054f63          	bltz	a0,6d0 <go+0x658>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     676:	4605                	li	a2,1
     678:	00001597          	auipc	a1,0x1
     67c:	1f058593          	addi	a1,a1,496 # 1868 <malloc+0x242>
     680:	00001097          	auipc	ra,0x1
     684:	b8e080e7          	jalr	-1138(ra) # 120e <write>
     688:	4785                	li	a5,1
     68a:	06f51063          	bne	a0,a5,6ea <go+0x672>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     68e:	fa840593          	addi	a1,s0,-88
     692:	855a                	mv	a0,s6
     694:	00001097          	auipc	ra,0x1
     698:	bb2080e7          	jalr	-1102(ra) # 1246 <fstat>
     69c:	e525                	bnez	a0,704 <go+0x68c>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     69e:	fb843583          	ld	a1,-72(s0)
     6a2:	4785                	li	a5,1
     6a4:	06f59d63          	bne	a1,a5,71e <go+0x6a6>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     6a8:	fac42583          	lw	a1,-84(s0)
     6ac:	0c800793          	li	a5,200
     6b0:	08b7e563          	bltu	a5,a1,73a <go+0x6c2>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     6b4:	855a                	mv	a0,s6
     6b6:	00001097          	auipc	ra,0x1
     6ba:	b60080e7          	jalr	-1184(ra) # 1216 <close>
      unlink("c");
     6be:	00001517          	auipc	a0,0x1
     6c2:	1f250513          	addi	a0,a0,498 # 18b0 <malloc+0x28a>
     6c6:	00001097          	auipc	ra,0x1
     6ca:	b78080e7          	jalr	-1160(ra) # 123e <unlink>
     6ce:	bc91                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     6d0:	00001517          	auipc	a0,0x1
     6d4:	1e850513          	addi	a0,a0,488 # 18b8 <malloc+0x292>
     6d8:	00001097          	auipc	ra,0x1
     6dc:	e96080e7          	jalr	-362(ra) # 156e <printf>
        exit(1);
     6e0:	4505                	li	a0,1
     6e2:	00001097          	auipc	ra,0x1
     6e6:	b0c080e7          	jalr	-1268(ra) # 11ee <exit>
        printf("grind: write c failed\n");
     6ea:	00001517          	auipc	a0,0x1
     6ee:	1e650513          	addi	a0,a0,486 # 18d0 <malloc+0x2aa>
     6f2:	00001097          	auipc	ra,0x1
     6f6:	e7c080e7          	jalr	-388(ra) # 156e <printf>
        exit(1);
     6fa:	4505                	li	a0,1
     6fc:	00001097          	auipc	ra,0x1
     700:	af2080e7          	jalr	-1294(ra) # 11ee <exit>
        printf("grind: fstat failed\n");
     704:	00001517          	auipc	a0,0x1
     708:	1e450513          	addi	a0,a0,484 # 18e8 <malloc+0x2c2>
     70c:	00001097          	auipc	ra,0x1
     710:	e62080e7          	jalr	-414(ra) # 156e <printf>
        exit(1);
     714:	4505                	li	a0,1
     716:	00001097          	auipc	ra,0x1
     71a:	ad8080e7          	jalr	-1320(ra) # 11ee <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     71e:	2581                	sext.w	a1,a1
     720:	00001517          	auipc	a0,0x1
     724:	1e050513          	addi	a0,a0,480 # 1900 <malloc+0x2da>
     728:	00001097          	auipc	ra,0x1
     72c:	e46080e7          	jalr	-442(ra) # 156e <printf>
        exit(1);
     730:	4505                	li	a0,1
     732:	00001097          	auipc	ra,0x1
     736:	abc080e7          	jalr	-1348(ra) # 11ee <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     73a:	00001517          	auipc	a0,0x1
     73e:	1ee50513          	addi	a0,a0,494 # 1928 <malloc+0x302>
     742:	00001097          	auipc	ra,0x1
     746:	e2c080e7          	jalr	-468(ra) # 156e <printf>
        exit(1);
     74a:	4505                	li	a0,1
     74c:	00001097          	auipc	ra,0x1
     750:	aa2080e7          	jalr	-1374(ra) # 11ee <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     754:	f9840513          	addi	a0,s0,-104
     758:	00001097          	auipc	ra,0x1
     75c:	aa6080e7          	jalr	-1370(ra) # 11fe <pipe>
     760:	10054063          	bltz	a0,860 <go+0x7e8>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     764:	fa040513          	addi	a0,s0,-96
     768:	00001097          	auipc	ra,0x1
     76c:	a96080e7          	jalr	-1386(ra) # 11fe <pipe>
     770:	10054663          	bltz	a0,87c <go+0x804>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     774:	00001097          	auipc	ra,0x1
     778:	a72080e7          	jalr	-1422(ra) # 11e6 <fork>
      if(pid1 == 0){
     77c:	10050e63          	beqz	a0,898 <go+0x820>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     780:	1c054663          	bltz	a0,94c <go+0x8d4>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     784:	00001097          	auipc	ra,0x1
     788:	a62080e7          	jalr	-1438(ra) # 11e6 <fork>
      if(pid2 == 0){
     78c:	1c050e63          	beqz	a0,968 <go+0x8f0>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     790:	2a054a63          	bltz	a0,a44 <go+0x9cc>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     794:	f9842503          	lw	a0,-104(s0)
     798:	00001097          	auipc	ra,0x1
     79c:	a7e080e7          	jalr	-1410(ra) # 1216 <close>
      close(aa[1]);
     7a0:	f9c42503          	lw	a0,-100(s0)
     7a4:	00001097          	auipc	ra,0x1
     7a8:	a72080e7          	jalr	-1422(ra) # 1216 <close>
      close(bb[1]);
     7ac:	fa442503          	lw	a0,-92(s0)
     7b0:	00001097          	auipc	ra,0x1
     7b4:	a66080e7          	jalr	-1434(ra) # 1216 <close>
      char buf[4] = { 0, 0, 0, 0 };
     7b8:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     7bc:	4605                	li	a2,1
     7be:	f9040593          	addi	a1,s0,-112
     7c2:	fa042503          	lw	a0,-96(s0)
     7c6:	00001097          	auipc	ra,0x1
     7ca:	a40080e7          	jalr	-1472(ra) # 1206 <read>
      read(bb[0], buf+1, 1);
     7ce:	4605                	li	a2,1
     7d0:	f9140593          	addi	a1,s0,-111
     7d4:	fa042503          	lw	a0,-96(s0)
     7d8:	00001097          	auipc	ra,0x1
     7dc:	a2e080e7          	jalr	-1490(ra) # 1206 <read>
      read(bb[0], buf+2, 1);
     7e0:	4605                	li	a2,1
     7e2:	f9240593          	addi	a1,s0,-110
     7e6:	fa042503          	lw	a0,-96(s0)
     7ea:	00001097          	auipc	ra,0x1
     7ee:	a1c080e7          	jalr	-1508(ra) # 1206 <read>
      close(bb[0]);
     7f2:	fa042503          	lw	a0,-96(s0)
     7f6:	00001097          	auipc	ra,0x1
     7fa:	a20080e7          	jalr	-1504(ra) # 1216 <close>
      int st1, st2;
      wait(&st1);
     7fe:	f9440513          	addi	a0,s0,-108
     802:	00001097          	auipc	ra,0x1
     806:	9f4080e7          	jalr	-1548(ra) # 11f6 <wait>
      wait(&st2);
     80a:	fa840513          	addi	a0,s0,-88
     80e:	00001097          	auipc	ra,0x1
     812:	9e8080e7          	jalr	-1560(ra) # 11f6 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     816:	f9442783          	lw	a5,-108(s0)
     81a:	fa842703          	lw	a4,-88(s0)
     81e:	8fd9                	or	a5,a5,a4
     820:	ef89                	bnez	a5,83a <go+0x7c2>
     822:	00001597          	auipc	a1,0x1
     826:	1a658593          	addi	a1,a1,422 # 19c8 <malloc+0x3a2>
     82a:	f9040513          	addi	a0,s0,-112
     82e:	00000097          	auipc	ra,0x0
     832:	770080e7          	jalr	1904(ra) # f9e <strcmp>
     836:	8e0506e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     83a:	f9040693          	addi	a3,s0,-112
     83e:	fa842603          	lw	a2,-88(s0)
     842:	f9442583          	lw	a1,-108(s0)
     846:	00001517          	auipc	a0,0x1
     84a:	18a50513          	addi	a0,a0,394 # 19d0 <malloc+0x3aa>
     84e:	00001097          	auipc	ra,0x1
     852:	d20080e7          	jalr	-736(ra) # 156e <printf>
        exit(1);
     856:	4505                	li	a0,1
     858:	00001097          	auipc	ra,0x1
     85c:	996080e7          	jalr	-1642(ra) # 11ee <exit>
        fprintf(2, "grind: pipe failed\n");
     860:	00001597          	auipc	a1,0x1
     864:	ff058593          	addi	a1,a1,-16 # 1850 <malloc+0x22a>
     868:	4509                	li	a0,2
     86a:	00001097          	auipc	ra,0x1
     86e:	cd6080e7          	jalr	-810(ra) # 1540 <fprintf>
        exit(1);
     872:	4505                	li	a0,1
     874:	00001097          	auipc	ra,0x1
     878:	97a080e7          	jalr	-1670(ra) # 11ee <exit>
        fprintf(2, "grind: pipe failed\n");
     87c:	00001597          	auipc	a1,0x1
     880:	fd458593          	addi	a1,a1,-44 # 1850 <malloc+0x22a>
     884:	4509                	li	a0,2
     886:	00001097          	auipc	ra,0x1
     88a:	cba080e7          	jalr	-838(ra) # 1540 <fprintf>
        exit(1);
     88e:	4505                	li	a0,1
     890:	00001097          	auipc	ra,0x1
     894:	95e080e7          	jalr	-1698(ra) # 11ee <exit>
        close(bb[0]);
     898:	fa042503          	lw	a0,-96(s0)
     89c:	00001097          	auipc	ra,0x1
     8a0:	97a080e7          	jalr	-1670(ra) # 1216 <close>
        close(bb[1]);
     8a4:	fa442503          	lw	a0,-92(s0)
     8a8:	00001097          	auipc	ra,0x1
     8ac:	96e080e7          	jalr	-1682(ra) # 1216 <close>
        close(aa[0]);
     8b0:	f9842503          	lw	a0,-104(s0)
     8b4:	00001097          	auipc	ra,0x1
     8b8:	962080e7          	jalr	-1694(ra) # 1216 <close>
        close(1);
     8bc:	4505                	li	a0,1
     8be:	00001097          	auipc	ra,0x1
     8c2:	958080e7          	jalr	-1704(ra) # 1216 <close>
        if(dup(aa[1]) != 1){
     8c6:	f9c42503          	lw	a0,-100(s0)
     8ca:	00001097          	auipc	ra,0x1
     8ce:	99c080e7          	jalr	-1636(ra) # 1266 <dup>
     8d2:	4785                	li	a5,1
     8d4:	02f50063          	beq	a0,a5,8f4 <go+0x87c>
          fprintf(2, "grind: dup failed\n");
     8d8:	00001597          	auipc	a1,0x1
     8dc:	07858593          	addi	a1,a1,120 # 1950 <malloc+0x32a>
     8e0:	4509                	li	a0,2
     8e2:	00001097          	auipc	ra,0x1
     8e6:	c5e080e7          	jalr	-930(ra) # 1540 <fprintf>
          exit(1);
     8ea:	4505                	li	a0,1
     8ec:	00001097          	auipc	ra,0x1
     8f0:	902080e7          	jalr	-1790(ra) # 11ee <exit>
        close(aa[1]);
     8f4:	f9c42503          	lw	a0,-100(s0)
     8f8:	00001097          	auipc	ra,0x1
     8fc:	91e080e7          	jalr	-1762(ra) # 1216 <close>
        char *args[3] = { "echo", "hi", 0 };
     900:	00001797          	auipc	a5,0x1
     904:	06878793          	addi	a5,a5,104 # 1968 <malloc+0x342>
     908:	faf43423          	sd	a5,-88(s0)
     90c:	00001797          	auipc	a5,0x1
     910:	06478793          	addi	a5,a5,100 # 1970 <malloc+0x34a>
     914:	faf43823          	sd	a5,-80(s0)
     918:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     91c:	fa840593          	addi	a1,s0,-88
     920:	00001517          	auipc	a0,0x1
     924:	05850513          	addi	a0,a0,88 # 1978 <malloc+0x352>
     928:	00001097          	auipc	ra,0x1
     92c:	8fe080e7          	jalr	-1794(ra) # 1226 <exec>
        fprintf(2, "grind: echo: not found\n");
     930:	00001597          	auipc	a1,0x1
     934:	05858593          	addi	a1,a1,88 # 1988 <malloc+0x362>
     938:	4509                	li	a0,2
     93a:	00001097          	auipc	ra,0x1
     93e:	c06080e7          	jalr	-1018(ra) # 1540 <fprintf>
        exit(2);
     942:	4509                	li	a0,2
     944:	00001097          	auipc	ra,0x1
     948:	8aa080e7          	jalr	-1878(ra) # 11ee <exit>
        fprintf(2, "grind: fork failed\n");
     94c:	00001597          	auipc	a1,0x1
     950:	ec458593          	addi	a1,a1,-316 # 1810 <malloc+0x1ea>
     954:	4509                	li	a0,2
     956:	00001097          	auipc	ra,0x1
     95a:	bea080e7          	jalr	-1046(ra) # 1540 <fprintf>
        exit(3);
     95e:	450d                	li	a0,3
     960:	00001097          	auipc	ra,0x1
     964:	88e080e7          	jalr	-1906(ra) # 11ee <exit>
        close(aa[1]);
     968:	f9c42503          	lw	a0,-100(s0)
     96c:	00001097          	auipc	ra,0x1
     970:	8aa080e7          	jalr	-1878(ra) # 1216 <close>
        close(bb[0]);
     974:	fa042503          	lw	a0,-96(s0)
     978:	00001097          	auipc	ra,0x1
     97c:	89e080e7          	jalr	-1890(ra) # 1216 <close>
        close(0);
     980:	4501                	li	a0,0
     982:	00001097          	auipc	ra,0x1
     986:	894080e7          	jalr	-1900(ra) # 1216 <close>
        if(dup(aa[0]) != 0){
     98a:	f9842503          	lw	a0,-104(s0)
     98e:	00001097          	auipc	ra,0x1
     992:	8d8080e7          	jalr	-1832(ra) # 1266 <dup>
     996:	cd19                	beqz	a0,9b4 <go+0x93c>
          fprintf(2, "grind: dup failed\n");
     998:	00001597          	auipc	a1,0x1
     99c:	fb858593          	addi	a1,a1,-72 # 1950 <malloc+0x32a>
     9a0:	4509                	li	a0,2
     9a2:	00001097          	auipc	ra,0x1
     9a6:	b9e080e7          	jalr	-1122(ra) # 1540 <fprintf>
          exit(4);
     9aa:	4511                	li	a0,4
     9ac:	00001097          	auipc	ra,0x1
     9b0:	842080e7          	jalr	-1982(ra) # 11ee <exit>
        close(aa[0]);
     9b4:	f9842503          	lw	a0,-104(s0)
     9b8:	00001097          	auipc	ra,0x1
     9bc:	85e080e7          	jalr	-1954(ra) # 1216 <close>
        close(1);
     9c0:	4505                	li	a0,1
     9c2:	00001097          	auipc	ra,0x1
     9c6:	854080e7          	jalr	-1964(ra) # 1216 <close>
        if(dup(bb[1]) != 1){
     9ca:	fa442503          	lw	a0,-92(s0)
     9ce:	00001097          	auipc	ra,0x1
     9d2:	898080e7          	jalr	-1896(ra) # 1266 <dup>
     9d6:	4785                	li	a5,1
     9d8:	02f50063          	beq	a0,a5,9f8 <go+0x980>
          fprintf(2, "grind: dup failed\n");
     9dc:	00001597          	auipc	a1,0x1
     9e0:	f7458593          	addi	a1,a1,-140 # 1950 <malloc+0x32a>
     9e4:	4509                	li	a0,2
     9e6:	00001097          	auipc	ra,0x1
     9ea:	b5a080e7          	jalr	-1190(ra) # 1540 <fprintf>
          exit(5);
     9ee:	4515                	li	a0,5
     9f0:	00000097          	auipc	ra,0x0
     9f4:	7fe080e7          	jalr	2046(ra) # 11ee <exit>
        close(bb[1]);
     9f8:	fa442503          	lw	a0,-92(s0)
     9fc:	00001097          	auipc	ra,0x1
     a00:	81a080e7          	jalr	-2022(ra) # 1216 <close>
        char *args[2] = { "cat", 0 };
     a04:	00001797          	auipc	a5,0x1
     a08:	f9c78793          	addi	a5,a5,-100 # 19a0 <malloc+0x37a>
     a0c:	faf43423          	sd	a5,-88(s0)
     a10:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a14:	fa840593          	addi	a1,s0,-88
     a18:	00001517          	auipc	a0,0x1
     a1c:	f9050513          	addi	a0,a0,-112 # 19a8 <malloc+0x382>
     a20:	00001097          	auipc	ra,0x1
     a24:	806080e7          	jalr	-2042(ra) # 1226 <exec>
        fprintf(2, "grind: cat: not found\n");
     a28:	00001597          	auipc	a1,0x1
     a2c:	f8858593          	addi	a1,a1,-120 # 19b0 <malloc+0x38a>
     a30:	4509                	li	a0,2
     a32:	00001097          	auipc	ra,0x1
     a36:	b0e080e7          	jalr	-1266(ra) # 1540 <fprintf>
        exit(6);
     a3a:	4519                	li	a0,6
     a3c:	00000097          	auipc	ra,0x0
     a40:	7b2080e7          	jalr	1970(ra) # 11ee <exit>
        fprintf(2, "grind: fork failed\n");
     a44:	00001597          	auipc	a1,0x1
     a48:	dcc58593          	addi	a1,a1,-564 # 1810 <malloc+0x1ea>
     a4c:	4509                	li	a0,2
     a4e:	00001097          	auipc	ra,0x1
     a52:	af2080e7          	jalr	-1294(ra) # 1540 <fprintf>
        exit(7);
     a56:	451d                	li	a0,7
     a58:	00000097          	auipc	ra,0x0
     a5c:	796080e7          	jalr	1942(ra) # 11ee <exit>

0000000000000a60 <iter>:
  }
}

void
iter()
{
     a60:	7179                	addi	sp,sp,-48
     a62:	f406                	sd	ra,40(sp)
     a64:	f022                	sd	s0,32(sp)
     a66:	ec26                	sd	s1,24(sp)
     a68:	e84a                	sd	s2,16(sp)
     a6a:	1800                	addi	s0,sp,48
  unlink("a");
     a6c:	00001517          	auipc	a0,0x1
     a70:	d8450513          	addi	a0,a0,-636 # 17f0 <malloc+0x1ca>
     a74:	00000097          	auipc	ra,0x0
     a78:	7ca080e7          	jalr	1994(ra) # 123e <unlink>
  unlink("b");
     a7c:	00001517          	auipc	a0,0x1
     a80:	d2450513          	addi	a0,a0,-732 # 17a0 <malloc+0x17a>
     a84:	00000097          	auipc	ra,0x0
     a88:	7ba080e7          	jalr	1978(ra) # 123e <unlink>
  
  int pid1 = fork();
     a8c:	00000097          	auipc	ra,0x0
     a90:	75a080e7          	jalr	1882(ra) # 11e6 <fork>
  if(pid1 < 0){
     a94:	02054163          	bltz	a0,ab6 <iter+0x56>
     a98:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     a9a:	e91d                	bnez	a0,ad0 <iter+0x70>
    rand_next ^= 31;
     a9c:	00001717          	auipc	a4,0x1
     aa0:	56470713          	addi	a4,a4,1380 # 2000 <rand_next>
     aa4:	631c                	ld	a5,0(a4)
     aa6:	01f7c793          	xori	a5,a5,31
     aaa:	e31c                	sd	a5,0(a4)
    go(0);
     aac:	4501                	li	a0,0
     aae:	fffff097          	auipc	ra,0xfffff
     ab2:	5ca080e7          	jalr	1482(ra) # 78 <go>
    printf("grind: fork failed\n");
     ab6:	00001517          	auipc	a0,0x1
     aba:	d5a50513          	addi	a0,a0,-678 # 1810 <malloc+0x1ea>
     abe:	00001097          	auipc	ra,0x1
     ac2:	ab0080e7          	jalr	-1360(ra) # 156e <printf>
    exit(1);
     ac6:	4505                	li	a0,1
     ac8:	00000097          	auipc	ra,0x0
     acc:	726080e7          	jalr	1830(ra) # 11ee <exit>
    exit(0);
  }

  int pid2 = fork();
     ad0:	00000097          	auipc	ra,0x0
     ad4:	716080e7          	jalr	1814(ra) # 11e6 <fork>
     ad8:	892a                	mv	s2,a0
  if(pid2 < 0){
     ada:	02054263          	bltz	a0,afe <iter+0x9e>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     ade:	ed0d                	bnez	a0,b18 <iter+0xb8>
    rand_next ^= 7177;
     ae0:	00001697          	auipc	a3,0x1
     ae4:	52068693          	addi	a3,a3,1312 # 2000 <rand_next>
     ae8:	629c                	ld	a5,0(a3)
     aea:	6709                	lui	a4,0x2
     aec:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x101>
     af0:	8fb9                	xor	a5,a5,a4
     af2:	e29c                	sd	a5,0(a3)
    go(1);
     af4:	4505                	li	a0,1
     af6:	fffff097          	auipc	ra,0xfffff
     afa:	582080e7          	jalr	1410(ra) # 78 <go>
    printf("grind: fork failed\n");
     afe:	00001517          	auipc	a0,0x1
     b02:	d1250513          	addi	a0,a0,-750 # 1810 <malloc+0x1ea>
     b06:	00001097          	auipc	ra,0x1
     b0a:	a68080e7          	jalr	-1432(ra) # 156e <printf>
    exit(1);
     b0e:	4505                	li	a0,1
     b10:	00000097          	auipc	ra,0x0
     b14:	6de080e7          	jalr	1758(ra) # 11ee <exit>
    exit(0);
  }

  int st1 = -1;
     b18:	57fd                	li	a5,-1
     b1a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b1e:	fdc40513          	addi	a0,s0,-36
     b22:	00000097          	auipc	ra,0x0
     b26:	6d4080e7          	jalr	1748(ra) # 11f6 <wait>
  if(st1 != 0){
     b2a:	fdc42783          	lw	a5,-36(s0)
     b2e:	ef99                	bnez	a5,b4c <iter+0xec>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     b30:	57fd                	li	a5,-1
     b32:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     b36:	fd840513          	addi	a0,s0,-40
     b3a:	00000097          	auipc	ra,0x0
     b3e:	6bc080e7          	jalr	1724(ra) # 11f6 <wait>

  exit(0);
     b42:	4501                	li	a0,0
     b44:	00000097          	auipc	ra,0x0
     b48:	6aa080e7          	jalr	1706(ra) # 11ee <exit>
    kill(pid1);
     b4c:	8526                	mv	a0,s1
     b4e:	00000097          	auipc	ra,0x0
     b52:	6d0080e7          	jalr	1744(ra) # 121e <kill>
    kill(pid2);
     b56:	854a                	mv	a0,s2
     b58:	00000097          	auipc	ra,0x0
     b5c:	6c6080e7          	jalr	1734(ra) # 121e <kill>
     b60:	bfc1                	j	b30 <iter+0xd0>

0000000000000b62 <main>:
}

int
main()
{
     b62:	1101                	addi	sp,sp,-32
     b64:	ec06                	sd	ra,24(sp)
     b66:	e822                	sd	s0,16(sp)
     b68:	e426                	sd	s1,8(sp)
     b6a:	1000                	addi	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
     b6c:	00001497          	auipc	s1,0x1
     b70:	49448493          	addi	s1,s1,1172 # 2000 <rand_next>
     b74:	a829                	j	b8e <main+0x2c>
      iter();
     b76:	00000097          	auipc	ra,0x0
     b7a:	eea080e7          	jalr	-278(ra) # a60 <iter>
    sleep(20);
     b7e:	4551                	li	a0,20
     b80:	00000097          	auipc	ra,0x0
     b84:	6fe080e7          	jalr	1790(ra) # 127e <sleep>
    rand_next += 1;
     b88:	609c                	ld	a5,0(s1)
     b8a:	0785                	addi	a5,a5,1
     b8c:	e09c                	sd	a5,0(s1)
    int pid = fork();
     b8e:	00000097          	auipc	ra,0x0
     b92:	658080e7          	jalr	1624(ra) # 11e6 <fork>
    if(pid == 0){
     b96:	d165                	beqz	a0,b76 <main+0x14>
    if(pid > 0){
     b98:	fea053e3          	blez	a0,b7e <main+0x1c>
      wait(0);
     b9c:	4501                	li	a0,0
     b9e:	00000097          	auipc	ra,0x0
     ba2:	658080e7          	jalr	1624(ra) # 11f6 <wait>
     ba6:	bfe1                	j	b7e <main+0x1c>

0000000000000ba8 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
     ba8:	1141                	addi	sp,sp,-16
     baa:	e422                	sd	s0,8(sp)
     bac:	0800                	addi	s0,sp,16
    lk->name = name;
     bae:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
     bb0:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
     bb4:	57fd                	li	a5,-1
     bb6:	00f50823          	sb	a5,16(a0)
}
     bba:	6422                	ld	s0,8(sp)
     bbc:	0141                	addi	sp,sp,16
     bbe:	8082                	ret

0000000000000bc0 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
     bc0:	00054783          	lbu	a5,0(a0)
     bc4:	e399                	bnez	a5,bca <holding+0xa>
     bc6:	4501                	li	a0,0
}
     bc8:	8082                	ret
{
     bca:	1101                	addi	sp,sp,-32
     bcc:	ec06                	sd	ra,24(sp)
     bce:	e822                	sd	s0,16(sp)
     bd0:	e426                	sd	s1,8(sp)
     bd2:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
     bd4:	01054483          	lbu	s1,16(a0)
     bd8:	00000097          	auipc	ra,0x0
     bdc:	2c4080e7          	jalr	708(ra) # e9c <twhoami>
     be0:	2501                	sext.w	a0,a0
     be2:	40a48533          	sub	a0,s1,a0
     be6:	00153513          	seqz	a0,a0
}
     bea:	60e2                	ld	ra,24(sp)
     bec:	6442                	ld	s0,16(sp)
     bee:	64a2                	ld	s1,8(sp)
     bf0:	6105                	addi	sp,sp,32
     bf2:	8082                	ret

0000000000000bf4 <acquire>:

void acquire(struct lock *lk)
{
     bf4:	7179                	addi	sp,sp,-48
     bf6:	f406                	sd	ra,40(sp)
     bf8:	f022                	sd	s0,32(sp)
     bfa:	ec26                	sd	s1,24(sp)
     bfc:	e84a                	sd	s2,16(sp)
     bfe:	e44e                	sd	s3,8(sp)
     c00:	e052                	sd	s4,0(sp)
     c02:	1800                	addi	s0,sp,48
     c04:	8a2a                	mv	s4,a0
    if (holding(lk))
     c06:	00000097          	auipc	ra,0x0
     c0a:	fba080e7          	jalr	-70(ra) # bc0 <holding>
     c0e:	e919                	bnez	a0,c24 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
     c10:	ffca7493          	andi	s1,s4,-4
     c14:	003a7913          	andi	s2,s4,3
     c18:	0039191b          	slliw	s2,s2,0x3
     c1c:	4985                	li	s3,1
     c1e:	012999bb          	sllw	s3,s3,s2
     c22:	a015                	j	c46 <acquire+0x52>
        printf("re-acquiring lock we already hold");
     c24:	00001517          	auipc	a0,0x1
     c28:	e3450513          	addi	a0,a0,-460 # 1a58 <malloc+0x432>
     c2c:	00001097          	auipc	ra,0x1
     c30:	942080e7          	jalr	-1726(ra) # 156e <printf>
        exit(-1);
     c34:	557d                	li	a0,-1
     c36:	00000097          	auipc	ra,0x0
     c3a:	5b8080e7          	jalr	1464(ra) # 11ee <exit>
    {
        // give up the cpu for other threads
        tyield();
     c3e:	00000097          	auipc	ra,0x0
     c42:	1dc080e7          	jalr	476(ra) # e1a <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
     c46:	4534a7af          	amoor.w.aq	a5,s3,(s1)
     c4a:	0127d7bb          	srlw	a5,a5,s2
     c4e:	0ff7f793          	zext.b	a5,a5
     c52:	f7f5                	bnez	a5,c3e <acquire+0x4a>
    }

    __sync_synchronize();
     c54:	0ff0000f          	fence

    lk->tid = twhoami();
     c58:	00000097          	auipc	ra,0x0
     c5c:	244080e7          	jalr	580(ra) # e9c <twhoami>
     c60:	00aa0823          	sb	a0,16(s4)
}
     c64:	70a2                	ld	ra,40(sp)
     c66:	7402                	ld	s0,32(sp)
     c68:	64e2                	ld	s1,24(sp)
     c6a:	6942                	ld	s2,16(sp)
     c6c:	69a2                	ld	s3,8(sp)
     c6e:	6a02                	ld	s4,0(sp)
     c70:	6145                	addi	sp,sp,48
     c72:	8082                	ret

0000000000000c74 <release>:

void release(struct lock *lk)
{
     c74:	1101                	addi	sp,sp,-32
     c76:	ec06                	sd	ra,24(sp)
     c78:	e822                	sd	s0,16(sp)
     c7a:	e426                	sd	s1,8(sp)
     c7c:	1000                	addi	s0,sp,32
     c7e:	84aa                	mv	s1,a0
    if (!holding(lk))
     c80:	00000097          	auipc	ra,0x0
     c84:	f40080e7          	jalr	-192(ra) # bc0 <holding>
     c88:	c11d                	beqz	a0,cae <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
     c8a:	57fd                	li	a5,-1
     c8c:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
     c90:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
     c94:	0ff0000f          	fence
     c98:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
     c9c:	00000097          	auipc	ra,0x0
     ca0:	17e080e7          	jalr	382(ra) # e1a <tyield>
}
     ca4:	60e2                	ld	ra,24(sp)
     ca6:	6442                	ld	s0,16(sp)
     ca8:	64a2                	ld	s1,8(sp)
     caa:	6105                	addi	sp,sp,32
     cac:	8082                	ret
        printf("releasing lock we are not holding");
     cae:	00001517          	auipc	a0,0x1
     cb2:	dd250513          	addi	a0,a0,-558 # 1a80 <malloc+0x45a>
     cb6:	00001097          	auipc	ra,0x1
     cba:	8b8080e7          	jalr	-1864(ra) # 156e <printf>
        exit(-1);
     cbe:	557d                	li	a0,-1
     cc0:	00000097          	auipc	ra,0x0
     cc4:	52e080e7          	jalr	1326(ra) # 11ee <exit>

0000000000000cc8 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
     cc8:	00001517          	auipc	a0,0x1
     ccc:	34853503          	ld	a0,840(a0) # 2010 <current_thread>
     cd0:	00001717          	auipc	a4,0x1
     cd4:	73870713          	addi	a4,a4,1848 # 2408 <threads>
    for (int i = 0; i < 16; i++) {
     cd8:	4781                	li	a5,0
     cda:	4641                	li	a2,16
        if (threads[i] == current_thread) {
     cdc:	6314                	ld	a3,0(a4)
     cde:	00a68763          	beq	a3,a0,cec <tsched+0x24>
    for (int i = 0; i < 16; i++) {
     ce2:	2785                	addiw	a5,a5,1
     ce4:	0721                	addi	a4,a4,8
     ce6:	fec79be3          	bne	a5,a2,cdc <tsched+0x14>
    int current_index = 0;
     cea:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
     cec:	0017869b          	addiw	a3,a5,1
     cf0:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     cf4:	00001817          	auipc	a6,0x1
     cf8:	71480813          	addi	a6,a6,1812 # 2408 <threads>
     cfc:	488d                	li	a7,3
     cfe:	a021                	j	d06 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
     d00:	2685                	addiw	a3,a3,1
     d02:	04c68363          	beq	a3,a2,d48 <tsched+0x80>
        int next_index = (current_index + i) % 16;
     d06:	41f6d71b          	sraiw	a4,a3,0x1f
     d0a:	01c7571b          	srliw	a4,a4,0x1c
     d0e:	00d707bb          	addw	a5,a4,a3
     d12:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     d14:	9f99                	subw	a5,a5,a4
     d16:	078e                	slli	a5,a5,0x3
     d18:	97c2                	add	a5,a5,a6
     d1a:	638c                	ld	a1,0(a5)
     d1c:	d1f5                	beqz	a1,d00 <tsched+0x38>
     d1e:	5dbc                	lw	a5,120(a1)
     d20:	ff1790e3          	bne	a5,a7,d00 <tsched+0x38>
{
     d24:	1141                	addi	sp,sp,-16
     d26:	e406                	sd	ra,8(sp)
     d28:	e022                	sd	s0,0(sp)
     d2a:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
     d2c:	00001797          	auipc	a5,0x1
     d30:	2eb7b223          	sd	a1,740(a5) # 2010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
     d34:	05a1                	addi	a1,a1,8
     d36:	0521                	addi	a0,a0,8
     d38:	00000097          	auipc	ra,0x0
     d3c:	17c080e7          	jalr	380(ra) # eb4 <tswtch>
        //printf("Thread switch complete\n");
    }
}
     d40:	60a2                	ld	ra,8(sp)
     d42:	6402                	ld	s0,0(sp)
     d44:	0141                	addi	sp,sp,16
     d46:	8082                	ret
     d48:	8082                	ret

0000000000000d4a <thread_wrapper>:
{
     d4a:	1101                	addi	sp,sp,-32
     d4c:	ec06                	sd	ra,24(sp)
     d4e:	e822                	sd	s0,16(sp)
     d50:	e426                	sd	s1,8(sp)
     d52:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
     d54:	00001497          	auipc	s1,0x1
     d58:	2bc48493          	addi	s1,s1,700 # 2010 <current_thread>
     d5c:	609c                	ld	a5,0(s1)
     d5e:	67d8                	ld	a4,136(a5)
     d60:	63c8                	ld	a0,128(a5)
     d62:	9702                	jalr	a4
    current_thread->state = EXITED;
     d64:	609c                	ld	a5,0(s1)
     d66:	4719                	li	a4,6
     d68:	dfb8                	sw	a4,120(a5)
    tsched();
     d6a:	00000097          	auipc	ra,0x0
     d6e:	f5e080e7          	jalr	-162(ra) # cc8 <tsched>
}
     d72:	60e2                	ld	ra,24(sp)
     d74:	6442                	ld	s0,16(sp)
     d76:	64a2                	ld	s1,8(sp)
     d78:	6105                	addi	sp,sp,32
     d7a:	8082                	ret

0000000000000d7c <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     d7c:	7179                	addi	sp,sp,-48
     d7e:	f406                	sd	ra,40(sp)
     d80:	f022                	sd	s0,32(sp)
     d82:	ec26                	sd	s1,24(sp)
     d84:	e84a                	sd	s2,16(sp)
     d86:	e44e                	sd	s3,8(sp)
     d88:	1800                	addi	s0,sp,48
     d8a:	84aa                	mv	s1,a0
     d8c:	89b2                	mv	s3,a2
     d8e:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     d90:	09800513          	li	a0,152
     d94:	00001097          	auipc	ra,0x1
     d98:	892080e7          	jalr	-1902(ra) # 1626 <malloc>
     d9c:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     d9e:	478d                	li	a5,3
     da0:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     da2:	609c                	ld	a5,0(s1)
     da4:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
     da8:	609c                	ld	a5,0(s1)
     daa:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
     dae:	6098                	ld	a4,0(s1)
     db0:	00001797          	auipc	a5,0x1
     db4:	25878793          	addi	a5,a5,600 # 2008 <next_tid>
     db8:	4394                	lw	a3,0(a5)
     dba:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
     dbe:	4398                	lw	a4,0(a5)
     dc0:	2705                	addiw	a4,a4,1
     dc2:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
     dc4:	6505                	lui	a0,0x1
     dc6:	00001097          	auipc	ra,0x1
     dca:	860080e7          	jalr	-1952(ra) # 1626 <malloc>
     dce:	609c                	ld	a5,0(s1)
     dd0:	6705                	lui	a4,0x1
     dd2:	953a                	add	a0,a0,a4
     dd4:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
     dd6:	609c                	ld	a5,0(s1)
     dd8:	00000717          	auipc	a4,0x0
     ddc:	f7270713          	addi	a4,a4,-142 # d4a <thread_wrapper>
     de0:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
     de2:	00001717          	auipc	a4,0x1
     de6:	62670713          	addi	a4,a4,1574 # 2408 <threads>
     dea:	4781                	li	a5,0
     dec:	4641                	li	a2,16
        if (threads[i] == NULL) {
     dee:	6314                	ld	a3,0(a4)
     df0:	ce81                	beqz	a3,e08 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
     df2:	2785                	addiw	a5,a5,1
     df4:	0721                	addi	a4,a4,8
     df6:	fec79ce3          	bne	a5,a2,dee <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
     dfa:	70a2                	ld	ra,40(sp)
     dfc:	7402                	ld	s0,32(sp)
     dfe:	64e2                	ld	s1,24(sp)
     e00:	6942                	ld	s2,16(sp)
     e02:	69a2                	ld	s3,8(sp)
     e04:	6145                	addi	sp,sp,48
     e06:	8082                	ret
            threads[i] = *thread;
     e08:	6094                	ld	a3,0(s1)
     e0a:	078e                	slli	a5,a5,0x3
     e0c:	00001717          	auipc	a4,0x1
     e10:	5fc70713          	addi	a4,a4,1532 # 2408 <threads>
     e14:	97ba                	add	a5,a5,a4
     e16:	e394                	sd	a3,0(a5)
            break;
     e18:	b7cd                	j	dfa <tcreate+0x7e>

0000000000000e1a <tyield>:
    return 0;
}


void tyield()
{
     e1a:	1141                	addi	sp,sp,-16
     e1c:	e406                	sd	ra,8(sp)
     e1e:	e022                	sd	s0,0(sp)
     e20:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
     e22:	00001797          	auipc	a5,0x1
     e26:	1ee7b783          	ld	a5,494(a5) # 2010 <current_thread>
     e2a:	470d                	li	a4,3
     e2c:	dfb8                	sw	a4,120(a5)
    tsched();
     e2e:	00000097          	auipc	ra,0x0
     e32:	e9a080e7          	jalr	-358(ra) # cc8 <tsched>
}
     e36:	60a2                	ld	ra,8(sp)
     e38:	6402                	ld	s0,0(sp)
     e3a:	0141                	addi	sp,sp,16
     e3c:	8082                	ret

0000000000000e3e <tjoin>:
{
     e3e:	1101                	addi	sp,sp,-32
     e40:	ec06                	sd	ra,24(sp)
     e42:	e822                	sd	s0,16(sp)
     e44:	e426                	sd	s1,8(sp)
     e46:	e04a                	sd	s2,0(sp)
     e48:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
     e4a:	00001797          	auipc	a5,0x1
     e4e:	5be78793          	addi	a5,a5,1470 # 2408 <threads>
     e52:	00001697          	auipc	a3,0x1
     e56:	63668693          	addi	a3,a3,1590 # 2488 <base>
     e5a:	a021                	j	e62 <tjoin+0x24>
     e5c:	07a1                	addi	a5,a5,8
     e5e:	02d78b63          	beq	a5,a3,e94 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
     e62:	6384                	ld	s1,0(a5)
     e64:	dce5                	beqz	s1,e5c <tjoin+0x1e>
     e66:	0004c703          	lbu	a4,0(s1)
     e6a:	fea719e3          	bne	a4,a0,e5c <tjoin+0x1e>
    while (target_thread->state != EXITED) {
     e6e:	5cb8                	lw	a4,120(s1)
     e70:	4799                	li	a5,6
     e72:	4919                	li	s2,6
     e74:	02f70263          	beq	a4,a5,e98 <tjoin+0x5a>
        tyield();
     e78:	00000097          	auipc	ra,0x0
     e7c:	fa2080e7          	jalr	-94(ra) # e1a <tyield>
    while (target_thread->state != EXITED) {
     e80:	5cbc                	lw	a5,120(s1)
     e82:	ff279be3          	bne	a5,s2,e78 <tjoin+0x3a>
    return 0;
     e86:	4501                	li	a0,0
}
     e88:	60e2                	ld	ra,24(sp)
     e8a:	6442                	ld	s0,16(sp)
     e8c:	64a2                	ld	s1,8(sp)
     e8e:	6902                	ld	s2,0(sp)
     e90:	6105                	addi	sp,sp,32
     e92:	8082                	ret
        return -1;
     e94:	557d                	li	a0,-1
     e96:	bfcd                	j	e88 <tjoin+0x4a>
    return 0;
     e98:	4501                	li	a0,0
     e9a:	b7fd                	j	e88 <tjoin+0x4a>

0000000000000e9c <twhoami>:

uint8 twhoami()
{
     e9c:	1141                	addi	sp,sp,-16
     e9e:	e422                	sd	s0,8(sp)
     ea0:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
     ea2:	00001797          	auipc	a5,0x1
     ea6:	16e7b783          	ld	a5,366(a5) # 2010 <current_thread>
     eaa:	0007c503          	lbu	a0,0(a5)
     eae:	6422                	ld	s0,8(sp)
     eb0:	0141                	addi	sp,sp,16
     eb2:	8082                	ret

0000000000000eb4 <tswtch>:
     eb4:	00153023          	sd	ra,0(a0) # 1000 <memset+0xc>
     eb8:	00253423          	sd	sp,8(a0)
     ebc:	e900                	sd	s0,16(a0)
     ebe:	ed04                	sd	s1,24(a0)
     ec0:	03253023          	sd	s2,32(a0)
     ec4:	03353423          	sd	s3,40(a0)
     ec8:	03453823          	sd	s4,48(a0)
     ecc:	03553c23          	sd	s5,56(a0)
     ed0:	05653023          	sd	s6,64(a0)
     ed4:	05753423          	sd	s7,72(a0)
     ed8:	05853823          	sd	s8,80(a0)
     edc:	05953c23          	sd	s9,88(a0)
     ee0:	07a53023          	sd	s10,96(a0)
     ee4:	07b53423          	sd	s11,104(a0)
     ee8:	0005b083          	ld	ra,0(a1)
     eec:	0085b103          	ld	sp,8(a1)
     ef0:	6980                	ld	s0,16(a1)
     ef2:	6d84                	ld	s1,24(a1)
     ef4:	0205b903          	ld	s2,32(a1)
     ef8:	0285b983          	ld	s3,40(a1)
     efc:	0305ba03          	ld	s4,48(a1)
     f00:	0385ba83          	ld	s5,56(a1)
     f04:	0405bb03          	ld	s6,64(a1)
     f08:	0485bb83          	ld	s7,72(a1)
     f0c:	0505bc03          	ld	s8,80(a1)
     f10:	0585bc83          	ld	s9,88(a1)
     f14:	0605bd03          	ld	s10,96(a1)
     f18:	0685bd83          	ld	s11,104(a1)
     f1c:	8082                	ret

0000000000000f1e <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     f1e:	1101                	addi	sp,sp,-32
     f20:	ec06                	sd	ra,24(sp)
     f22:	e822                	sd	s0,16(sp)
     f24:	e426                	sd	s1,8(sp)
     f26:	e04a                	sd	s2,0(sp)
     f28:	1000                	addi	s0,sp,32
     f2a:	84aa                	mv	s1,a0
     f2c:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     f2e:	09800513          	li	a0,152
     f32:	00000097          	auipc	ra,0x0
     f36:	6f4080e7          	jalr	1780(ra) # 1626 <malloc>

    main_thread->tid = 1;
     f3a:	4785                	li	a5,1
     f3c:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
     f40:	4791                	li	a5,4
     f42:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
     f44:	00001797          	auipc	a5,0x1
     f48:	0ca7b623          	sd	a0,204(a5) # 2010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
     f4c:	00001797          	auipc	a5,0x1
     f50:	4bc78793          	addi	a5,a5,1212 # 2408 <threads>
     f54:	00001717          	auipc	a4,0x1
     f58:	53470713          	addi	a4,a4,1332 # 2488 <base>
        threads[i] = NULL;
     f5c:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
     f60:	07a1                	addi	a5,a5,8
     f62:	fee79de3          	bne	a5,a4,f5c <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
     f66:	00001797          	auipc	a5,0x1
     f6a:	4aa7b123          	sd	a0,1186(a5) # 2408 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     f6e:	85ca                	mv	a1,s2
     f70:	8526                	mv	a0,s1
     f72:	00000097          	auipc	ra,0x0
     f76:	bf0080e7          	jalr	-1040(ra) # b62 <main>
    //tsched();

    exit(res);
     f7a:	00000097          	auipc	ra,0x0
     f7e:	274080e7          	jalr	628(ra) # 11ee <exit>

0000000000000f82 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     f82:	1141                	addi	sp,sp,-16
     f84:	e422                	sd	s0,8(sp)
     f86:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
     f88:	87aa                	mv	a5,a0
     f8a:	0585                	addi	a1,a1,1
     f8c:	0785                	addi	a5,a5,1
     f8e:	fff5c703          	lbu	a4,-1(a1)
     f92:	fee78fa3          	sb	a4,-1(a5)
     f96:	fb75                	bnez	a4,f8a <strcpy+0x8>
        ;
    return os;
}
     f98:	6422                	ld	s0,8(sp)
     f9a:	0141                	addi	sp,sp,16
     f9c:	8082                	ret

0000000000000f9e <strcmp>:

int strcmp(const char *p, const char *q)
{
     f9e:	1141                	addi	sp,sp,-16
     fa0:	e422                	sd	s0,8(sp)
     fa2:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
     fa4:	00054783          	lbu	a5,0(a0)
     fa8:	cb91                	beqz	a5,fbc <strcmp+0x1e>
     faa:	0005c703          	lbu	a4,0(a1)
     fae:	00f71763          	bne	a4,a5,fbc <strcmp+0x1e>
        p++, q++;
     fb2:	0505                	addi	a0,a0,1
     fb4:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
     fb6:	00054783          	lbu	a5,0(a0)
     fba:	fbe5                	bnez	a5,faa <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
     fbc:	0005c503          	lbu	a0,0(a1)
}
     fc0:	40a7853b          	subw	a0,a5,a0
     fc4:	6422                	ld	s0,8(sp)
     fc6:	0141                	addi	sp,sp,16
     fc8:	8082                	ret

0000000000000fca <strlen>:

uint strlen(const char *s)
{
     fca:	1141                	addi	sp,sp,-16
     fcc:	e422                	sd	s0,8(sp)
     fce:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
     fd0:	00054783          	lbu	a5,0(a0)
     fd4:	cf91                	beqz	a5,ff0 <strlen+0x26>
     fd6:	0505                	addi	a0,a0,1
     fd8:	87aa                	mv	a5,a0
     fda:	86be                	mv	a3,a5
     fdc:	0785                	addi	a5,a5,1
     fde:	fff7c703          	lbu	a4,-1(a5)
     fe2:	ff65                	bnez	a4,fda <strlen+0x10>
     fe4:	40a6853b          	subw	a0,a3,a0
     fe8:	2505                	addiw	a0,a0,1
        ;
    return n;
}
     fea:	6422                	ld	s0,8(sp)
     fec:	0141                	addi	sp,sp,16
     fee:	8082                	ret
    for (n = 0; s[n]; n++)
     ff0:	4501                	li	a0,0
     ff2:	bfe5                	j	fea <strlen+0x20>

0000000000000ff4 <memset>:

void *
memset(void *dst, int c, uint n)
{
     ff4:	1141                	addi	sp,sp,-16
     ff6:	e422                	sd	s0,8(sp)
     ff8:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
     ffa:	ca19                	beqz	a2,1010 <memset+0x1c>
     ffc:	87aa                	mv	a5,a0
     ffe:	1602                	slli	a2,a2,0x20
    1000:	9201                	srli	a2,a2,0x20
    1002:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
    1006:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
    100a:	0785                	addi	a5,a5,1
    100c:	fee79de3          	bne	a5,a4,1006 <memset+0x12>
    }
    return dst;
}
    1010:	6422                	ld	s0,8(sp)
    1012:	0141                	addi	sp,sp,16
    1014:	8082                	ret

0000000000001016 <strchr>:

char *
strchr(const char *s, char c)
{
    1016:	1141                	addi	sp,sp,-16
    1018:	e422                	sd	s0,8(sp)
    101a:	0800                	addi	s0,sp,16
    for (; *s; s++)
    101c:	00054783          	lbu	a5,0(a0)
    1020:	cb99                	beqz	a5,1036 <strchr+0x20>
        if (*s == c)
    1022:	00f58763          	beq	a1,a5,1030 <strchr+0x1a>
    for (; *s; s++)
    1026:	0505                	addi	a0,a0,1
    1028:	00054783          	lbu	a5,0(a0)
    102c:	fbfd                	bnez	a5,1022 <strchr+0xc>
            return (char *)s;
    return 0;
    102e:	4501                	li	a0,0
}
    1030:	6422                	ld	s0,8(sp)
    1032:	0141                	addi	sp,sp,16
    1034:	8082                	ret
    return 0;
    1036:	4501                	li	a0,0
    1038:	bfe5                	j	1030 <strchr+0x1a>

000000000000103a <gets>:

char *
gets(char *buf, int max)
{
    103a:	711d                	addi	sp,sp,-96
    103c:	ec86                	sd	ra,88(sp)
    103e:	e8a2                	sd	s0,80(sp)
    1040:	e4a6                	sd	s1,72(sp)
    1042:	e0ca                	sd	s2,64(sp)
    1044:	fc4e                	sd	s3,56(sp)
    1046:	f852                	sd	s4,48(sp)
    1048:	f456                	sd	s5,40(sp)
    104a:	f05a                	sd	s6,32(sp)
    104c:	ec5e                	sd	s7,24(sp)
    104e:	1080                	addi	s0,sp,96
    1050:	8baa                	mv	s7,a0
    1052:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
    1054:	892a                	mv	s2,a0
    1056:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
    1058:	4aa9                	li	s5,10
    105a:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
    105c:	89a6                	mv	s3,s1
    105e:	2485                	addiw	s1,s1,1
    1060:	0344d863          	bge	s1,s4,1090 <gets+0x56>
        cc = read(0, &c, 1);
    1064:	4605                	li	a2,1
    1066:	faf40593          	addi	a1,s0,-81
    106a:	4501                	li	a0,0
    106c:	00000097          	auipc	ra,0x0
    1070:	19a080e7          	jalr	410(ra) # 1206 <read>
        if (cc < 1)
    1074:	00a05e63          	blez	a0,1090 <gets+0x56>
        buf[i++] = c;
    1078:	faf44783          	lbu	a5,-81(s0)
    107c:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
    1080:	01578763          	beq	a5,s5,108e <gets+0x54>
    1084:	0905                	addi	s2,s2,1
    1086:	fd679be3          	bne	a5,s6,105c <gets+0x22>
    for (i = 0; i + 1 < max;)
    108a:	89a6                	mv	s3,s1
    108c:	a011                	j	1090 <gets+0x56>
    108e:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
    1090:	99de                	add	s3,s3,s7
    1092:	00098023          	sb	zero,0(s3)
    return buf;
}
    1096:	855e                	mv	a0,s7
    1098:	60e6                	ld	ra,88(sp)
    109a:	6446                	ld	s0,80(sp)
    109c:	64a6                	ld	s1,72(sp)
    109e:	6906                	ld	s2,64(sp)
    10a0:	79e2                	ld	s3,56(sp)
    10a2:	7a42                	ld	s4,48(sp)
    10a4:	7aa2                	ld	s5,40(sp)
    10a6:	7b02                	ld	s6,32(sp)
    10a8:	6be2                	ld	s7,24(sp)
    10aa:	6125                	addi	sp,sp,96
    10ac:	8082                	ret

00000000000010ae <stat>:

int stat(const char *n, struct stat *st)
{
    10ae:	1101                	addi	sp,sp,-32
    10b0:	ec06                	sd	ra,24(sp)
    10b2:	e822                	sd	s0,16(sp)
    10b4:	e426                	sd	s1,8(sp)
    10b6:	e04a                	sd	s2,0(sp)
    10b8:	1000                	addi	s0,sp,32
    10ba:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    10bc:	4581                	li	a1,0
    10be:	00000097          	auipc	ra,0x0
    10c2:	170080e7          	jalr	368(ra) # 122e <open>
    if (fd < 0)
    10c6:	02054563          	bltz	a0,10f0 <stat+0x42>
    10ca:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
    10cc:	85ca                	mv	a1,s2
    10ce:	00000097          	auipc	ra,0x0
    10d2:	178080e7          	jalr	376(ra) # 1246 <fstat>
    10d6:	892a                	mv	s2,a0
    close(fd);
    10d8:	8526                	mv	a0,s1
    10da:	00000097          	auipc	ra,0x0
    10de:	13c080e7          	jalr	316(ra) # 1216 <close>
    return r;
}
    10e2:	854a                	mv	a0,s2
    10e4:	60e2                	ld	ra,24(sp)
    10e6:	6442                	ld	s0,16(sp)
    10e8:	64a2                	ld	s1,8(sp)
    10ea:	6902                	ld	s2,0(sp)
    10ec:	6105                	addi	sp,sp,32
    10ee:	8082                	ret
        return -1;
    10f0:	597d                	li	s2,-1
    10f2:	bfc5                	j	10e2 <stat+0x34>

00000000000010f4 <atoi>:

int atoi(const char *s)
{
    10f4:	1141                	addi	sp,sp,-16
    10f6:	e422                	sd	s0,8(sp)
    10f8:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
    10fa:	00054683          	lbu	a3,0(a0)
    10fe:	fd06879b          	addiw	a5,a3,-48
    1102:	0ff7f793          	zext.b	a5,a5
    1106:	4625                	li	a2,9
    1108:	02f66863          	bltu	a2,a5,1138 <atoi+0x44>
    110c:	872a                	mv	a4,a0
    n = 0;
    110e:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
    1110:	0705                	addi	a4,a4,1
    1112:	0025179b          	slliw	a5,a0,0x2
    1116:	9fa9                	addw	a5,a5,a0
    1118:	0017979b          	slliw	a5,a5,0x1
    111c:	9fb5                	addw	a5,a5,a3
    111e:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    1122:	00074683          	lbu	a3,0(a4)
    1126:	fd06879b          	addiw	a5,a3,-48
    112a:	0ff7f793          	zext.b	a5,a5
    112e:	fef671e3          	bgeu	a2,a5,1110 <atoi+0x1c>
    return n;
}
    1132:	6422                	ld	s0,8(sp)
    1134:	0141                	addi	sp,sp,16
    1136:	8082                	ret
    n = 0;
    1138:	4501                	li	a0,0
    113a:	bfe5                	j	1132 <atoi+0x3e>

000000000000113c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    113c:	1141                	addi	sp,sp,-16
    113e:	e422                	sd	s0,8(sp)
    1140:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
    1142:	02b57463          	bgeu	a0,a1,116a <memmove+0x2e>
    {
        while (n-- > 0)
    1146:	00c05f63          	blez	a2,1164 <memmove+0x28>
    114a:	1602                	slli	a2,a2,0x20
    114c:	9201                	srli	a2,a2,0x20
    114e:	00c507b3          	add	a5,a0,a2
    dst = vdst;
    1152:	872a                	mv	a4,a0
            *dst++ = *src++;
    1154:	0585                	addi	a1,a1,1
    1156:	0705                	addi	a4,a4,1
    1158:	fff5c683          	lbu	a3,-1(a1)
    115c:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    1160:	fee79ae3          	bne	a5,a4,1154 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
    1164:	6422                	ld	s0,8(sp)
    1166:	0141                	addi	sp,sp,16
    1168:	8082                	ret
        dst += n;
    116a:	00c50733          	add	a4,a0,a2
        src += n;
    116e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1170:	fec05ae3          	blez	a2,1164 <memmove+0x28>
    1174:	fff6079b          	addiw	a5,a2,-1
    1178:	1782                	slli	a5,a5,0x20
    117a:	9381                	srli	a5,a5,0x20
    117c:	fff7c793          	not	a5,a5
    1180:	97ba                	add	a5,a5,a4
            *--dst = *--src;
    1182:	15fd                	addi	a1,a1,-1
    1184:	177d                	addi	a4,a4,-1
    1186:	0005c683          	lbu	a3,0(a1)
    118a:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    118e:	fee79ae3          	bne	a5,a4,1182 <memmove+0x46>
    1192:	bfc9                	j	1164 <memmove+0x28>

0000000000001194 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    1194:	1141                	addi	sp,sp,-16
    1196:	e422                	sd	s0,8(sp)
    1198:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
    119a:	ca05                	beqz	a2,11ca <memcmp+0x36>
    119c:	fff6069b          	addiw	a3,a2,-1
    11a0:	1682                	slli	a3,a3,0x20
    11a2:	9281                	srli	a3,a3,0x20
    11a4:	0685                	addi	a3,a3,1
    11a6:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
    11a8:	00054783          	lbu	a5,0(a0)
    11ac:	0005c703          	lbu	a4,0(a1)
    11b0:	00e79863          	bne	a5,a4,11c0 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
    11b4:	0505                	addi	a0,a0,1
        p2++;
    11b6:	0585                	addi	a1,a1,1
    while (n-- > 0)
    11b8:	fed518e3          	bne	a0,a3,11a8 <memcmp+0x14>
    }
    return 0;
    11bc:	4501                	li	a0,0
    11be:	a019                	j	11c4 <memcmp+0x30>
            return *p1 - *p2;
    11c0:	40e7853b          	subw	a0,a5,a4
}
    11c4:	6422                	ld	s0,8(sp)
    11c6:	0141                	addi	sp,sp,16
    11c8:	8082                	ret
    return 0;
    11ca:	4501                	li	a0,0
    11cc:	bfe5                	j	11c4 <memcmp+0x30>

00000000000011ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    11ce:	1141                	addi	sp,sp,-16
    11d0:	e406                	sd	ra,8(sp)
    11d2:	e022                	sd	s0,0(sp)
    11d4:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    11d6:	00000097          	auipc	ra,0x0
    11da:	f66080e7          	jalr	-154(ra) # 113c <memmove>
}
    11de:	60a2                	ld	ra,8(sp)
    11e0:	6402                	ld	s0,0(sp)
    11e2:	0141                	addi	sp,sp,16
    11e4:	8082                	ret

00000000000011e6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    11e6:	4885                	li	a7,1
 ecall
    11e8:	00000073          	ecall
 ret
    11ec:	8082                	ret

00000000000011ee <exit>:
.global exit
exit:
 li a7, SYS_exit
    11ee:	4889                	li	a7,2
 ecall
    11f0:	00000073          	ecall
 ret
    11f4:	8082                	ret

00000000000011f6 <wait>:
.global wait
wait:
 li a7, SYS_wait
    11f6:	488d                	li	a7,3
 ecall
    11f8:	00000073          	ecall
 ret
    11fc:	8082                	ret

00000000000011fe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    11fe:	4891                	li	a7,4
 ecall
    1200:	00000073          	ecall
 ret
    1204:	8082                	ret

0000000000001206 <read>:
.global read
read:
 li a7, SYS_read
    1206:	4895                	li	a7,5
 ecall
    1208:	00000073          	ecall
 ret
    120c:	8082                	ret

000000000000120e <write>:
.global write
write:
 li a7, SYS_write
    120e:	48c1                	li	a7,16
 ecall
    1210:	00000073          	ecall
 ret
    1214:	8082                	ret

0000000000001216 <close>:
.global close
close:
 li a7, SYS_close
    1216:	48d5                	li	a7,21
 ecall
    1218:	00000073          	ecall
 ret
    121c:	8082                	ret

000000000000121e <kill>:
.global kill
kill:
 li a7, SYS_kill
    121e:	4899                	li	a7,6
 ecall
    1220:	00000073          	ecall
 ret
    1224:	8082                	ret

0000000000001226 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1226:	489d                	li	a7,7
 ecall
    1228:	00000073          	ecall
 ret
    122c:	8082                	ret

000000000000122e <open>:
.global open
open:
 li a7, SYS_open
    122e:	48bd                	li	a7,15
 ecall
    1230:	00000073          	ecall
 ret
    1234:	8082                	ret

0000000000001236 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1236:	48c5                	li	a7,17
 ecall
    1238:	00000073          	ecall
 ret
    123c:	8082                	ret

000000000000123e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    123e:	48c9                	li	a7,18
 ecall
    1240:	00000073          	ecall
 ret
    1244:	8082                	ret

0000000000001246 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1246:	48a1                	li	a7,8
 ecall
    1248:	00000073          	ecall
 ret
    124c:	8082                	ret

000000000000124e <link>:
.global link
link:
 li a7, SYS_link
    124e:	48cd                	li	a7,19
 ecall
    1250:	00000073          	ecall
 ret
    1254:	8082                	ret

0000000000001256 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1256:	48d1                	li	a7,20
 ecall
    1258:	00000073          	ecall
 ret
    125c:	8082                	ret

000000000000125e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    125e:	48a5                	li	a7,9
 ecall
    1260:	00000073          	ecall
 ret
    1264:	8082                	ret

0000000000001266 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1266:	48a9                	li	a7,10
 ecall
    1268:	00000073          	ecall
 ret
    126c:	8082                	ret

000000000000126e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    126e:	48ad                	li	a7,11
 ecall
    1270:	00000073          	ecall
 ret
    1274:	8082                	ret

0000000000001276 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1276:	48b1                	li	a7,12
 ecall
    1278:	00000073          	ecall
 ret
    127c:	8082                	ret

000000000000127e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    127e:	48b5                	li	a7,13
 ecall
    1280:	00000073          	ecall
 ret
    1284:	8082                	ret

0000000000001286 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1286:	48b9                	li	a7,14
 ecall
    1288:	00000073          	ecall
 ret
    128c:	8082                	ret

000000000000128e <ps>:
.global ps
ps:
 li a7, SYS_ps
    128e:	48d9                	li	a7,22
 ecall
    1290:	00000073          	ecall
 ret
    1294:	8082                	ret

0000000000001296 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
    1296:	48dd                	li	a7,23
 ecall
    1298:	00000073          	ecall
 ret
    129c:	8082                	ret

000000000000129e <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
    129e:	48e1                	li	a7,24
 ecall
    12a0:	00000073          	ecall
 ret
    12a4:	8082                	ret

00000000000012a6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    12a6:	1101                	addi	sp,sp,-32
    12a8:	ec06                	sd	ra,24(sp)
    12aa:	e822                	sd	s0,16(sp)
    12ac:	1000                	addi	s0,sp,32
    12ae:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    12b2:	4605                	li	a2,1
    12b4:	fef40593          	addi	a1,s0,-17
    12b8:	00000097          	auipc	ra,0x0
    12bc:	f56080e7          	jalr	-170(ra) # 120e <write>
}
    12c0:	60e2                	ld	ra,24(sp)
    12c2:	6442                	ld	s0,16(sp)
    12c4:	6105                	addi	sp,sp,32
    12c6:	8082                	ret

00000000000012c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12c8:	7139                	addi	sp,sp,-64
    12ca:	fc06                	sd	ra,56(sp)
    12cc:	f822                	sd	s0,48(sp)
    12ce:	f426                	sd	s1,40(sp)
    12d0:	f04a                	sd	s2,32(sp)
    12d2:	ec4e                	sd	s3,24(sp)
    12d4:	0080                	addi	s0,sp,64
    12d6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12d8:	c299                	beqz	a3,12de <printint+0x16>
    12da:	0805c963          	bltz	a1,136c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    12de:	2581                	sext.w	a1,a1
  neg = 0;
    12e0:	4881                	li	a7,0
    12e2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    12e6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    12e8:	2601                	sext.w	a2,a2
    12ea:	00001517          	auipc	a0,0x1
    12ee:	81e50513          	addi	a0,a0,-2018 # 1b08 <digits>
    12f2:	883a                	mv	a6,a4
    12f4:	2705                	addiw	a4,a4,1
    12f6:	02c5f7bb          	remuw	a5,a1,a2
    12fa:	1782                	slli	a5,a5,0x20
    12fc:	9381                	srli	a5,a5,0x20
    12fe:	97aa                	add	a5,a5,a0
    1300:	0007c783          	lbu	a5,0(a5)
    1304:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    1308:	0005879b          	sext.w	a5,a1
    130c:	02c5d5bb          	divuw	a1,a1,a2
    1310:	0685                	addi	a3,a3,1
    1312:	fec7f0e3          	bgeu	a5,a2,12f2 <printint+0x2a>
  if(neg)
    1316:	00088c63          	beqz	a7,132e <printint+0x66>
    buf[i++] = '-';
    131a:	fd070793          	addi	a5,a4,-48
    131e:	00878733          	add	a4,a5,s0
    1322:	02d00793          	li	a5,45
    1326:	fef70823          	sb	a5,-16(a4)
    132a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    132e:	02e05863          	blez	a4,135e <printint+0x96>
    1332:	fc040793          	addi	a5,s0,-64
    1336:	00e78933          	add	s2,a5,a4
    133a:	fff78993          	addi	s3,a5,-1
    133e:	99ba                	add	s3,s3,a4
    1340:	377d                	addiw	a4,a4,-1
    1342:	1702                	slli	a4,a4,0x20
    1344:	9301                	srli	a4,a4,0x20
    1346:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    134a:	fff94583          	lbu	a1,-1(s2)
    134e:	8526                	mv	a0,s1
    1350:	00000097          	auipc	ra,0x0
    1354:	f56080e7          	jalr	-170(ra) # 12a6 <putc>
  while(--i >= 0)
    1358:	197d                	addi	s2,s2,-1
    135a:	ff3918e3          	bne	s2,s3,134a <printint+0x82>
}
    135e:	70e2                	ld	ra,56(sp)
    1360:	7442                	ld	s0,48(sp)
    1362:	74a2                	ld	s1,40(sp)
    1364:	7902                	ld	s2,32(sp)
    1366:	69e2                	ld	s3,24(sp)
    1368:	6121                	addi	sp,sp,64
    136a:	8082                	ret
    x = -xx;
    136c:	40b005bb          	negw	a1,a1
    neg = 1;
    1370:	4885                	li	a7,1
    x = -xx;
    1372:	bf85                	j	12e2 <printint+0x1a>

0000000000001374 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1374:	715d                	addi	sp,sp,-80
    1376:	e486                	sd	ra,72(sp)
    1378:	e0a2                	sd	s0,64(sp)
    137a:	fc26                	sd	s1,56(sp)
    137c:	f84a                	sd	s2,48(sp)
    137e:	f44e                	sd	s3,40(sp)
    1380:	f052                	sd	s4,32(sp)
    1382:	ec56                	sd	s5,24(sp)
    1384:	e85a                	sd	s6,16(sp)
    1386:	e45e                	sd	s7,8(sp)
    1388:	e062                	sd	s8,0(sp)
    138a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    138c:	0005c903          	lbu	s2,0(a1)
    1390:	18090c63          	beqz	s2,1528 <vprintf+0x1b4>
    1394:	8aaa                	mv	s5,a0
    1396:	8bb2                	mv	s7,a2
    1398:	00158493          	addi	s1,a1,1
  state = 0;
    139c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    139e:	02500a13          	li	s4,37
    13a2:	4b55                	li	s6,21
    13a4:	a839                	j	13c2 <vprintf+0x4e>
        putc(fd, c);
    13a6:	85ca                	mv	a1,s2
    13a8:	8556                	mv	a0,s5
    13aa:	00000097          	auipc	ra,0x0
    13ae:	efc080e7          	jalr	-260(ra) # 12a6 <putc>
    13b2:	a019                	j	13b8 <vprintf+0x44>
    } else if(state == '%'){
    13b4:	01498d63          	beq	s3,s4,13ce <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    13b8:	0485                	addi	s1,s1,1
    13ba:	fff4c903          	lbu	s2,-1(s1)
    13be:	16090563          	beqz	s2,1528 <vprintf+0x1b4>
    if(state == 0){
    13c2:	fe0999e3          	bnez	s3,13b4 <vprintf+0x40>
      if(c == '%'){
    13c6:	ff4910e3          	bne	s2,s4,13a6 <vprintf+0x32>
        state = '%';
    13ca:	89d2                	mv	s3,s4
    13cc:	b7f5                	j	13b8 <vprintf+0x44>
      if(c == 'd'){
    13ce:	13490263          	beq	s2,s4,14f2 <vprintf+0x17e>
    13d2:	f9d9079b          	addiw	a5,s2,-99
    13d6:	0ff7f793          	zext.b	a5,a5
    13da:	12fb6563          	bltu	s6,a5,1504 <vprintf+0x190>
    13de:	f9d9079b          	addiw	a5,s2,-99
    13e2:	0ff7f713          	zext.b	a4,a5
    13e6:	10eb6f63          	bltu	s6,a4,1504 <vprintf+0x190>
    13ea:	00271793          	slli	a5,a4,0x2
    13ee:	00000717          	auipc	a4,0x0
    13f2:	6c270713          	addi	a4,a4,1730 # 1ab0 <malloc+0x48a>
    13f6:	97ba                	add	a5,a5,a4
    13f8:	439c                	lw	a5,0(a5)
    13fa:	97ba                	add	a5,a5,a4
    13fc:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    13fe:	008b8913          	addi	s2,s7,8
    1402:	4685                	li	a3,1
    1404:	4629                	li	a2,10
    1406:	000ba583          	lw	a1,0(s7)
    140a:	8556                	mv	a0,s5
    140c:	00000097          	auipc	ra,0x0
    1410:	ebc080e7          	jalr	-324(ra) # 12c8 <printint>
    1414:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1416:	4981                	li	s3,0
    1418:	b745                	j	13b8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    141a:	008b8913          	addi	s2,s7,8
    141e:	4681                	li	a3,0
    1420:	4629                	li	a2,10
    1422:	000ba583          	lw	a1,0(s7)
    1426:	8556                	mv	a0,s5
    1428:	00000097          	auipc	ra,0x0
    142c:	ea0080e7          	jalr	-352(ra) # 12c8 <printint>
    1430:	8bca                	mv	s7,s2
      state = 0;
    1432:	4981                	li	s3,0
    1434:	b751                	j	13b8 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    1436:	008b8913          	addi	s2,s7,8
    143a:	4681                	li	a3,0
    143c:	4641                	li	a2,16
    143e:	000ba583          	lw	a1,0(s7)
    1442:	8556                	mv	a0,s5
    1444:	00000097          	auipc	ra,0x0
    1448:	e84080e7          	jalr	-380(ra) # 12c8 <printint>
    144c:	8bca                	mv	s7,s2
      state = 0;
    144e:	4981                	li	s3,0
    1450:	b7a5                	j	13b8 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    1452:	008b8c13          	addi	s8,s7,8
    1456:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    145a:	03000593          	li	a1,48
    145e:	8556                	mv	a0,s5
    1460:	00000097          	auipc	ra,0x0
    1464:	e46080e7          	jalr	-442(ra) # 12a6 <putc>
  putc(fd, 'x');
    1468:	07800593          	li	a1,120
    146c:	8556                	mv	a0,s5
    146e:	00000097          	auipc	ra,0x0
    1472:	e38080e7          	jalr	-456(ra) # 12a6 <putc>
    1476:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1478:	00000b97          	auipc	s7,0x0
    147c:	690b8b93          	addi	s7,s7,1680 # 1b08 <digits>
    1480:	03c9d793          	srli	a5,s3,0x3c
    1484:	97de                	add	a5,a5,s7
    1486:	0007c583          	lbu	a1,0(a5)
    148a:	8556                	mv	a0,s5
    148c:	00000097          	auipc	ra,0x0
    1490:	e1a080e7          	jalr	-486(ra) # 12a6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1494:	0992                	slli	s3,s3,0x4
    1496:	397d                	addiw	s2,s2,-1
    1498:	fe0914e3          	bnez	s2,1480 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    149c:	8be2                	mv	s7,s8
      state = 0;
    149e:	4981                	li	s3,0
    14a0:	bf21                	j	13b8 <vprintf+0x44>
        s = va_arg(ap, char*);
    14a2:	008b8993          	addi	s3,s7,8
    14a6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    14aa:	02090163          	beqz	s2,14cc <vprintf+0x158>
        while(*s != 0){
    14ae:	00094583          	lbu	a1,0(s2)
    14b2:	c9a5                	beqz	a1,1522 <vprintf+0x1ae>
          putc(fd, *s);
    14b4:	8556                	mv	a0,s5
    14b6:	00000097          	auipc	ra,0x0
    14ba:	df0080e7          	jalr	-528(ra) # 12a6 <putc>
          s++;
    14be:	0905                	addi	s2,s2,1
        while(*s != 0){
    14c0:	00094583          	lbu	a1,0(s2)
    14c4:	f9e5                	bnez	a1,14b4 <vprintf+0x140>
        s = va_arg(ap, char*);
    14c6:	8bce                	mv	s7,s3
      state = 0;
    14c8:	4981                	li	s3,0
    14ca:	b5fd                	j	13b8 <vprintf+0x44>
          s = "(null)";
    14cc:	00000917          	auipc	s2,0x0
    14d0:	5dc90913          	addi	s2,s2,1500 # 1aa8 <malloc+0x482>
        while(*s != 0){
    14d4:	02800593          	li	a1,40
    14d8:	bff1                	j	14b4 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    14da:	008b8913          	addi	s2,s7,8
    14de:	000bc583          	lbu	a1,0(s7)
    14e2:	8556                	mv	a0,s5
    14e4:	00000097          	auipc	ra,0x0
    14e8:	dc2080e7          	jalr	-574(ra) # 12a6 <putc>
    14ec:	8bca                	mv	s7,s2
      state = 0;
    14ee:	4981                	li	s3,0
    14f0:	b5e1                	j	13b8 <vprintf+0x44>
        putc(fd, c);
    14f2:	02500593          	li	a1,37
    14f6:	8556                	mv	a0,s5
    14f8:	00000097          	auipc	ra,0x0
    14fc:	dae080e7          	jalr	-594(ra) # 12a6 <putc>
      state = 0;
    1500:	4981                	li	s3,0
    1502:	bd5d                	j	13b8 <vprintf+0x44>
        putc(fd, '%');
    1504:	02500593          	li	a1,37
    1508:	8556                	mv	a0,s5
    150a:	00000097          	auipc	ra,0x0
    150e:	d9c080e7          	jalr	-612(ra) # 12a6 <putc>
        putc(fd, c);
    1512:	85ca                	mv	a1,s2
    1514:	8556                	mv	a0,s5
    1516:	00000097          	auipc	ra,0x0
    151a:	d90080e7          	jalr	-624(ra) # 12a6 <putc>
      state = 0;
    151e:	4981                	li	s3,0
    1520:	bd61                	j	13b8 <vprintf+0x44>
        s = va_arg(ap, char*);
    1522:	8bce                	mv	s7,s3
      state = 0;
    1524:	4981                	li	s3,0
    1526:	bd49                	j	13b8 <vprintf+0x44>
    }
  }
}
    1528:	60a6                	ld	ra,72(sp)
    152a:	6406                	ld	s0,64(sp)
    152c:	74e2                	ld	s1,56(sp)
    152e:	7942                	ld	s2,48(sp)
    1530:	79a2                	ld	s3,40(sp)
    1532:	7a02                	ld	s4,32(sp)
    1534:	6ae2                	ld	s5,24(sp)
    1536:	6b42                	ld	s6,16(sp)
    1538:	6ba2                	ld	s7,8(sp)
    153a:	6c02                	ld	s8,0(sp)
    153c:	6161                	addi	sp,sp,80
    153e:	8082                	ret

0000000000001540 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1540:	715d                	addi	sp,sp,-80
    1542:	ec06                	sd	ra,24(sp)
    1544:	e822                	sd	s0,16(sp)
    1546:	1000                	addi	s0,sp,32
    1548:	e010                	sd	a2,0(s0)
    154a:	e414                	sd	a3,8(s0)
    154c:	e818                	sd	a4,16(s0)
    154e:	ec1c                	sd	a5,24(s0)
    1550:	03043023          	sd	a6,32(s0)
    1554:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1558:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    155c:	8622                	mv	a2,s0
    155e:	00000097          	auipc	ra,0x0
    1562:	e16080e7          	jalr	-490(ra) # 1374 <vprintf>
}
    1566:	60e2                	ld	ra,24(sp)
    1568:	6442                	ld	s0,16(sp)
    156a:	6161                	addi	sp,sp,80
    156c:	8082                	ret

000000000000156e <printf>:

void
printf(const char *fmt, ...)
{
    156e:	711d                	addi	sp,sp,-96
    1570:	ec06                	sd	ra,24(sp)
    1572:	e822                	sd	s0,16(sp)
    1574:	1000                	addi	s0,sp,32
    1576:	e40c                	sd	a1,8(s0)
    1578:	e810                	sd	a2,16(s0)
    157a:	ec14                	sd	a3,24(s0)
    157c:	f018                	sd	a4,32(s0)
    157e:	f41c                	sd	a5,40(s0)
    1580:	03043823          	sd	a6,48(s0)
    1584:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1588:	00840613          	addi	a2,s0,8
    158c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1590:	85aa                	mv	a1,a0
    1592:	4505                	li	a0,1
    1594:	00000097          	auipc	ra,0x0
    1598:	de0080e7          	jalr	-544(ra) # 1374 <vprintf>
}
    159c:	60e2                	ld	ra,24(sp)
    159e:	6442                	ld	s0,16(sp)
    15a0:	6125                	addi	sp,sp,96
    15a2:	8082                	ret

00000000000015a4 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    15a4:	1141                	addi	sp,sp,-16
    15a6:	e422                	sd	s0,8(sp)
    15a8:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    15aa:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15ae:	00001797          	auipc	a5,0x1
    15b2:	a6a7b783          	ld	a5,-1430(a5) # 2018 <freep>
    15b6:	a02d                	j	15e0 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    15b8:	4618                	lw	a4,8(a2)
    15ba:	9f2d                	addw	a4,a4,a1
    15bc:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    15c0:	6398                	ld	a4,0(a5)
    15c2:	6310                	ld	a2,0(a4)
    15c4:	a83d                	j	1602 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    15c6:	ff852703          	lw	a4,-8(a0)
    15ca:	9f31                	addw	a4,a4,a2
    15cc:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    15ce:	ff053683          	ld	a3,-16(a0)
    15d2:	a091                	j	1616 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15d4:	6398                	ld	a4,0(a5)
    15d6:	00e7e463          	bltu	a5,a4,15de <free+0x3a>
    15da:	00e6ea63          	bltu	a3,a4,15ee <free+0x4a>
{
    15de:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15e0:	fed7fae3          	bgeu	a5,a3,15d4 <free+0x30>
    15e4:	6398                	ld	a4,0(a5)
    15e6:	00e6e463          	bltu	a3,a4,15ee <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15ea:	fee7eae3          	bltu	a5,a4,15de <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    15ee:	ff852583          	lw	a1,-8(a0)
    15f2:	6390                	ld	a2,0(a5)
    15f4:	02059813          	slli	a6,a1,0x20
    15f8:	01c85713          	srli	a4,a6,0x1c
    15fc:	9736                	add	a4,a4,a3
    15fe:	fae60de3          	beq	a2,a4,15b8 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    1602:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    1606:	4790                	lw	a2,8(a5)
    1608:	02061593          	slli	a1,a2,0x20
    160c:	01c5d713          	srli	a4,a1,0x1c
    1610:	973e                	add	a4,a4,a5
    1612:	fae68ae3          	beq	a3,a4,15c6 <free+0x22>
        p->s.ptr = bp->s.ptr;
    1616:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    1618:	00001717          	auipc	a4,0x1
    161c:	a0f73023          	sd	a5,-1536(a4) # 2018 <freep>
}
    1620:	6422                	ld	s0,8(sp)
    1622:	0141                	addi	sp,sp,16
    1624:	8082                	ret

0000000000001626 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    1626:	7139                	addi	sp,sp,-64
    1628:	fc06                	sd	ra,56(sp)
    162a:	f822                	sd	s0,48(sp)
    162c:	f426                	sd	s1,40(sp)
    162e:	f04a                	sd	s2,32(sp)
    1630:	ec4e                	sd	s3,24(sp)
    1632:	e852                	sd	s4,16(sp)
    1634:	e456                	sd	s5,8(sp)
    1636:	e05a                	sd	s6,0(sp)
    1638:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    163a:	02051493          	slli	s1,a0,0x20
    163e:	9081                	srli	s1,s1,0x20
    1640:	04bd                	addi	s1,s1,15
    1642:	8091                	srli	s1,s1,0x4
    1644:	0014899b          	addiw	s3,s1,1
    1648:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    164a:	00001517          	auipc	a0,0x1
    164e:	9ce53503          	ld	a0,-1586(a0) # 2018 <freep>
    1652:	c515                	beqz	a0,167e <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    1654:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    1656:	4798                	lw	a4,8(a5)
    1658:	02977f63          	bgeu	a4,s1,1696 <malloc+0x70>
    if (nu < 4096)
    165c:	8a4e                	mv	s4,s3
    165e:	0009871b          	sext.w	a4,s3
    1662:	6685                	lui	a3,0x1
    1664:	00d77363          	bgeu	a4,a3,166a <malloc+0x44>
    1668:	6a05                	lui	s4,0x1
    166a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    166e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    1672:	00001917          	auipc	s2,0x1
    1676:	9a690913          	addi	s2,s2,-1626 # 2018 <freep>
    if (p == (char *)-1)
    167a:	5afd                	li	s5,-1
    167c:	a895                	j	16f0 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    167e:	00001797          	auipc	a5,0x1
    1682:	e0a78793          	addi	a5,a5,-502 # 2488 <base>
    1686:	00001717          	auipc	a4,0x1
    168a:	98f73923          	sd	a5,-1646(a4) # 2018 <freep>
    168e:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    1690:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    1694:	b7e1                	j	165c <malloc+0x36>
            if (p->s.size == nunits)
    1696:	02e48c63          	beq	s1,a4,16ce <malloc+0xa8>
                p->s.size -= nunits;
    169a:	4137073b          	subw	a4,a4,s3
    169e:	c798                	sw	a4,8(a5)
                p += p->s.size;
    16a0:	02071693          	slli	a3,a4,0x20
    16a4:	01c6d713          	srli	a4,a3,0x1c
    16a8:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    16aa:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    16ae:	00001717          	auipc	a4,0x1
    16b2:	96a73523          	sd	a0,-1686(a4) # 2018 <freep>
            return (void *)(p + 1);
    16b6:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    16ba:	70e2                	ld	ra,56(sp)
    16bc:	7442                	ld	s0,48(sp)
    16be:	74a2                	ld	s1,40(sp)
    16c0:	7902                	ld	s2,32(sp)
    16c2:	69e2                	ld	s3,24(sp)
    16c4:	6a42                	ld	s4,16(sp)
    16c6:	6aa2                	ld	s5,8(sp)
    16c8:	6b02                	ld	s6,0(sp)
    16ca:	6121                	addi	sp,sp,64
    16cc:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    16ce:	6398                	ld	a4,0(a5)
    16d0:	e118                	sd	a4,0(a0)
    16d2:	bff1                	j	16ae <malloc+0x88>
    hp->s.size = nu;
    16d4:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    16d8:	0541                	addi	a0,a0,16
    16da:	00000097          	auipc	ra,0x0
    16de:	eca080e7          	jalr	-310(ra) # 15a4 <free>
    return freep;
    16e2:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    16e6:	d971                	beqz	a0,16ba <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    16e8:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    16ea:	4798                	lw	a4,8(a5)
    16ec:	fa9775e3          	bgeu	a4,s1,1696 <malloc+0x70>
        if (p == freep)
    16f0:	00093703          	ld	a4,0(s2)
    16f4:	853e                	mv	a0,a5
    16f6:	fef719e3          	bne	a4,a5,16e8 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    16fa:	8552                	mv	a0,s4
    16fc:	00000097          	auipc	ra,0x0
    1700:	b7a080e7          	jalr	-1158(ra) # 1276 <sbrk>
    if (p == (char *)-1)
    1704:	fd5518e3          	bne	a0,s5,16d4 <malloc+0xae>
                return 0;
    1708:	4501                	li	a0,0
    170a:	bf45                	j	16ba <malloc+0x94>
