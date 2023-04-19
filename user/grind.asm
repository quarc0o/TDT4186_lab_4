
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
      94:	22a080e7          	jalr	554(ra) # 12ba <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	6b650513          	addi	a0,a0,1718 # 1750 <malloc+0xe6>
      a2:	00001097          	auipc	ra,0x1
      a6:	1f8080e7          	jalr	504(ra) # 129a <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	6a650513          	addi	a0,a0,1702 # 1750 <malloc+0xe6>
      b2:	00001097          	auipc	ra,0x1
      b6:	1f0080e7          	jalr	496(ra) # 12a2 <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	69c50513          	addi	a0,a0,1692 # 1758 <malloc+0xee>
      c4:	00001097          	auipc	ra,0x1
      c8:	4ee080e7          	jalr	1262(ra) # 15b2 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	164080e7          	jalr	356(ra) # 1232 <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	6a250513          	addi	a0,a0,1698 # 1778 <malloc+0x10e>
      de:	00001097          	auipc	ra,0x1
      e2:	1c4080e7          	jalr	452(ra) # 12a2 <chdir>
      e6:	00001997          	auipc	s3,0x1
      ea:	6a298993          	addi	s3,s3,1698 # 1788 <malloc+0x11e>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	69098993          	addi	s3,s3,1680 # 1780 <malloc+0x116>
  uint64 iters = 0;
      f8:	4481                	li	s1,0
  int fd = -1;
      fa:	5a7d                	li	s4,-1
      fc:	00002917          	auipc	s2,0x2
     100:	93c90913          	addi	s2,s2,-1732 # 1a38 <malloc+0x3ce>
     104:	a839                	j	122 <go+0xaa>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	68650513          	addi	a0,a0,1670 # 1790 <malloc+0x126>
     112:	00001097          	auipc	ra,0x1
     116:	160080e7          	jalr	352(ra) # 1272 <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	140080e7          	jalr	320(ra) # 125a <close>
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
     138:	11e080e7          	jalr	286(ra) # 1252 <write>
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
     168:	63c50513          	addi	a0,a0,1596 # 17a0 <malloc+0x136>
     16c:	00001097          	auipc	ra,0x1
     170:	106080e7          	jalr	262(ra) # 1272 <open>
     174:	00001097          	auipc	ra,0x1
     178:	0e6080e7          	jalr	230(ra) # 125a <close>
     17c:	b75d                	j	122 <go+0xaa>
    } else if(what == 3){
      unlink("grindir/../a");
     17e:	00001517          	auipc	a0,0x1
     182:	61250513          	addi	a0,a0,1554 # 1790 <malloc+0x126>
     186:	00001097          	auipc	ra,0x1
     18a:	0fc080e7          	jalr	252(ra) # 1282 <unlink>
     18e:	bf51                	j	122 <go+0xaa>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     190:	00001517          	auipc	a0,0x1
     194:	5c050513          	addi	a0,a0,1472 # 1750 <malloc+0xe6>
     198:	00001097          	auipc	ra,0x1
     19c:	10a080e7          	jalr	266(ra) # 12a2 <chdir>
     1a0:	e115                	bnez	a0,1c4 <go+0x14c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     1a2:	00001517          	auipc	a0,0x1
     1a6:	61650513          	addi	a0,a0,1558 # 17b8 <malloc+0x14e>
     1aa:	00001097          	auipc	ra,0x1
     1ae:	0d8080e7          	jalr	216(ra) # 1282 <unlink>
      chdir("/");
     1b2:	00001517          	auipc	a0,0x1
     1b6:	5c650513          	addi	a0,a0,1478 # 1778 <malloc+0x10e>
     1ba:	00001097          	auipc	ra,0x1
     1be:	0e8080e7          	jalr	232(ra) # 12a2 <chdir>
     1c2:	b785                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     1c4:	00001517          	auipc	a0,0x1
     1c8:	59450513          	addi	a0,a0,1428 # 1758 <malloc+0xee>
     1cc:	00001097          	auipc	ra,0x1
     1d0:	3e6080e7          	jalr	998(ra) # 15b2 <printf>
        exit(1);
     1d4:	4505                	li	a0,1
     1d6:	00001097          	auipc	ra,0x1
     1da:	05c080e7          	jalr	92(ra) # 1232 <exit>
    } else if(what == 5){
      close(fd);
     1de:	8552                	mv	a0,s4
     1e0:	00001097          	auipc	ra,0x1
     1e4:	07a080e7          	jalr	122(ra) # 125a <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1e8:	20200593          	li	a1,514
     1ec:	00001517          	auipc	a0,0x1
     1f0:	5d450513          	addi	a0,a0,1492 # 17c0 <malloc+0x156>
     1f4:	00001097          	auipc	ra,0x1
     1f8:	07e080e7          	jalr	126(ra) # 1272 <open>
     1fc:	8a2a                	mv	s4,a0
     1fe:	b715                	j	122 <go+0xaa>
    } else if(what == 6){
      close(fd);
     200:	8552                	mv	a0,s4
     202:	00001097          	auipc	ra,0x1
     206:	058080e7          	jalr	88(ra) # 125a <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	5c250513          	addi	a0,a0,1474 # 17d0 <malloc+0x166>
     216:	00001097          	auipc	ra,0x1
     21a:	05c080e7          	jalr	92(ra) # 1272 <open>
     21e:	8a2a                	mv	s4,a0
     220:	b709                	j	122 <go+0xaa>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     222:	3e700613          	li	a2,999
     226:	00002597          	auipc	a1,0x2
     22a:	dfa58593          	addi	a1,a1,-518 # 2020 <buf.0>
     22e:	8552                	mv	a0,s4
     230:	00001097          	auipc	ra,0x1
     234:	022080e7          	jalr	34(ra) # 1252 <write>
     238:	b5ed                	j	122 <go+0xaa>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     23a:	3e700613          	li	a2,999
     23e:	00002597          	auipc	a1,0x2
     242:	de258593          	addi	a1,a1,-542 # 2020 <buf.0>
     246:	8552                	mv	a0,s4
     248:	00001097          	auipc	ra,0x1
     24c:	002080e7          	jalr	2(ra) # 124a <read>
     250:	bdc9                	j	122 <go+0xaa>
    } else if(what == 9){
      mkdir("grindir/../a");
     252:	00001517          	auipc	a0,0x1
     256:	53e50513          	addi	a0,a0,1342 # 1790 <malloc+0x126>
     25a:	00001097          	auipc	ra,0x1
     25e:	040080e7          	jalr	64(ra) # 129a <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     262:	20200593          	li	a1,514
     266:	00001517          	auipc	a0,0x1
     26a:	58250513          	addi	a0,a0,1410 # 17e8 <malloc+0x17e>
     26e:	00001097          	auipc	ra,0x1
     272:	004080e7          	jalr	4(ra) # 1272 <open>
     276:	00001097          	auipc	ra,0x1
     27a:	fe4080e7          	jalr	-28(ra) # 125a <close>
      unlink("a/a");
     27e:	00001517          	auipc	a0,0x1
     282:	57a50513          	addi	a0,a0,1402 # 17f8 <malloc+0x18e>
     286:	00001097          	auipc	ra,0x1
     28a:	ffc080e7          	jalr	-4(ra) # 1282 <unlink>
     28e:	bd51                	j	122 <go+0xaa>
    } else if(what == 10){
      mkdir("/../b");
     290:	00001517          	auipc	a0,0x1
     294:	57050513          	addi	a0,a0,1392 # 1800 <malloc+0x196>
     298:	00001097          	auipc	ra,0x1
     29c:	002080e7          	jalr	2(ra) # 129a <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2a0:	20200593          	li	a1,514
     2a4:	00001517          	auipc	a0,0x1
     2a8:	56450513          	addi	a0,a0,1380 # 1808 <malloc+0x19e>
     2ac:	00001097          	auipc	ra,0x1
     2b0:	fc6080e7          	jalr	-58(ra) # 1272 <open>
     2b4:	00001097          	auipc	ra,0x1
     2b8:	fa6080e7          	jalr	-90(ra) # 125a <close>
      unlink("b/b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	55c50513          	addi	a0,a0,1372 # 1818 <malloc+0x1ae>
     2c4:	00001097          	auipc	ra,0x1
     2c8:	fbe080e7          	jalr	-66(ra) # 1282 <unlink>
     2cc:	bd99                	j	122 <go+0xaa>
    } else if(what == 11){
      unlink("b");
     2ce:	00001517          	auipc	a0,0x1
     2d2:	51250513          	addi	a0,a0,1298 # 17e0 <malloc+0x176>
     2d6:	00001097          	auipc	ra,0x1
     2da:	fac080e7          	jalr	-84(ra) # 1282 <unlink>
      link("../grindir/./../a", "../b");
     2de:	00001597          	auipc	a1,0x1
     2e2:	4da58593          	addi	a1,a1,1242 # 17b8 <malloc+0x14e>
     2e6:	00001517          	auipc	a0,0x1
     2ea:	53a50513          	addi	a0,a0,1338 # 1820 <malloc+0x1b6>
     2ee:	00001097          	auipc	ra,0x1
     2f2:	fa4080e7          	jalr	-92(ra) # 1292 <link>
     2f6:	b535                	j	122 <go+0xaa>
    } else if(what == 12){
      unlink("../grindir/../a");
     2f8:	00001517          	auipc	a0,0x1
     2fc:	54050513          	addi	a0,a0,1344 # 1838 <malloc+0x1ce>
     300:	00001097          	auipc	ra,0x1
     304:	f82080e7          	jalr	-126(ra) # 1282 <unlink>
      link(".././b", "/grindir/../a");
     308:	00001597          	auipc	a1,0x1
     30c:	4b858593          	addi	a1,a1,1208 # 17c0 <malloc+0x156>
     310:	00001517          	auipc	a0,0x1
     314:	53850513          	addi	a0,a0,1336 # 1848 <malloc+0x1de>
     318:	00001097          	auipc	ra,0x1
     31c:	f7a080e7          	jalr	-134(ra) # 1292 <link>
     320:	b509                	j	122 <go+0xaa>
    } else if(what == 13){
      int pid = fork();
     322:	00001097          	auipc	ra,0x1
     326:	f08080e7          	jalr	-248(ra) # 122a <fork>
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
     336:	f08080e7          	jalr	-248(ra) # 123a <wait>
     33a:	b3e5                	j	122 <go+0xaa>
        exit(0);
     33c:	00001097          	auipc	ra,0x1
     340:	ef6080e7          	jalr	-266(ra) # 1232 <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	50c50513          	addi	a0,a0,1292 # 1850 <malloc+0x1e6>
     34c:	00001097          	auipc	ra,0x1
     350:	266080e7          	jalr	614(ra) # 15b2 <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	00001097          	auipc	ra,0x1
     35a:	edc080e7          	jalr	-292(ra) # 1232 <exit>
    } else if(what == 14){
      int pid = fork();
     35e:	00001097          	auipc	ra,0x1
     362:	ecc080e7          	jalr	-308(ra) # 122a <fork>
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
     372:	ecc080e7          	jalr	-308(ra) # 123a <wait>
     376:	b375                	j	122 <go+0xaa>
        fork();
     378:	00001097          	auipc	ra,0x1
     37c:	eb2080e7          	jalr	-334(ra) # 122a <fork>
        fork();
     380:	00001097          	auipc	ra,0x1
     384:	eaa080e7          	jalr	-342(ra) # 122a <fork>
        exit(0);
     388:	4501                	li	a0,0
     38a:	00001097          	auipc	ra,0x1
     38e:	ea8080e7          	jalr	-344(ra) # 1232 <exit>
        printf("grind: fork failed\n");
     392:	00001517          	auipc	a0,0x1
     396:	4be50513          	addi	a0,a0,1214 # 1850 <malloc+0x1e6>
     39a:	00001097          	auipc	ra,0x1
     39e:	218080e7          	jalr	536(ra) # 15b2 <printf>
        exit(1);
     3a2:	4505                	li	a0,1
     3a4:	00001097          	auipc	ra,0x1
     3a8:	e8e080e7          	jalr	-370(ra) # 1232 <exit>
    } else if(what == 15){
      sbrk(6011);
     3ac:	6505                	lui	a0,0x1
     3ae:	77b50513          	addi	a0,a0,1915 # 177b <malloc+0x111>
     3b2:	00001097          	auipc	ra,0x1
     3b6:	f08080e7          	jalr	-248(ra) # 12ba <sbrk>
     3ba:	b3a5                	j	122 <go+0xaa>
    } else if(what == 16){
      if(sbrk(0) > break0)
     3bc:	4501                	li	a0,0
     3be:	00001097          	auipc	ra,0x1
     3c2:	efc080e7          	jalr	-260(ra) # 12ba <sbrk>
     3c6:	d4aafee3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     3ca:	4501                	li	a0,0
     3cc:	00001097          	auipc	ra,0x1
     3d0:	eee080e7          	jalr	-274(ra) # 12ba <sbrk>
     3d4:	40aa853b          	subw	a0,s5,a0
     3d8:	00001097          	auipc	ra,0x1
     3dc:	ee2080e7          	jalr	-286(ra) # 12ba <sbrk>
     3e0:	b389                	j	122 <go+0xaa>
    } else if(what == 17){
      int pid = fork();
     3e2:	00001097          	auipc	ra,0x1
     3e6:	e48080e7          	jalr	-440(ra) # 122a <fork>
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
     3f6:	47650513          	addi	a0,a0,1142 # 1868 <malloc+0x1fe>
     3fa:	00001097          	auipc	ra,0x1
     3fe:	ea8080e7          	jalr	-344(ra) # 12a2 <chdir>
     402:	ed21                	bnez	a0,45a <go+0x3e2>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     404:	855a                	mv	a0,s6
     406:	00001097          	auipc	ra,0x1
     40a:	e5c080e7          	jalr	-420(ra) # 1262 <kill>
      wait(0);
     40e:	4501                	li	a0,0
     410:	00001097          	auipc	ra,0x1
     414:	e2a080e7          	jalr	-470(ra) # 123a <wait>
     418:	b329                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     41a:	20200593          	li	a1,514
     41e:	00001517          	auipc	a0,0x1
     422:	41250513          	addi	a0,a0,1042 # 1830 <malloc+0x1c6>
     426:	00001097          	auipc	ra,0x1
     42a:	e4c080e7          	jalr	-436(ra) # 1272 <open>
     42e:	00001097          	auipc	ra,0x1
     432:	e2c080e7          	jalr	-468(ra) # 125a <close>
        exit(0);
     436:	4501                	li	a0,0
     438:	00001097          	auipc	ra,0x1
     43c:	dfa080e7          	jalr	-518(ra) # 1232 <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	41050513          	addi	a0,a0,1040 # 1850 <malloc+0x1e6>
     448:	00001097          	auipc	ra,0x1
     44c:	16a080e7          	jalr	362(ra) # 15b2 <printf>
        exit(1);
     450:	4505                	li	a0,1
     452:	00001097          	auipc	ra,0x1
     456:	de0080e7          	jalr	-544(ra) # 1232 <exit>
        printf("grind: chdir failed\n");
     45a:	00001517          	auipc	a0,0x1
     45e:	41e50513          	addi	a0,a0,1054 # 1878 <malloc+0x20e>
     462:	00001097          	auipc	ra,0x1
     466:	150080e7          	jalr	336(ra) # 15b2 <printf>
        exit(1);
     46a:	4505                	li	a0,1
     46c:	00001097          	auipc	ra,0x1
     470:	dc6080e7          	jalr	-570(ra) # 1232 <exit>
    } else if(what == 18){
      int pid = fork();
     474:	00001097          	auipc	ra,0x1
     478:	db6080e7          	jalr	-586(ra) # 122a <fork>
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
     488:	db6080e7          	jalr	-586(ra) # 123a <wait>
     48c:	b959                	j	122 <go+0xaa>
        kill(getpid());
     48e:	00001097          	auipc	ra,0x1
     492:	e24080e7          	jalr	-476(ra) # 12b2 <getpid>
     496:	00001097          	auipc	ra,0x1
     49a:	dcc080e7          	jalr	-564(ra) # 1262 <kill>
        exit(0);
     49e:	4501                	li	a0,0
     4a0:	00001097          	auipc	ra,0x1
     4a4:	d92080e7          	jalr	-622(ra) # 1232 <exit>
        printf("grind: fork failed\n");
     4a8:	00001517          	auipc	a0,0x1
     4ac:	3a850513          	addi	a0,a0,936 # 1850 <malloc+0x1e6>
     4b0:	00001097          	auipc	ra,0x1
     4b4:	102080e7          	jalr	258(ra) # 15b2 <printf>
        exit(1);
     4b8:	4505                	li	a0,1
     4ba:	00001097          	auipc	ra,0x1
     4be:	d78080e7          	jalr	-648(ra) # 1232 <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     4c2:	fa840513          	addi	a0,s0,-88
     4c6:	00001097          	auipc	ra,0x1
     4ca:	d7c080e7          	jalr	-644(ra) # 1242 <pipe>
     4ce:	02054b63          	bltz	a0,504 <go+0x48c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     4d2:	00001097          	auipc	ra,0x1
     4d6:	d58080e7          	jalr	-680(ra) # 122a <fork>
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
     4e8:	d76080e7          	jalr	-650(ra) # 125a <close>
      close(fds[1]);
     4ec:	fac42503          	lw	a0,-84(s0)
     4f0:	00001097          	auipc	ra,0x1
     4f4:	d6a080e7          	jalr	-662(ra) # 125a <close>
      wait(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	d40080e7          	jalr	-704(ra) # 123a <wait>
     502:	b105                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     504:	00001517          	auipc	a0,0x1
     508:	38c50513          	addi	a0,a0,908 # 1890 <malloc+0x226>
     50c:	00001097          	auipc	ra,0x1
     510:	0a6080e7          	jalr	166(ra) # 15b2 <printf>
        exit(1);
     514:	4505                	li	a0,1
     516:	00001097          	auipc	ra,0x1
     51a:	d1c080e7          	jalr	-740(ra) # 1232 <exit>
        fork();
     51e:	00001097          	auipc	ra,0x1
     522:	d0c080e7          	jalr	-756(ra) # 122a <fork>
        fork();
     526:	00001097          	auipc	ra,0x1
     52a:	d04080e7          	jalr	-764(ra) # 122a <fork>
        if(write(fds[1], "x", 1) != 1)
     52e:	4605                	li	a2,1
     530:	00001597          	auipc	a1,0x1
     534:	37858593          	addi	a1,a1,888 # 18a8 <malloc+0x23e>
     538:	fac42503          	lw	a0,-84(s0)
     53c:	00001097          	auipc	ra,0x1
     540:	d16080e7          	jalr	-746(ra) # 1252 <write>
     544:	4785                	li	a5,1
     546:	02f51363          	bne	a0,a5,56c <go+0x4f4>
        if(read(fds[0], &c, 1) != 1)
     54a:	4605                	li	a2,1
     54c:	fa040593          	addi	a1,s0,-96
     550:	fa842503          	lw	a0,-88(s0)
     554:	00001097          	auipc	ra,0x1
     558:	cf6080e7          	jalr	-778(ra) # 124a <read>
     55c:	4785                	li	a5,1
     55e:	02f51063          	bne	a0,a5,57e <go+0x506>
        exit(0);
     562:	4501                	li	a0,0
     564:	00001097          	auipc	ra,0x1
     568:	cce080e7          	jalr	-818(ra) # 1232 <exit>
          printf("grind: pipe write failed\n");
     56c:	00001517          	auipc	a0,0x1
     570:	34450513          	addi	a0,a0,836 # 18b0 <malloc+0x246>
     574:	00001097          	auipc	ra,0x1
     578:	03e080e7          	jalr	62(ra) # 15b2 <printf>
     57c:	b7f9                	j	54a <go+0x4d2>
          printf("grind: pipe read failed\n");
     57e:	00001517          	auipc	a0,0x1
     582:	35250513          	addi	a0,a0,850 # 18d0 <malloc+0x266>
     586:	00001097          	auipc	ra,0x1
     58a:	02c080e7          	jalr	44(ra) # 15b2 <printf>
     58e:	bfd1                	j	562 <go+0x4ea>
        printf("grind: fork failed\n");
     590:	00001517          	auipc	a0,0x1
     594:	2c050513          	addi	a0,a0,704 # 1850 <malloc+0x1e6>
     598:	00001097          	auipc	ra,0x1
     59c:	01a080e7          	jalr	26(ra) # 15b2 <printf>
        exit(1);
     5a0:	4505                	li	a0,1
     5a2:	00001097          	auipc	ra,0x1
     5a6:	c90080e7          	jalr	-880(ra) # 1232 <exit>
    } else if(what == 20){
      int pid = fork();
     5aa:	00001097          	auipc	ra,0x1
     5ae:	c80080e7          	jalr	-896(ra) # 122a <fork>
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
     5be:	c80080e7          	jalr	-896(ra) # 123a <wait>
     5c2:	b685                	j	122 <go+0xaa>
        unlink("a");
     5c4:	00001517          	auipc	a0,0x1
     5c8:	26c50513          	addi	a0,a0,620 # 1830 <malloc+0x1c6>
     5cc:	00001097          	auipc	ra,0x1
     5d0:	cb6080e7          	jalr	-842(ra) # 1282 <unlink>
        mkdir("a");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	25c50513          	addi	a0,a0,604 # 1830 <malloc+0x1c6>
     5dc:	00001097          	auipc	ra,0x1
     5e0:	cbe080e7          	jalr	-834(ra) # 129a <mkdir>
        chdir("a");
     5e4:	00001517          	auipc	a0,0x1
     5e8:	24c50513          	addi	a0,a0,588 # 1830 <malloc+0x1c6>
     5ec:	00001097          	auipc	ra,0x1
     5f0:	cb6080e7          	jalr	-842(ra) # 12a2 <chdir>
        unlink("../a");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	1a450513          	addi	a0,a0,420 # 1798 <malloc+0x12e>
     5fc:	00001097          	auipc	ra,0x1
     600:	c86080e7          	jalr	-890(ra) # 1282 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     604:	20200593          	li	a1,514
     608:	00001517          	auipc	a0,0x1
     60c:	2a050513          	addi	a0,a0,672 # 18a8 <malloc+0x23e>
     610:	00001097          	auipc	ra,0x1
     614:	c62080e7          	jalr	-926(ra) # 1272 <open>
        unlink("x");
     618:	00001517          	auipc	a0,0x1
     61c:	29050513          	addi	a0,a0,656 # 18a8 <malloc+0x23e>
     620:	00001097          	auipc	ra,0x1
     624:	c62080e7          	jalr	-926(ra) # 1282 <unlink>
        exit(0);
     628:	4501                	li	a0,0
     62a:	00001097          	auipc	ra,0x1
     62e:	c08080e7          	jalr	-1016(ra) # 1232 <exit>
        printf("grind: fork failed\n");
     632:	00001517          	auipc	a0,0x1
     636:	21e50513          	addi	a0,a0,542 # 1850 <malloc+0x1e6>
     63a:	00001097          	auipc	ra,0x1
     63e:	f78080e7          	jalr	-136(ra) # 15b2 <printf>
        exit(1);
     642:	4505                	li	a0,1
     644:	00001097          	auipc	ra,0x1
     648:	bee080e7          	jalr	-1042(ra) # 1232 <exit>
    } else if(what == 21){
      unlink("c");
     64c:	00001517          	auipc	a0,0x1
     650:	2a450513          	addi	a0,a0,676 # 18f0 <malloc+0x286>
     654:	00001097          	auipc	ra,0x1
     658:	c2e080e7          	jalr	-978(ra) # 1282 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     65c:	20200593          	li	a1,514
     660:	00001517          	auipc	a0,0x1
     664:	29050513          	addi	a0,a0,656 # 18f0 <malloc+0x286>
     668:	00001097          	auipc	ra,0x1
     66c:	c0a080e7          	jalr	-1014(ra) # 1272 <open>
     670:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     672:	04054f63          	bltz	a0,6d0 <go+0x658>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     676:	4605                	li	a2,1
     678:	00001597          	auipc	a1,0x1
     67c:	23058593          	addi	a1,a1,560 # 18a8 <malloc+0x23e>
     680:	00001097          	auipc	ra,0x1
     684:	bd2080e7          	jalr	-1070(ra) # 1252 <write>
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
     698:	bf6080e7          	jalr	-1034(ra) # 128a <fstat>
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
     6ba:	ba4080e7          	jalr	-1116(ra) # 125a <close>
      unlink("c");
     6be:	00001517          	auipc	a0,0x1
     6c2:	23250513          	addi	a0,a0,562 # 18f0 <malloc+0x286>
     6c6:	00001097          	auipc	ra,0x1
     6ca:	bbc080e7          	jalr	-1092(ra) # 1282 <unlink>
     6ce:	bc91                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     6d0:	00001517          	auipc	a0,0x1
     6d4:	22850513          	addi	a0,a0,552 # 18f8 <malloc+0x28e>
     6d8:	00001097          	auipc	ra,0x1
     6dc:	eda080e7          	jalr	-294(ra) # 15b2 <printf>
        exit(1);
     6e0:	4505                	li	a0,1
     6e2:	00001097          	auipc	ra,0x1
     6e6:	b50080e7          	jalr	-1200(ra) # 1232 <exit>
        printf("grind: write c failed\n");
     6ea:	00001517          	auipc	a0,0x1
     6ee:	22650513          	addi	a0,a0,550 # 1910 <malloc+0x2a6>
     6f2:	00001097          	auipc	ra,0x1
     6f6:	ec0080e7          	jalr	-320(ra) # 15b2 <printf>
        exit(1);
     6fa:	4505                	li	a0,1
     6fc:	00001097          	auipc	ra,0x1
     700:	b36080e7          	jalr	-1226(ra) # 1232 <exit>
        printf("grind: fstat failed\n");
     704:	00001517          	auipc	a0,0x1
     708:	22450513          	addi	a0,a0,548 # 1928 <malloc+0x2be>
     70c:	00001097          	auipc	ra,0x1
     710:	ea6080e7          	jalr	-346(ra) # 15b2 <printf>
        exit(1);
     714:	4505                	li	a0,1
     716:	00001097          	auipc	ra,0x1
     71a:	b1c080e7          	jalr	-1252(ra) # 1232 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     71e:	2581                	sext.w	a1,a1
     720:	00001517          	auipc	a0,0x1
     724:	22050513          	addi	a0,a0,544 # 1940 <malloc+0x2d6>
     728:	00001097          	auipc	ra,0x1
     72c:	e8a080e7          	jalr	-374(ra) # 15b2 <printf>
        exit(1);
     730:	4505                	li	a0,1
     732:	00001097          	auipc	ra,0x1
     736:	b00080e7          	jalr	-1280(ra) # 1232 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     73a:	00001517          	auipc	a0,0x1
     73e:	22e50513          	addi	a0,a0,558 # 1968 <malloc+0x2fe>
     742:	00001097          	auipc	ra,0x1
     746:	e70080e7          	jalr	-400(ra) # 15b2 <printf>
        exit(1);
     74a:	4505                	li	a0,1
     74c:	00001097          	auipc	ra,0x1
     750:	ae6080e7          	jalr	-1306(ra) # 1232 <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     754:	f9840513          	addi	a0,s0,-104
     758:	00001097          	auipc	ra,0x1
     75c:	aea080e7          	jalr	-1302(ra) # 1242 <pipe>
     760:	10054063          	bltz	a0,860 <go+0x7e8>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     764:	fa040513          	addi	a0,s0,-96
     768:	00001097          	auipc	ra,0x1
     76c:	ada080e7          	jalr	-1318(ra) # 1242 <pipe>
     770:	10054663          	bltz	a0,87c <go+0x804>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     774:	00001097          	auipc	ra,0x1
     778:	ab6080e7          	jalr	-1354(ra) # 122a <fork>
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
     788:	aa6080e7          	jalr	-1370(ra) # 122a <fork>
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
     79c:	ac2080e7          	jalr	-1342(ra) # 125a <close>
      close(aa[1]);
     7a0:	f9c42503          	lw	a0,-100(s0)
     7a4:	00001097          	auipc	ra,0x1
     7a8:	ab6080e7          	jalr	-1354(ra) # 125a <close>
      close(bb[1]);
     7ac:	fa442503          	lw	a0,-92(s0)
     7b0:	00001097          	auipc	ra,0x1
     7b4:	aaa080e7          	jalr	-1366(ra) # 125a <close>
      char buf[4] = { 0, 0, 0, 0 };
     7b8:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     7bc:	4605                	li	a2,1
     7be:	f9040593          	addi	a1,s0,-112
     7c2:	fa042503          	lw	a0,-96(s0)
     7c6:	00001097          	auipc	ra,0x1
     7ca:	a84080e7          	jalr	-1404(ra) # 124a <read>
      read(bb[0], buf+1, 1);
     7ce:	4605                	li	a2,1
     7d0:	f9140593          	addi	a1,s0,-111
     7d4:	fa042503          	lw	a0,-96(s0)
     7d8:	00001097          	auipc	ra,0x1
     7dc:	a72080e7          	jalr	-1422(ra) # 124a <read>
      read(bb[0], buf+2, 1);
     7e0:	4605                	li	a2,1
     7e2:	f9240593          	addi	a1,s0,-110
     7e6:	fa042503          	lw	a0,-96(s0)
     7ea:	00001097          	auipc	ra,0x1
     7ee:	a60080e7          	jalr	-1440(ra) # 124a <read>
      close(bb[0]);
     7f2:	fa042503          	lw	a0,-96(s0)
     7f6:	00001097          	auipc	ra,0x1
     7fa:	a64080e7          	jalr	-1436(ra) # 125a <close>
      int st1, st2;
      wait(&st1);
     7fe:	f9440513          	addi	a0,s0,-108
     802:	00001097          	auipc	ra,0x1
     806:	a38080e7          	jalr	-1480(ra) # 123a <wait>
      wait(&st2);
     80a:	fa840513          	addi	a0,s0,-88
     80e:	00001097          	auipc	ra,0x1
     812:	a2c080e7          	jalr	-1492(ra) # 123a <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     816:	f9442783          	lw	a5,-108(s0)
     81a:	fa842703          	lw	a4,-88(s0)
     81e:	8fd9                	or	a5,a5,a4
     820:	ef89                	bnez	a5,83a <go+0x7c2>
     822:	00001597          	auipc	a1,0x1
     826:	1e658593          	addi	a1,a1,486 # 1a08 <malloc+0x39e>
     82a:	f9040513          	addi	a0,s0,-112
     82e:	00000097          	auipc	ra,0x0
     832:	7b4080e7          	jalr	1972(ra) # fe2 <strcmp>
     836:	8e0506e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     83a:	f9040693          	addi	a3,s0,-112
     83e:	fa842603          	lw	a2,-88(s0)
     842:	f9442583          	lw	a1,-108(s0)
     846:	00001517          	auipc	a0,0x1
     84a:	1ca50513          	addi	a0,a0,458 # 1a10 <malloc+0x3a6>
     84e:	00001097          	auipc	ra,0x1
     852:	d64080e7          	jalr	-668(ra) # 15b2 <printf>
        exit(1);
     856:	4505                	li	a0,1
     858:	00001097          	auipc	ra,0x1
     85c:	9da080e7          	jalr	-1574(ra) # 1232 <exit>
        fprintf(2, "grind: pipe failed\n");
     860:	00001597          	auipc	a1,0x1
     864:	03058593          	addi	a1,a1,48 # 1890 <malloc+0x226>
     868:	4509                	li	a0,2
     86a:	00001097          	auipc	ra,0x1
     86e:	d1a080e7          	jalr	-742(ra) # 1584 <fprintf>
        exit(1);
     872:	4505                	li	a0,1
     874:	00001097          	auipc	ra,0x1
     878:	9be080e7          	jalr	-1602(ra) # 1232 <exit>
        fprintf(2, "grind: pipe failed\n");
     87c:	00001597          	auipc	a1,0x1
     880:	01458593          	addi	a1,a1,20 # 1890 <malloc+0x226>
     884:	4509                	li	a0,2
     886:	00001097          	auipc	ra,0x1
     88a:	cfe080e7          	jalr	-770(ra) # 1584 <fprintf>
        exit(1);
     88e:	4505                	li	a0,1
     890:	00001097          	auipc	ra,0x1
     894:	9a2080e7          	jalr	-1630(ra) # 1232 <exit>
        close(bb[0]);
     898:	fa042503          	lw	a0,-96(s0)
     89c:	00001097          	auipc	ra,0x1
     8a0:	9be080e7          	jalr	-1602(ra) # 125a <close>
        close(bb[1]);
     8a4:	fa442503          	lw	a0,-92(s0)
     8a8:	00001097          	auipc	ra,0x1
     8ac:	9b2080e7          	jalr	-1614(ra) # 125a <close>
        close(aa[0]);
     8b0:	f9842503          	lw	a0,-104(s0)
     8b4:	00001097          	auipc	ra,0x1
     8b8:	9a6080e7          	jalr	-1626(ra) # 125a <close>
        close(1);
     8bc:	4505                	li	a0,1
     8be:	00001097          	auipc	ra,0x1
     8c2:	99c080e7          	jalr	-1636(ra) # 125a <close>
        if(dup(aa[1]) != 1){
     8c6:	f9c42503          	lw	a0,-100(s0)
     8ca:	00001097          	auipc	ra,0x1
     8ce:	9e0080e7          	jalr	-1568(ra) # 12aa <dup>
     8d2:	4785                	li	a5,1
     8d4:	02f50063          	beq	a0,a5,8f4 <go+0x87c>
          fprintf(2, "grind: dup failed\n");
     8d8:	00001597          	auipc	a1,0x1
     8dc:	0b858593          	addi	a1,a1,184 # 1990 <malloc+0x326>
     8e0:	4509                	li	a0,2
     8e2:	00001097          	auipc	ra,0x1
     8e6:	ca2080e7          	jalr	-862(ra) # 1584 <fprintf>
          exit(1);
     8ea:	4505                	li	a0,1
     8ec:	00001097          	auipc	ra,0x1
     8f0:	946080e7          	jalr	-1722(ra) # 1232 <exit>
        close(aa[1]);
     8f4:	f9c42503          	lw	a0,-100(s0)
     8f8:	00001097          	auipc	ra,0x1
     8fc:	962080e7          	jalr	-1694(ra) # 125a <close>
        char *args[3] = { "echo", "hi", 0 };
     900:	00001797          	auipc	a5,0x1
     904:	0a878793          	addi	a5,a5,168 # 19a8 <malloc+0x33e>
     908:	faf43423          	sd	a5,-88(s0)
     90c:	00001797          	auipc	a5,0x1
     910:	0a478793          	addi	a5,a5,164 # 19b0 <malloc+0x346>
     914:	faf43823          	sd	a5,-80(s0)
     918:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     91c:	fa840593          	addi	a1,s0,-88
     920:	00001517          	auipc	a0,0x1
     924:	09850513          	addi	a0,a0,152 # 19b8 <malloc+0x34e>
     928:	00001097          	auipc	ra,0x1
     92c:	942080e7          	jalr	-1726(ra) # 126a <exec>
        fprintf(2, "grind: echo: not found\n");
     930:	00001597          	auipc	a1,0x1
     934:	09858593          	addi	a1,a1,152 # 19c8 <malloc+0x35e>
     938:	4509                	li	a0,2
     93a:	00001097          	auipc	ra,0x1
     93e:	c4a080e7          	jalr	-950(ra) # 1584 <fprintf>
        exit(2);
     942:	4509                	li	a0,2
     944:	00001097          	auipc	ra,0x1
     948:	8ee080e7          	jalr	-1810(ra) # 1232 <exit>
        fprintf(2, "grind: fork failed\n");
     94c:	00001597          	auipc	a1,0x1
     950:	f0458593          	addi	a1,a1,-252 # 1850 <malloc+0x1e6>
     954:	4509                	li	a0,2
     956:	00001097          	auipc	ra,0x1
     95a:	c2e080e7          	jalr	-978(ra) # 1584 <fprintf>
        exit(3);
     95e:	450d                	li	a0,3
     960:	00001097          	auipc	ra,0x1
     964:	8d2080e7          	jalr	-1838(ra) # 1232 <exit>
        close(aa[1]);
     968:	f9c42503          	lw	a0,-100(s0)
     96c:	00001097          	auipc	ra,0x1
     970:	8ee080e7          	jalr	-1810(ra) # 125a <close>
        close(bb[0]);
     974:	fa042503          	lw	a0,-96(s0)
     978:	00001097          	auipc	ra,0x1
     97c:	8e2080e7          	jalr	-1822(ra) # 125a <close>
        close(0);
     980:	4501                	li	a0,0
     982:	00001097          	auipc	ra,0x1
     986:	8d8080e7          	jalr	-1832(ra) # 125a <close>
        if(dup(aa[0]) != 0){
     98a:	f9842503          	lw	a0,-104(s0)
     98e:	00001097          	auipc	ra,0x1
     992:	91c080e7          	jalr	-1764(ra) # 12aa <dup>
     996:	cd19                	beqz	a0,9b4 <go+0x93c>
          fprintf(2, "grind: dup failed\n");
     998:	00001597          	auipc	a1,0x1
     99c:	ff858593          	addi	a1,a1,-8 # 1990 <malloc+0x326>
     9a0:	4509                	li	a0,2
     9a2:	00001097          	auipc	ra,0x1
     9a6:	be2080e7          	jalr	-1054(ra) # 1584 <fprintf>
          exit(4);
     9aa:	4511                	li	a0,4
     9ac:	00001097          	auipc	ra,0x1
     9b0:	886080e7          	jalr	-1914(ra) # 1232 <exit>
        close(aa[0]);
     9b4:	f9842503          	lw	a0,-104(s0)
     9b8:	00001097          	auipc	ra,0x1
     9bc:	8a2080e7          	jalr	-1886(ra) # 125a <close>
        close(1);
     9c0:	4505                	li	a0,1
     9c2:	00001097          	auipc	ra,0x1
     9c6:	898080e7          	jalr	-1896(ra) # 125a <close>
        if(dup(bb[1]) != 1){
     9ca:	fa442503          	lw	a0,-92(s0)
     9ce:	00001097          	auipc	ra,0x1
     9d2:	8dc080e7          	jalr	-1828(ra) # 12aa <dup>
     9d6:	4785                	li	a5,1
     9d8:	02f50063          	beq	a0,a5,9f8 <go+0x980>
          fprintf(2, "grind: dup failed\n");
     9dc:	00001597          	auipc	a1,0x1
     9e0:	fb458593          	addi	a1,a1,-76 # 1990 <malloc+0x326>
     9e4:	4509                	li	a0,2
     9e6:	00001097          	auipc	ra,0x1
     9ea:	b9e080e7          	jalr	-1122(ra) # 1584 <fprintf>
          exit(5);
     9ee:	4515                	li	a0,5
     9f0:	00001097          	auipc	ra,0x1
     9f4:	842080e7          	jalr	-1982(ra) # 1232 <exit>
        close(bb[1]);
     9f8:	fa442503          	lw	a0,-92(s0)
     9fc:	00001097          	auipc	ra,0x1
     a00:	85e080e7          	jalr	-1954(ra) # 125a <close>
        char *args[2] = { "cat", 0 };
     a04:	00001797          	auipc	a5,0x1
     a08:	fdc78793          	addi	a5,a5,-36 # 19e0 <malloc+0x376>
     a0c:	faf43423          	sd	a5,-88(s0)
     a10:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a14:	fa840593          	addi	a1,s0,-88
     a18:	00001517          	auipc	a0,0x1
     a1c:	fd050513          	addi	a0,a0,-48 # 19e8 <malloc+0x37e>
     a20:	00001097          	auipc	ra,0x1
     a24:	84a080e7          	jalr	-1974(ra) # 126a <exec>
        fprintf(2, "grind: cat: not found\n");
     a28:	00001597          	auipc	a1,0x1
     a2c:	fc858593          	addi	a1,a1,-56 # 19f0 <malloc+0x386>
     a30:	4509                	li	a0,2
     a32:	00001097          	auipc	ra,0x1
     a36:	b52080e7          	jalr	-1198(ra) # 1584 <fprintf>
        exit(6);
     a3a:	4519                	li	a0,6
     a3c:	00000097          	auipc	ra,0x0
     a40:	7f6080e7          	jalr	2038(ra) # 1232 <exit>
        fprintf(2, "grind: fork failed\n");
     a44:	00001597          	auipc	a1,0x1
     a48:	e0c58593          	addi	a1,a1,-500 # 1850 <malloc+0x1e6>
     a4c:	4509                	li	a0,2
     a4e:	00001097          	auipc	ra,0x1
     a52:	b36080e7          	jalr	-1226(ra) # 1584 <fprintf>
        exit(7);
     a56:	451d                	li	a0,7
     a58:	00000097          	auipc	ra,0x0
     a5c:	7da080e7          	jalr	2010(ra) # 1232 <exit>

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
     a70:	dc450513          	addi	a0,a0,-572 # 1830 <malloc+0x1c6>
     a74:	00001097          	auipc	ra,0x1
     a78:	80e080e7          	jalr	-2034(ra) # 1282 <unlink>
  unlink("b");
     a7c:	00001517          	auipc	a0,0x1
     a80:	d6450513          	addi	a0,a0,-668 # 17e0 <malloc+0x176>
     a84:	00000097          	auipc	ra,0x0
     a88:	7fe080e7          	jalr	2046(ra) # 1282 <unlink>
  
  int pid1 = fork();
     a8c:	00000097          	auipc	ra,0x0
     a90:	79e080e7          	jalr	1950(ra) # 122a <fork>
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
     aba:	d9a50513          	addi	a0,a0,-614 # 1850 <malloc+0x1e6>
     abe:	00001097          	auipc	ra,0x1
     ac2:	af4080e7          	jalr	-1292(ra) # 15b2 <printf>
    exit(1);
     ac6:	4505                	li	a0,1
     ac8:	00000097          	auipc	ra,0x0
     acc:	76a080e7          	jalr	1898(ra) # 1232 <exit>
    exit(0);
  }

  int pid2 = fork();
     ad0:	00000097          	auipc	ra,0x0
     ad4:	75a080e7          	jalr	1882(ra) # 122a <fork>
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
     aec:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0xc1>
     af0:	8fb9                	xor	a5,a5,a4
     af2:	e29c                	sd	a5,0(a3)
    go(1);
     af4:	4505                	li	a0,1
     af6:	fffff097          	auipc	ra,0xfffff
     afa:	582080e7          	jalr	1410(ra) # 78 <go>
    printf("grind: fork failed\n");
     afe:	00001517          	auipc	a0,0x1
     b02:	d5250513          	addi	a0,a0,-686 # 1850 <malloc+0x1e6>
     b06:	00001097          	auipc	ra,0x1
     b0a:	aac080e7          	jalr	-1364(ra) # 15b2 <printf>
    exit(1);
     b0e:	4505                	li	a0,1
     b10:	00000097          	auipc	ra,0x0
     b14:	722080e7          	jalr	1826(ra) # 1232 <exit>
    exit(0);
  }

  int st1 = -1;
     b18:	57fd                	li	a5,-1
     b1a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b1e:	fdc40513          	addi	a0,s0,-36
     b22:	00000097          	auipc	ra,0x0
     b26:	718080e7          	jalr	1816(ra) # 123a <wait>
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
     b3e:	700080e7          	jalr	1792(ra) # 123a <wait>

  exit(0);
     b42:	4501                	li	a0,0
     b44:	00000097          	auipc	ra,0x0
     b48:	6ee080e7          	jalr	1774(ra) # 1232 <exit>
    kill(pid1);
     b4c:	8526                	mv	a0,s1
     b4e:	00000097          	auipc	ra,0x0
     b52:	714080e7          	jalr	1812(ra) # 1262 <kill>
    kill(pid2);
     b56:	854a                	mv	a0,s2
     b58:	00000097          	auipc	ra,0x0
     b5c:	70a080e7          	jalr	1802(ra) # 1262 <kill>
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
     b84:	742080e7          	jalr	1858(ra) # 12c2 <sleep>
    rand_next += 1;
     b88:	609c                	ld	a5,0(s1)
     b8a:	0785                	addi	a5,a5,1
     b8c:	e09c                	sd	a5,0(s1)
    int pid = fork();
     b8e:	00000097          	auipc	ra,0x0
     b92:	69c080e7          	jalr	1692(ra) # 122a <fork>
    if(pid == 0){
     b96:	d165                	beqz	a0,b76 <main+0x14>
    if(pid > 0){
     b98:	fea053e3          	blez	a0,b7e <main+0x1c>
      wait(0);
     b9c:	4501                	li	a0,0
     b9e:	00000097          	auipc	ra,0x0
     ba2:	69c080e7          	jalr	1692(ra) # 123a <wait>
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
     bdc:	340080e7          	jalr	832(ra) # f18 <twhoami>
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
     c28:	e7450513          	addi	a0,a0,-396 # 1a98 <malloc+0x42e>
     c2c:	00001097          	auipc	ra,0x1
     c30:	986080e7          	jalr	-1658(ra) # 15b2 <printf>
        exit(-1);
     c34:	557d                	li	a0,-1
     c36:	00000097          	auipc	ra,0x0
     c3a:	5fc080e7          	jalr	1532(ra) # 1232 <exit>
    {
        // give up the cpu for other threads
        tyield();
     c3e:	00000097          	auipc	ra,0x0
     c42:	258080e7          	jalr	600(ra) # e96 <tyield>
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
     c5c:	2c0080e7          	jalr	704(ra) # f18 <twhoami>
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
     ca0:	1fa080e7          	jalr	506(ra) # e96 <tyield>
}
     ca4:	60e2                	ld	ra,24(sp)
     ca6:	6442                	ld	s0,16(sp)
     ca8:	64a2                	ld	s1,8(sp)
     caa:	6105                	addi	sp,sp,32
     cac:	8082                	ret
        printf("releasing lock we are not holding");
     cae:	00001517          	auipc	a0,0x1
     cb2:	e1250513          	addi	a0,a0,-494 # 1ac0 <malloc+0x456>
     cb6:	00001097          	auipc	ra,0x1
     cba:	8fc080e7          	jalr	-1796(ra) # 15b2 <printf>
        exit(-1);
     cbe:	557d                	li	a0,-1
     cc0:	00000097          	auipc	ra,0x0
     cc4:	572080e7          	jalr	1394(ra) # 1232 <exit>

0000000000000cc8 <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
     cc8:	1141                	addi	sp,sp,-16
     cca:	e406                	sd	ra,8(sp)
     ccc:	e022                	sd	s0,0(sp)
     cce:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     cd0:	09800513          	li	a0,152
     cd4:	00001097          	auipc	ra,0x1
     cd8:	996080e7          	jalr	-1642(ra) # 166a <malloc>

    main_thread->tid = next_tid;
     cdc:	00001797          	auipc	a5,0x1
     ce0:	32c78793          	addi	a5,a5,812 # 2008 <next_tid>
     ce4:	4398                	lw	a4,0(a5)
     ce6:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
     cea:	4398                	lw	a4,0(a5)
     cec:	2705                	addiw	a4,a4,1
     cee:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
     cf0:	4791                	li	a5,4
     cf2:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
     cf4:	00001797          	auipc	a5,0x1
     cf8:	30a7be23          	sd	a0,796(a5) # 2010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
     cfc:	00001797          	auipc	a5,0x1
     d00:	70c78793          	addi	a5,a5,1804 # 2408 <threads>
     d04:	00001717          	auipc	a4,0x1
     d08:	78470713          	addi	a4,a4,1924 # 2488 <base>
        threads[i] = NULL;
     d0c:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
     d10:	07a1                	addi	a5,a5,8
     d12:	fee79de3          	bne	a5,a4,d0c <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
     d16:	00001797          	auipc	a5,0x1
     d1a:	6ea7b923          	sd	a0,1778(a5) # 2408 <threads>
}
     d1e:	60a2                	ld	ra,8(sp)
     d20:	6402                	ld	s0,0(sp)
     d22:	0141                	addi	sp,sp,16
     d24:	8082                	ret

0000000000000d26 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
     d26:	00001517          	auipc	a0,0x1
     d2a:	2ea53503          	ld	a0,746(a0) # 2010 <current_thread>
     d2e:	00001717          	auipc	a4,0x1
     d32:	6da70713          	addi	a4,a4,1754 # 2408 <threads>
    for (int i = 0; i < 16; i++) {
     d36:	4781                	li	a5,0
     d38:	4641                	li	a2,16
        if (threads[i] == current_thread) {
     d3a:	6314                	ld	a3,0(a4)
     d3c:	00a68763          	beq	a3,a0,d4a <tsched+0x24>
    for (int i = 0; i < 16; i++) {
     d40:	2785                	addiw	a5,a5,1
     d42:	0721                	addi	a4,a4,8
     d44:	fec79be3          	bne	a5,a2,d3a <tsched+0x14>
    int current_index = 0;
     d48:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
     d4a:	0017869b          	addiw	a3,a5,1
     d4e:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     d52:	00001817          	auipc	a6,0x1
     d56:	6b680813          	addi	a6,a6,1718 # 2408 <threads>
     d5a:	488d                	li	a7,3
     d5c:	a021                	j	d64 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
     d5e:	2685                	addiw	a3,a3,1
     d60:	04c68363          	beq	a3,a2,da6 <tsched+0x80>
        int next_index = (current_index + i) % 16;
     d64:	41f6d71b          	sraiw	a4,a3,0x1f
     d68:	01c7571b          	srliw	a4,a4,0x1c
     d6c:	00d707bb          	addw	a5,a4,a3
     d70:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     d72:	9f99                	subw	a5,a5,a4
     d74:	078e                	slli	a5,a5,0x3
     d76:	97c2                	add	a5,a5,a6
     d78:	638c                	ld	a1,0(a5)
     d7a:	d1f5                	beqz	a1,d5e <tsched+0x38>
     d7c:	5dbc                	lw	a5,120(a1)
     d7e:	ff1790e3          	bne	a5,a7,d5e <tsched+0x38>
{
     d82:	1141                	addi	sp,sp,-16
     d84:	e406                	sd	ra,8(sp)
     d86:	e022                	sd	s0,0(sp)
     d88:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
     d8a:	00001797          	auipc	a5,0x1
     d8e:	28b7b323          	sd	a1,646(a5) # 2010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
     d92:	05a1                	addi	a1,a1,8
     d94:	0521                	addi	a0,a0,8
     d96:	00000097          	auipc	ra,0x0
     d9a:	19a080e7          	jalr	410(ra) # f30 <tswtch>
        //printf("Thread switch complete\n");
    }
}
     d9e:	60a2                	ld	ra,8(sp)
     da0:	6402                	ld	s0,0(sp)
     da2:	0141                	addi	sp,sp,16
     da4:	8082                	ret
     da6:	8082                	ret

0000000000000da8 <thread_wrapper>:
{
     da8:	1101                	addi	sp,sp,-32
     daa:	ec06                	sd	ra,24(sp)
     dac:	e822                	sd	s0,16(sp)
     dae:	e426                	sd	s1,8(sp)
     db0:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
     db2:	00001497          	auipc	s1,0x1
     db6:	25e48493          	addi	s1,s1,606 # 2010 <current_thread>
     dba:	609c                	ld	a5,0(s1)
     dbc:	6b9c                	ld	a5,16(a5)
    func(arg);
     dbe:	6398                	ld	a4,0(a5)
     dc0:	6788                	ld	a0,8(a5)
     dc2:	9702                	jalr	a4
    current_thread->state = EXITED;
     dc4:	609c                	ld	a5,0(s1)
     dc6:	4719                	li	a4,6
     dc8:	dfb8                	sw	a4,120(a5)
    tsched();
     dca:	00000097          	auipc	ra,0x0
     dce:	f5c080e7          	jalr	-164(ra) # d26 <tsched>
}
     dd2:	60e2                	ld	ra,24(sp)
     dd4:	6442                	ld	s0,16(sp)
     dd6:	64a2                	ld	s1,8(sp)
     dd8:	6105                	addi	sp,sp,32
     dda:	8082                	ret

0000000000000ddc <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     ddc:	7179                	addi	sp,sp,-48
     dde:	f406                	sd	ra,40(sp)
     de0:	f022                	sd	s0,32(sp)
     de2:	ec26                	sd	s1,24(sp)
     de4:	e84a                	sd	s2,16(sp)
     de6:	e44e                	sd	s3,8(sp)
     de8:	1800                	addi	s0,sp,48
     dea:	84aa                	mv	s1,a0
     dec:	8932                	mv	s2,a2
     dee:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     df0:	09800513          	li	a0,152
     df4:	00001097          	auipc	ra,0x1
     df8:	876080e7          	jalr	-1930(ra) # 166a <malloc>
     dfc:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     dfe:	478d                	li	a5,3
     e00:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     e02:	609c                	ld	a5,0(s1)
     e04:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
     e08:	609c                	ld	a5,0(s1)
     e0a:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
     e0e:	6098                	ld	a4,0(s1)
     e10:	00001797          	auipc	a5,0x1
     e14:	1f878793          	addi	a5,a5,504 # 2008 <next_tid>
     e18:	4394                	lw	a3,0(a5)
     e1a:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
     e1e:	4398                	lw	a4,0(a5)
     e20:	2705                	addiw	a4,a4,1
     e22:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
     e24:	6505                	lui	a0,0x1
     e26:	00001097          	auipc	ra,0x1
     e2a:	844080e7          	jalr	-1980(ra) # 166a <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
     e2e:	6785                	lui	a5,0x1
     e30:	00a78733          	add	a4,a5,a0
     e34:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
     e38:	17c1                	addi	a5,a5,-16 # ff0 <strcmp+0xe>
     e3a:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
     e3c:	01253023          	sd	s2,0(a0) # 1000 <strcmp+0x1e>

    (*thread)->tcontext.sp = stack_top;
     e40:	609c                	ld	a5,0(s1)
     e42:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
     e44:	609c                	ld	a5,0(s1)
     e46:	00000717          	auipc	a4,0x0
     e4a:	f6270713          	addi	a4,a4,-158 # da8 <thread_wrapper>
     e4e:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
     e50:	00001717          	auipc	a4,0x1
     e54:	5b870713          	addi	a4,a4,1464 # 2408 <threads>
     e58:	4781                	li	a5,0
     e5a:	4641                	li	a2,16
        if (threads[i] == NULL) {
     e5c:	6314                	ld	a3,0(a4)
     e5e:	c29d                	beqz	a3,e84 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
     e60:	2785                	addiw	a5,a5,1
     e62:	0721                	addi	a4,a4,8
     e64:	fec79ce3          	bne	a5,a2,e5c <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
     e68:	6088                	ld	a0,0(s1)
     e6a:	00000097          	auipc	ra,0x0
     e6e:	77e080e7          	jalr	1918(ra) # 15e8 <free>
        *thread = NULL;
     e72:	0004b023          	sd	zero,0(s1)
        return;
    }
}
     e76:	70a2                	ld	ra,40(sp)
     e78:	7402                	ld	s0,32(sp)
     e7a:	64e2                	ld	s1,24(sp)
     e7c:	6942                	ld	s2,16(sp)
     e7e:	69a2                	ld	s3,8(sp)
     e80:	6145                	addi	sp,sp,48
     e82:	8082                	ret
            threads[i] = *thread;
     e84:	6094                	ld	a3,0(s1)
     e86:	078e                	slli	a5,a5,0x3
     e88:	00001717          	auipc	a4,0x1
     e8c:	58070713          	addi	a4,a4,1408 # 2408 <threads>
     e90:	97ba                	add	a5,a5,a4
     e92:	e394                	sd	a3,0(a5)
    if (!thread_added) {
     e94:	b7cd                	j	e76 <tcreate+0x9a>

0000000000000e96 <tyield>:
    return 0;
}


void tyield()
{
     e96:	1141                	addi	sp,sp,-16
     e98:	e406                	sd	ra,8(sp)
     e9a:	e022                	sd	s0,0(sp)
     e9c:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
     e9e:	00001797          	auipc	a5,0x1
     ea2:	1727b783          	ld	a5,370(a5) # 2010 <current_thread>
     ea6:	470d                	li	a4,3
     ea8:	dfb8                	sw	a4,120(a5)
    tsched();
     eaa:	00000097          	auipc	ra,0x0
     eae:	e7c080e7          	jalr	-388(ra) # d26 <tsched>
}
     eb2:	60a2                	ld	ra,8(sp)
     eb4:	6402                	ld	s0,0(sp)
     eb6:	0141                	addi	sp,sp,16
     eb8:	8082                	ret

0000000000000eba <tjoin>:
{
     eba:	1101                	addi	sp,sp,-32
     ebc:	ec06                	sd	ra,24(sp)
     ebe:	e822                	sd	s0,16(sp)
     ec0:	e426                	sd	s1,8(sp)
     ec2:	e04a                	sd	s2,0(sp)
     ec4:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
     ec6:	00001797          	auipc	a5,0x1
     eca:	54278793          	addi	a5,a5,1346 # 2408 <threads>
     ece:	00001697          	auipc	a3,0x1
     ed2:	5ba68693          	addi	a3,a3,1466 # 2488 <base>
     ed6:	a021                	j	ede <tjoin+0x24>
     ed8:	07a1                	addi	a5,a5,8
     eda:	02d78b63          	beq	a5,a3,f10 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
     ede:	6384                	ld	s1,0(a5)
     ee0:	dce5                	beqz	s1,ed8 <tjoin+0x1e>
     ee2:	0004c703          	lbu	a4,0(s1)
     ee6:	fea719e3          	bne	a4,a0,ed8 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
     eea:	5cb8                	lw	a4,120(s1)
     eec:	4799                	li	a5,6
     eee:	4919                	li	s2,6
     ef0:	02f70263          	beq	a4,a5,f14 <tjoin+0x5a>
        tyield();
     ef4:	00000097          	auipc	ra,0x0
     ef8:	fa2080e7          	jalr	-94(ra) # e96 <tyield>
    while (target_thread->state != EXITED) {
     efc:	5cbc                	lw	a5,120(s1)
     efe:	ff279be3          	bne	a5,s2,ef4 <tjoin+0x3a>
    return 0;
     f02:	4501                	li	a0,0
}
     f04:	60e2                	ld	ra,24(sp)
     f06:	6442                	ld	s0,16(sp)
     f08:	64a2                	ld	s1,8(sp)
     f0a:	6902                	ld	s2,0(sp)
     f0c:	6105                	addi	sp,sp,32
     f0e:	8082                	ret
        return -1;
     f10:	557d                	li	a0,-1
     f12:	bfcd                	j	f04 <tjoin+0x4a>
    return 0;
     f14:	4501                	li	a0,0
     f16:	b7fd                	j	f04 <tjoin+0x4a>

0000000000000f18 <twhoami>:

uint8 twhoami()
{
     f18:	1141                	addi	sp,sp,-16
     f1a:	e422                	sd	s0,8(sp)
     f1c:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
     f1e:	00001797          	auipc	a5,0x1
     f22:	0f27b783          	ld	a5,242(a5) # 2010 <current_thread>
     f26:	0007c503          	lbu	a0,0(a5)
     f2a:	6422                	ld	s0,8(sp)
     f2c:	0141                	addi	sp,sp,16
     f2e:	8082                	ret

0000000000000f30 <tswtch>:
     f30:	00153023          	sd	ra,0(a0)
     f34:	00253423          	sd	sp,8(a0)
     f38:	e900                	sd	s0,16(a0)
     f3a:	ed04                	sd	s1,24(a0)
     f3c:	03253023          	sd	s2,32(a0)
     f40:	03353423          	sd	s3,40(a0)
     f44:	03453823          	sd	s4,48(a0)
     f48:	03553c23          	sd	s5,56(a0)
     f4c:	05653023          	sd	s6,64(a0)
     f50:	05753423          	sd	s7,72(a0)
     f54:	05853823          	sd	s8,80(a0)
     f58:	05953c23          	sd	s9,88(a0)
     f5c:	07a53023          	sd	s10,96(a0)
     f60:	07b53423          	sd	s11,104(a0)
     f64:	0005b083          	ld	ra,0(a1)
     f68:	0085b103          	ld	sp,8(a1)
     f6c:	6980                	ld	s0,16(a1)
     f6e:	6d84                	ld	s1,24(a1)
     f70:	0205b903          	ld	s2,32(a1)
     f74:	0285b983          	ld	s3,40(a1)
     f78:	0305ba03          	ld	s4,48(a1)
     f7c:	0385ba83          	ld	s5,56(a1)
     f80:	0405bb03          	ld	s6,64(a1)
     f84:	0485bb83          	ld	s7,72(a1)
     f88:	0505bc03          	ld	s8,80(a1)
     f8c:	0585bc83          	ld	s9,88(a1)
     f90:	0605bd03          	ld	s10,96(a1)
     f94:	0685bd83          	ld	s11,104(a1)
     f98:	8082                	ret

0000000000000f9a <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     f9a:	1101                	addi	sp,sp,-32
     f9c:	ec06                	sd	ra,24(sp)
     f9e:	e822                	sd	s0,16(sp)
     fa0:	e426                	sd	s1,8(sp)
     fa2:	e04a                	sd	s2,0(sp)
     fa4:	1000                	addi	s0,sp,32
     fa6:	84aa                	mv	s1,a0
     fa8:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
     faa:	00000097          	auipc	ra,0x0
     fae:	d1e080e7          	jalr	-738(ra) # cc8 <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     fb2:	85ca                	mv	a1,s2
     fb4:	8526                	mv	a0,s1
     fb6:	00000097          	auipc	ra,0x0
     fba:	bac080e7          	jalr	-1108(ra) # b62 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
     fbe:	00000097          	auipc	ra,0x0
     fc2:	274080e7          	jalr	628(ra) # 1232 <exit>

0000000000000fc6 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     fc6:	1141                	addi	sp,sp,-16
     fc8:	e422                	sd	s0,8(sp)
     fca:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
     fcc:	87aa                	mv	a5,a0
     fce:	0585                	addi	a1,a1,1
     fd0:	0785                	addi	a5,a5,1
     fd2:	fff5c703          	lbu	a4,-1(a1)
     fd6:	fee78fa3          	sb	a4,-1(a5)
     fda:	fb75                	bnez	a4,fce <strcpy+0x8>
        ;
    return os;
}
     fdc:	6422                	ld	s0,8(sp)
     fde:	0141                	addi	sp,sp,16
     fe0:	8082                	ret

0000000000000fe2 <strcmp>:

int strcmp(const char *p, const char *q)
{
     fe2:	1141                	addi	sp,sp,-16
     fe4:	e422                	sd	s0,8(sp)
     fe6:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
     fe8:	00054783          	lbu	a5,0(a0)
     fec:	cb91                	beqz	a5,1000 <strcmp+0x1e>
     fee:	0005c703          	lbu	a4,0(a1)
     ff2:	00f71763          	bne	a4,a5,1000 <strcmp+0x1e>
        p++, q++;
     ff6:	0505                	addi	a0,a0,1
     ff8:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
     ffa:	00054783          	lbu	a5,0(a0)
     ffe:	fbe5                	bnez	a5,fee <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
    1000:	0005c503          	lbu	a0,0(a1)
}
    1004:	40a7853b          	subw	a0,a5,a0
    1008:	6422                	ld	s0,8(sp)
    100a:	0141                	addi	sp,sp,16
    100c:	8082                	ret

000000000000100e <strlen>:

uint strlen(const char *s)
{
    100e:	1141                	addi	sp,sp,-16
    1010:	e422                	sd	s0,8(sp)
    1012:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
    1014:	00054783          	lbu	a5,0(a0)
    1018:	cf91                	beqz	a5,1034 <strlen+0x26>
    101a:	0505                	addi	a0,a0,1
    101c:	87aa                	mv	a5,a0
    101e:	86be                	mv	a3,a5
    1020:	0785                	addi	a5,a5,1
    1022:	fff7c703          	lbu	a4,-1(a5)
    1026:	ff65                	bnez	a4,101e <strlen+0x10>
    1028:	40a6853b          	subw	a0,a3,a0
    102c:	2505                	addiw	a0,a0,1
        ;
    return n;
}
    102e:	6422                	ld	s0,8(sp)
    1030:	0141                	addi	sp,sp,16
    1032:	8082                	ret
    for (n = 0; s[n]; n++)
    1034:	4501                	li	a0,0
    1036:	bfe5                	j	102e <strlen+0x20>

0000000000001038 <memset>:

void *
memset(void *dst, int c, uint n)
{
    1038:	1141                	addi	sp,sp,-16
    103a:	e422                	sd	s0,8(sp)
    103c:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
    103e:	ca19                	beqz	a2,1054 <memset+0x1c>
    1040:	87aa                	mv	a5,a0
    1042:	1602                	slli	a2,a2,0x20
    1044:	9201                	srli	a2,a2,0x20
    1046:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
    104a:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
    104e:	0785                	addi	a5,a5,1
    1050:	fee79de3          	bne	a5,a4,104a <memset+0x12>
    }
    return dst;
}
    1054:	6422                	ld	s0,8(sp)
    1056:	0141                	addi	sp,sp,16
    1058:	8082                	ret

000000000000105a <strchr>:

char *
strchr(const char *s, char c)
{
    105a:	1141                	addi	sp,sp,-16
    105c:	e422                	sd	s0,8(sp)
    105e:	0800                	addi	s0,sp,16
    for (; *s; s++)
    1060:	00054783          	lbu	a5,0(a0)
    1064:	cb99                	beqz	a5,107a <strchr+0x20>
        if (*s == c)
    1066:	00f58763          	beq	a1,a5,1074 <strchr+0x1a>
    for (; *s; s++)
    106a:	0505                	addi	a0,a0,1
    106c:	00054783          	lbu	a5,0(a0)
    1070:	fbfd                	bnez	a5,1066 <strchr+0xc>
            return (char *)s;
    return 0;
    1072:	4501                	li	a0,0
}
    1074:	6422                	ld	s0,8(sp)
    1076:	0141                	addi	sp,sp,16
    1078:	8082                	ret
    return 0;
    107a:	4501                	li	a0,0
    107c:	bfe5                	j	1074 <strchr+0x1a>

000000000000107e <gets>:

char *
gets(char *buf, int max)
{
    107e:	711d                	addi	sp,sp,-96
    1080:	ec86                	sd	ra,88(sp)
    1082:	e8a2                	sd	s0,80(sp)
    1084:	e4a6                	sd	s1,72(sp)
    1086:	e0ca                	sd	s2,64(sp)
    1088:	fc4e                	sd	s3,56(sp)
    108a:	f852                	sd	s4,48(sp)
    108c:	f456                	sd	s5,40(sp)
    108e:	f05a                	sd	s6,32(sp)
    1090:	ec5e                	sd	s7,24(sp)
    1092:	1080                	addi	s0,sp,96
    1094:	8baa                	mv	s7,a0
    1096:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
    1098:	892a                	mv	s2,a0
    109a:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
    109c:	4aa9                	li	s5,10
    109e:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
    10a0:	89a6                	mv	s3,s1
    10a2:	2485                	addiw	s1,s1,1
    10a4:	0344d863          	bge	s1,s4,10d4 <gets+0x56>
        cc = read(0, &c, 1);
    10a8:	4605                	li	a2,1
    10aa:	faf40593          	addi	a1,s0,-81
    10ae:	4501                	li	a0,0
    10b0:	00000097          	auipc	ra,0x0
    10b4:	19a080e7          	jalr	410(ra) # 124a <read>
        if (cc < 1)
    10b8:	00a05e63          	blez	a0,10d4 <gets+0x56>
        buf[i++] = c;
    10bc:	faf44783          	lbu	a5,-81(s0)
    10c0:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
    10c4:	01578763          	beq	a5,s5,10d2 <gets+0x54>
    10c8:	0905                	addi	s2,s2,1
    10ca:	fd679be3          	bne	a5,s6,10a0 <gets+0x22>
    for (i = 0; i + 1 < max;)
    10ce:	89a6                	mv	s3,s1
    10d0:	a011                	j	10d4 <gets+0x56>
    10d2:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
    10d4:	99de                	add	s3,s3,s7
    10d6:	00098023          	sb	zero,0(s3)
    return buf;
}
    10da:	855e                	mv	a0,s7
    10dc:	60e6                	ld	ra,88(sp)
    10de:	6446                	ld	s0,80(sp)
    10e0:	64a6                	ld	s1,72(sp)
    10e2:	6906                	ld	s2,64(sp)
    10e4:	79e2                	ld	s3,56(sp)
    10e6:	7a42                	ld	s4,48(sp)
    10e8:	7aa2                	ld	s5,40(sp)
    10ea:	7b02                	ld	s6,32(sp)
    10ec:	6be2                	ld	s7,24(sp)
    10ee:	6125                	addi	sp,sp,96
    10f0:	8082                	ret

00000000000010f2 <stat>:

int stat(const char *n, struct stat *st)
{
    10f2:	1101                	addi	sp,sp,-32
    10f4:	ec06                	sd	ra,24(sp)
    10f6:	e822                	sd	s0,16(sp)
    10f8:	e426                	sd	s1,8(sp)
    10fa:	e04a                	sd	s2,0(sp)
    10fc:	1000                	addi	s0,sp,32
    10fe:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    1100:	4581                	li	a1,0
    1102:	00000097          	auipc	ra,0x0
    1106:	170080e7          	jalr	368(ra) # 1272 <open>
    if (fd < 0)
    110a:	02054563          	bltz	a0,1134 <stat+0x42>
    110e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
    1110:	85ca                	mv	a1,s2
    1112:	00000097          	auipc	ra,0x0
    1116:	178080e7          	jalr	376(ra) # 128a <fstat>
    111a:	892a                	mv	s2,a0
    close(fd);
    111c:	8526                	mv	a0,s1
    111e:	00000097          	auipc	ra,0x0
    1122:	13c080e7          	jalr	316(ra) # 125a <close>
    return r;
}
    1126:	854a                	mv	a0,s2
    1128:	60e2                	ld	ra,24(sp)
    112a:	6442                	ld	s0,16(sp)
    112c:	64a2                	ld	s1,8(sp)
    112e:	6902                	ld	s2,0(sp)
    1130:	6105                	addi	sp,sp,32
    1132:	8082                	ret
        return -1;
    1134:	597d                	li	s2,-1
    1136:	bfc5                	j	1126 <stat+0x34>

0000000000001138 <atoi>:

int atoi(const char *s)
{
    1138:	1141                	addi	sp,sp,-16
    113a:	e422                	sd	s0,8(sp)
    113c:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
    113e:	00054683          	lbu	a3,0(a0)
    1142:	fd06879b          	addiw	a5,a3,-48
    1146:	0ff7f793          	zext.b	a5,a5
    114a:	4625                	li	a2,9
    114c:	02f66863          	bltu	a2,a5,117c <atoi+0x44>
    1150:	872a                	mv	a4,a0
    n = 0;
    1152:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
    1154:	0705                	addi	a4,a4,1
    1156:	0025179b          	slliw	a5,a0,0x2
    115a:	9fa9                	addw	a5,a5,a0
    115c:	0017979b          	slliw	a5,a5,0x1
    1160:	9fb5                	addw	a5,a5,a3
    1162:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    1166:	00074683          	lbu	a3,0(a4)
    116a:	fd06879b          	addiw	a5,a3,-48
    116e:	0ff7f793          	zext.b	a5,a5
    1172:	fef671e3          	bgeu	a2,a5,1154 <atoi+0x1c>
    return n;
}
    1176:	6422                	ld	s0,8(sp)
    1178:	0141                	addi	sp,sp,16
    117a:	8082                	ret
    n = 0;
    117c:	4501                	li	a0,0
    117e:	bfe5                	j	1176 <atoi+0x3e>

0000000000001180 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    1180:	1141                	addi	sp,sp,-16
    1182:	e422                	sd	s0,8(sp)
    1184:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
    1186:	02b57463          	bgeu	a0,a1,11ae <memmove+0x2e>
    {
        while (n-- > 0)
    118a:	00c05f63          	blez	a2,11a8 <memmove+0x28>
    118e:	1602                	slli	a2,a2,0x20
    1190:	9201                	srli	a2,a2,0x20
    1192:	00c507b3          	add	a5,a0,a2
    dst = vdst;
    1196:	872a                	mv	a4,a0
            *dst++ = *src++;
    1198:	0585                	addi	a1,a1,1
    119a:	0705                	addi	a4,a4,1
    119c:	fff5c683          	lbu	a3,-1(a1)
    11a0:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    11a4:	fee79ae3          	bne	a5,a4,1198 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
    11a8:	6422                	ld	s0,8(sp)
    11aa:	0141                	addi	sp,sp,16
    11ac:	8082                	ret
        dst += n;
    11ae:	00c50733          	add	a4,a0,a2
        src += n;
    11b2:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    11b4:	fec05ae3          	blez	a2,11a8 <memmove+0x28>
    11b8:	fff6079b          	addiw	a5,a2,-1
    11bc:	1782                	slli	a5,a5,0x20
    11be:	9381                	srli	a5,a5,0x20
    11c0:	fff7c793          	not	a5,a5
    11c4:	97ba                	add	a5,a5,a4
            *--dst = *--src;
    11c6:	15fd                	addi	a1,a1,-1
    11c8:	177d                	addi	a4,a4,-1
    11ca:	0005c683          	lbu	a3,0(a1)
    11ce:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    11d2:	fee79ae3          	bne	a5,a4,11c6 <memmove+0x46>
    11d6:	bfc9                	j	11a8 <memmove+0x28>

00000000000011d8 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    11d8:	1141                	addi	sp,sp,-16
    11da:	e422                	sd	s0,8(sp)
    11dc:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
    11de:	ca05                	beqz	a2,120e <memcmp+0x36>
    11e0:	fff6069b          	addiw	a3,a2,-1
    11e4:	1682                	slli	a3,a3,0x20
    11e6:	9281                	srli	a3,a3,0x20
    11e8:	0685                	addi	a3,a3,1
    11ea:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
    11ec:	00054783          	lbu	a5,0(a0)
    11f0:	0005c703          	lbu	a4,0(a1)
    11f4:	00e79863          	bne	a5,a4,1204 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
    11f8:	0505                	addi	a0,a0,1
        p2++;
    11fa:	0585                	addi	a1,a1,1
    while (n-- > 0)
    11fc:	fed518e3          	bne	a0,a3,11ec <memcmp+0x14>
    }
    return 0;
    1200:	4501                	li	a0,0
    1202:	a019                	j	1208 <memcmp+0x30>
            return *p1 - *p2;
    1204:	40e7853b          	subw	a0,a5,a4
}
    1208:	6422                	ld	s0,8(sp)
    120a:	0141                	addi	sp,sp,16
    120c:	8082                	ret
    return 0;
    120e:	4501                	li	a0,0
    1210:	bfe5                	j	1208 <memcmp+0x30>

0000000000001212 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1212:	1141                	addi	sp,sp,-16
    1214:	e406                	sd	ra,8(sp)
    1216:	e022                	sd	s0,0(sp)
    1218:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    121a:	00000097          	auipc	ra,0x0
    121e:	f66080e7          	jalr	-154(ra) # 1180 <memmove>
}
    1222:	60a2                	ld	ra,8(sp)
    1224:	6402                	ld	s0,0(sp)
    1226:	0141                	addi	sp,sp,16
    1228:	8082                	ret

000000000000122a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    122a:	4885                	li	a7,1
 ecall
    122c:	00000073          	ecall
 ret
    1230:	8082                	ret

0000000000001232 <exit>:
.global exit
exit:
 li a7, SYS_exit
    1232:	4889                	li	a7,2
 ecall
    1234:	00000073          	ecall
 ret
    1238:	8082                	ret

000000000000123a <wait>:
.global wait
wait:
 li a7, SYS_wait
    123a:	488d                	li	a7,3
 ecall
    123c:	00000073          	ecall
 ret
    1240:	8082                	ret

0000000000001242 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    1242:	4891                	li	a7,4
 ecall
    1244:	00000073          	ecall
 ret
    1248:	8082                	ret

000000000000124a <read>:
.global read
read:
 li a7, SYS_read
    124a:	4895                	li	a7,5
 ecall
    124c:	00000073          	ecall
 ret
    1250:	8082                	ret

0000000000001252 <write>:
.global write
write:
 li a7, SYS_write
    1252:	48c1                	li	a7,16
 ecall
    1254:	00000073          	ecall
 ret
    1258:	8082                	ret

000000000000125a <close>:
.global close
close:
 li a7, SYS_close
    125a:	48d5                	li	a7,21
 ecall
    125c:	00000073          	ecall
 ret
    1260:	8082                	ret

0000000000001262 <kill>:
.global kill
kill:
 li a7, SYS_kill
    1262:	4899                	li	a7,6
 ecall
    1264:	00000073          	ecall
 ret
    1268:	8082                	ret

000000000000126a <exec>:
.global exec
exec:
 li a7, SYS_exec
    126a:	489d                	li	a7,7
 ecall
    126c:	00000073          	ecall
 ret
    1270:	8082                	ret

0000000000001272 <open>:
.global open
open:
 li a7, SYS_open
    1272:	48bd                	li	a7,15
 ecall
    1274:	00000073          	ecall
 ret
    1278:	8082                	ret

000000000000127a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    127a:	48c5                	li	a7,17
 ecall
    127c:	00000073          	ecall
 ret
    1280:	8082                	ret

0000000000001282 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    1282:	48c9                	li	a7,18
 ecall
    1284:	00000073          	ecall
 ret
    1288:	8082                	ret

000000000000128a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    128a:	48a1                	li	a7,8
 ecall
    128c:	00000073          	ecall
 ret
    1290:	8082                	ret

0000000000001292 <link>:
.global link
link:
 li a7, SYS_link
    1292:	48cd                	li	a7,19
 ecall
    1294:	00000073          	ecall
 ret
    1298:	8082                	ret

000000000000129a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    129a:	48d1                	li	a7,20
 ecall
    129c:	00000073          	ecall
 ret
    12a0:	8082                	ret

00000000000012a2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    12a2:	48a5                	li	a7,9
 ecall
    12a4:	00000073          	ecall
 ret
    12a8:	8082                	ret

00000000000012aa <dup>:
.global dup
dup:
 li a7, SYS_dup
    12aa:	48a9                	li	a7,10
 ecall
    12ac:	00000073          	ecall
 ret
    12b0:	8082                	ret

00000000000012b2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    12b2:	48ad                	li	a7,11
 ecall
    12b4:	00000073          	ecall
 ret
    12b8:	8082                	ret

00000000000012ba <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    12ba:	48b1                	li	a7,12
 ecall
    12bc:	00000073          	ecall
 ret
    12c0:	8082                	ret

00000000000012c2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    12c2:	48b5                	li	a7,13
 ecall
    12c4:	00000073          	ecall
 ret
    12c8:	8082                	ret

00000000000012ca <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    12ca:	48b9                	li	a7,14
 ecall
    12cc:	00000073          	ecall
 ret
    12d0:	8082                	ret

00000000000012d2 <ps>:
.global ps
ps:
 li a7, SYS_ps
    12d2:	48d9                	li	a7,22
 ecall
    12d4:	00000073          	ecall
 ret
    12d8:	8082                	ret

00000000000012da <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
    12da:	48dd                	li	a7,23
 ecall
    12dc:	00000073          	ecall
 ret
    12e0:	8082                	ret

00000000000012e2 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
    12e2:	48e1                	li	a7,24
 ecall
    12e4:	00000073          	ecall
 ret
    12e8:	8082                	ret

00000000000012ea <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    12ea:	1101                	addi	sp,sp,-32
    12ec:	ec06                	sd	ra,24(sp)
    12ee:	e822                	sd	s0,16(sp)
    12f0:	1000                	addi	s0,sp,32
    12f2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    12f6:	4605                	li	a2,1
    12f8:	fef40593          	addi	a1,s0,-17
    12fc:	00000097          	auipc	ra,0x0
    1300:	f56080e7          	jalr	-170(ra) # 1252 <write>
}
    1304:	60e2                	ld	ra,24(sp)
    1306:	6442                	ld	s0,16(sp)
    1308:	6105                	addi	sp,sp,32
    130a:	8082                	ret

000000000000130c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    130c:	7139                	addi	sp,sp,-64
    130e:	fc06                	sd	ra,56(sp)
    1310:	f822                	sd	s0,48(sp)
    1312:	f426                	sd	s1,40(sp)
    1314:	f04a                	sd	s2,32(sp)
    1316:	ec4e                	sd	s3,24(sp)
    1318:	0080                	addi	s0,sp,64
    131a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    131c:	c299                	beqz	a3,1322 <printint+0x16>
    131e:	0805c963          	bltz	a1,13b0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1322:	2581                	sext.w	a1,a1
  neg = 0;
    1324:	4881                	li	a7,0
    1326:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    132a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    132c:	2601                	sext.w	a2,a2
    132e:	00001517          	auipc	a0,0x1
    1332:	81a50513          	addi	a0,a0,-2022 # 1b48 <digits>
    1336:	883a                	mv	a6,a4
    1338:	2705                	addiw	a4,a4,1
    133a:	02c5f7bb          	remuw	a5,a1,a2
    133e:	1782                	slli	a5,a5,0x20
    1340:	9381                	srli	a5,a5,0x20
    1342:	97aa                	add	a5,a5,a0
    1344:	0007c783          	lbu	a5,0(a5)
    1348:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    134c:	0005879b          	sext.w	a5,a1
    1350:	02c5d5bb          	divuw	a1,a1,a2
    1354:	0685                	addi	a3,a3,1
    1356:	fec7f0e3          	bgeu	a5,a2,1336 <printint+0x2a>
  if(neg)
    135a:	00088c63          	beqz	a7,1372 <printint+0x66>
    buf[i++] = '-';
    135e:	fd070793          	addi	a5,a4,-48
    1362:	00878733          	add	a4,a5,s0
    1366:	02d00793          	li	a5,45
    136a:	fef70823          	sb	a5,-16(a4)
    136e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    1372:	02e05863          	blez	a4,13a2 <printint+0x96>
    1376:	fc040793          	addi	a5,s0,-64
    137a:	00e78933          	add	s2,a5,a4
    137e:	fff78993          	addi	s3,a5,-1
    1382:	99ba                	add	s3,s3,a4
    1384:	377d                	addiw	a4,a4,-1
    1386:	1702                	slli	a4,a4,0x20
    1388:	9301                	srli	a4,a4,0x20
    138a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    138e:	fff94583          	lbu	a1,-1(s2)
    1392:	8526                	mv	a0,s1
    1394:	00000097          	auipc	ra,0x0
    1398:	f56080e7          	jalr	-170(ra) # 12ea <putc>
  while(--i >= 0)
    139c:	197d                	addi	s2,s2,-1
    139e:	ff3918e3          	bne	s2,s3,138e <printint+0x82>
}
    13a2:	70e2                	ld	ra,56(sp)
    13a4:	7442                	ld	s0,48(sp)
    13a6:	74a2                	ld	s1,40(sp)
    13a8:	7902                	ld	s2,32(sp)
    13aa:	69e2                	ld	s3,24(sp)
    13ac:	6121                	addi	sp,sp,64
    13ae:	8082                	ret
    x = -xx;
    13b0:	40b005bb          	negw	a1,a1
    neg = 1;
    13b4:	4885                	li	a7,1
    x = -xx;
    13b6:	bf85                	j	1326 <printint+0x1a>

00000000000013b8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    13b8:	715d                	addi	sp,sp,-80
    13ba:	e486                	sd	ra,72(sp)
    13bc:	e0a2                	sd	s0,64(sp)
    13be:	fc26                	sd	s1,56(sp)
    13c0:	f84a                	sd	s2,48(sp)
    13c2:	f44e                	sd	s3,40(sp)
    13c4:	f052                	sd	s4,32(sp)
    13c6:	ec56                	sd	s5,24(sp)
    13c8:	e85a                	sd	s6,16(sp)
    13ca:	e45e                	sd	s7,8(sp)
    13cc:	e062                	sd	s8,0(sp)
    13ce:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    13d0:	0005c903          	lbu	s2,0(a1)
    13d4:	18090c63          	beqz	s2,156c <vprintf+0x1b4>
    13d8:	8aaa                	mv	s5,a0
    13da:	8bb2                	mv	s7,a2
    13dc:	00158493          	addi	s1,a1,1
  state = 0;
    13e0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    13e2:	02500a13          	li	s4,37
    13e6:	4b55                	li	s6,21
    13e8:	a839                	j	1406 <vprintf+0x4e>
        putc(fd, c);
    13ea:	85ca                	mv	a1,s2
    13ec:	8556                	mv	a0,s5
    13ee:	00000097          	auipc	ra,0x0
    13f2:	efc080e7          	jalr	-260(ra) # 12ea <putc>
    13f6:	a019                	j	13fc <vprintf+0x44>
    } else if(state == '%'){
    13f8:	01498d63          	beq	s3,s4,1412 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    13fc:	0485                	addi	s1,s1,1
    13fe:	fff4c903          	lbu	s2,-1(s1)
    1402:	16090563          	beqz	s2,156c <vprintf+0x1b4>
    if(state == 0){
    1406:	fe0999e3          	bnez	s3,13f8 <vprintf+0x40>
      if(c == '%'){
    140a:	ff4910e3          	bne	s2,s4,13ea <vprintf+0x32>
        state = '%';
    140e:	89d2                	mv	s3,s4
    1410:	b7f5                	j	13fc <vprintf+0x44>
      if(c == 'd'){
    1412:	13490263          	beq	s2,s4,1536 <vprintf+0x17e>
    1416:	f9d9079b          	addiw	a5,s2,-99
    141a:	0ff7f793          	zext.b	a5,a5
    141e:	12fb6563          	bltu	s6,a5,1548 <vprintf+0x190>
    1422:	f9d9079b          	addiw	a5,s2,-99
    1426:	0ff7f713          	zext.b	a4,a5
    142a:	10eb6f63          	bltu	s6,a4,1548 <vprintf+0x190>
    142e:	00271793          	slli	a5,a4,0x2
    1432:	00000717          	auipc	a4,0x0
    1436:	6be70713          	addi	a4,a4,1726 # 1af0 <malloc+0x486>
    143a:	97ba                	add	a5,a5,a4
    143c:	439c                	lw	a5,0(a5)
    143e:	97ba                	add	a5,a5,a4
    1440:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1442:	008b8913          	addi	s2,s7,8
    1446:	4685                	li	a3,1
    1448:	4629                	li	a2,10
    144a:	000ba583          	lw	a1,0(s7)
    144e:	8556                	mv	a0,s5
    1450:	00000097          	auipc	ra,0x0
    1454:	ebc080e7          	jalr	-324(ra) # 130c <printint>
    1458:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    145a:	4981                	li	s3,0
    145c:	b745                	j	13fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    145e:	008b8913          	addi	s2,s7,8
    1462:	4681                	li	a3,0
    1464:	4629                	li	a2,10
    1466:	000ba583          	lw	a1,0(s7)
    146a:	8556                	mv	a0,s5
    146c:	00000097          	auipc	ra,0x0
    1470:	ea0080e7          	jalr	-352(ra) # 130c <printint>
    1474:	8bca                	mv	s7,s2
      state = 0;
    1476:	4981                	li	s3,0
    1478:	b751                	j	13fc <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    147a:	008b8913          	addi	s2,s7,8
    147e:	4681                	li	a3,0
    1480:	4641                	li	a2,16
    1482:	000ba583          	lw	a1,0(s7)
    1486:	8556                	mv	a0,s5
    1488:	00000097          	auipc	ra,0x0
    148c:	e84080e7          	jalr	-380(ra) # 130c <printint>
    1490:	8bca                	mv	s7,s2
      state = 0;
    1492:	4981                	li	s3,0
    1494:	b7a5                	j	13fc <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    1496:	008b8c13          	addi	s8,s7,8
    149a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    149e:	03000593          	li	a1,48
    14a2:	8556                	mv	a0,s5
    14a4:	00000097          	auipc	ra,0x0
    14a8:	e46080e7          	jalr	-442(ra) # 12ea <putc>
  putc(fd, 'x');
    14ac:	07800593          	li	a1,120
    14b0:	8556                	mv	a0,s5
    14b2:	00000097          	auipc	ra,0x0
    14b6:	e38080e7          	jalr	-456(ra) # 12ea <putc>
    14ba:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    14bc:	00000b97          	auipc	s7,0x0
    14c0:	68cb8b93          	addi	s7,s7,1676 # 1b48 <digits>
    14c4:	03c9d793          	srli	a5,s3,0x3c
    14c8:	97de                	add	a5,a5,s7
    14ca:	0007c583          	lbu	a1,0(a5)
    14ce:	8556                	mv	a0,s5
    14d0:	00000097          	auipc	ra,0x0
    14d4:	e1a080e7          	jalr	-486(ra) # 12ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    14d8:	0992                	slli	s3,s3,0x4
    14da:	397d                	addiw	s2,s2,-1
    14dc:	fe0914e3          	bnez	s2,14c4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    14e0:	8be2                	mv	s7,s8
      state = 0;
    14e2:	4981                	li	s3,0
    14e4:	bf21                	j	13fc <vprintf+0x44>
        s = va_arg(ap, char*);
    14e6:	008b8993          	addi	s3,s7,8
    14ea:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    14ee:	02090163          	beqz	s2,1510 <vprintf+0x158>
        while(*s != 0){
    14f2:	00094583          	lbu	a1,0(s2)
    14f6:	c9a5                	beqz	a1,1566 <vprintf+0x1ae>
          putc(fd, *s);
    14f8:	8556                	mv	a0,s5
    14fa:	00000097          	auipc	ra,0x0
    14fe:	df0080e7          	jalr	-528(ra) # 12ea <putc>
          s++;
    1502:	0905                	addi	s2,s2,1
        while(*s != 0){
    1504:	00094583          	lbu	a1,0(s2)
    1508:	f9e5                	bnez	a1,14f8 <vprintf+0x140>
        s = va_arg(ap, char*);
    150a:	8bce                	mv	s7,s3
      state = 0;
    150c:	4981                	li	s3,0
    150e:	b5fd                	j	13fc <vprintf+0x44>
          s = "(null)";
    1510:	00000917          	auipc	s2,0x0
    1514:	5d890913          	addi	s2,s2,1496 # 1ae8 <malloc+0x47e>
        while(*s != 0){
    1518:	02800593          	li	a1,40
    151c:	bff1                	j	14f8 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    151e:	008b8913          	addi	s2,s7,8
    1522:	000bc583          	lbu	a1,0(s7)
    1526:	8556                	mv	a0,s5
    1528:	00000097          	auipc	ra,0x0
    152c:	dc2080e7          	jalr	-574(ra) # 12ea <putc>
    1530:	8bca                	mv	s7,s2
      state = 0;
    1532:	4981                	li	s3,0
    1534:	b5e1                	j	13fc <vprintf+0x44>
        putc(fd, c);
    1536:	02500593          	li	a1,37
    153a:	8556                	mv	a0,s5
    153c:	00000097          	auipc	ra,0x0
    1540:	dae080e7          	jalr	-594(ra) # 12ea <putc>
      state = 0;
    1544:	4981                	li	s3,0
    1546:	bd5d                	j	13fc <vprintf+0x44>
        putc(fd, '%');
    1548:	02500593          	li	a1,37
    154c:	8556                	mv	a0,s5
    154e:	00000097          	auipc	ra,0x0
    1552:	d9c080e7          	jalr	-612(ra) # 12ea <putc>
        putc(fd, c);
    1556:	85ca                	mv	a1,s2
    1558:	8556                	mv	a0,s5
    155a:	00000097          	auipc	ra,0x0
    155e:	d90080e7          	jalr	-624(ra) # 12ea <putc>
      state = 0;
    1562:	4981                	li	s3,0
    1564:	bd61                	j	13fc <vprintf+0x44>
        s = va_arg(ap, char*);
    1566:	8bce                	mv	s7,s3
      state = 0;
    1568:	4981                	li	s3,0
    156a:	bd49                	j	13fc <vprintf+0x44>
    }
  }
}
    156c:	60a6                	ld	ra,72(sp)
    156e:	6406                	ld	s0,64(sp)
    1570:	74e2                	ld	s1,56(sp)
    1572:	7942                	ld	s2,48(sp)
    1574:	79a2                	ld	s3,40(sp)
    1576:	7a02                	ld	s4,32(sp)
    1578:	6ae2                	ld	s5,24(sp)
    157a:	6b42                	ld	s6,16(sp)
    157c:	6ba2                	ld	s7,8(sp)
    157e:	6c02                	ld	s8,0(sp)
    1580:	6161                	addi	sp,sp,80
    1582:	8082                	ret

0000000000001584 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1584:	715d                	addi	sp,sp,-80
    1586:	ec06                	sd	ra,24(sp)
    1588:	e822                	sd	s0,16(sp)
    158a:	1000                	addi	s0,sp,32
    158c:	e010                	sd	a2,0(s0)
    158e:	e414                	sd	a3,8(s0)
    1590:	e818                	sd	a4,16(s0)
    1592:	ec1c                	sd	a5,24(s0)
    1594:	03043023          	sd	a6,32(s0)
    1598:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    159c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    15a0:	8622                	mv	a2,s0
    15a2:	00000097          	auipc	ra,0x0
    15a6:	e16080e7          	jalr	-490(ra) # 13b8 <vprintf>
}
    15aa:	60e2                	ld	ra,24(sp)
    15ac:	6442                	ld	s0,16(sp)
    15ae:	6161                	addi	sp,sp,80
    15b0:	8082                	ret

00000000000015b2 <printf>:

void
printf(const char *fmt, ...)
{
    15b2:	711d                	addi	sp,sp,-96
    15b4:	ec06                	sd	ra,24(sp)
    15b6:	e822                	sd	s0,16(sp)
    15b8:	1000                	addi	s0,sp,32
    15ba:	e40c                	sd	a1,8(s0)
    15bc:	e810                	sd	a2,16(s0)
    15be:	ec14                	sd	a3,24(s0)
    15c0:	f018                	sd	a4,32(s0)
    15c2:	f41c                	sd	a5,40(s0)
    15c4:	03043823          	sd	a6,48(s0)
    15c8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    15cc:	00840613          	addi	a2,s0,8
    15d0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    15d4:	85aa                	mv	a1,a0
    15d6:	4505                	li	a0,1
    15d8:	00000097          	auipc	ra,0x0
    15dc:	de0080e7          	jalr	-544(ra) # 13b8 <vprintf>
}
    15e0:	60e2                	ld	ra,24(sp)
    15e2:	6442                	ld	s0,16(sp)
    15e4:	6125                	addi	sp,sp,96
    15e6:	8082                	ret

00000000000015e8 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    15e8:	1141                	addi	sp,sp,-16
    15ea:	e422                	sd	s0,8(sp)
    15ec:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    15ee:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15f2:	00001797          	auipc	a5,0x1
    15f6:	a267b783          	ld	a5,-1498(a5) # 2018 <freep>
    15fa:	a02d                	j	1624 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    15fc:	4618                	lw	a4,8(a2)
    15fe:	9f2d                	addw	a4,a4,a1
    1600:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    1604:	6398                	ld	a4,0(a5)
    1606:	6310                	ld	a2,0(a4)
    1608:	a83d                	j	1646 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    160a:	ff852703          	lw	a4,-8(a0)
    160e:	9f31                	addw	a4,a4,a2
    1610:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    1612:	ff053683          	ld	a3,-16(a0)
    1616:	a091                	j	165a <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1618:	6398                	ld	a4,0(a5)
    161a:	00e7e463          	bltu	a5,a4,1622 <free+0x3a>
    161e:	00e6ea63          	bltu	a3,a4,1632 <free+0x4a>
{
    1622:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1624:	fed7fae3          	bgeu	a5,a3,1618 <free+0x30>
    1628:	6398                	ld	a4,0(a5)
    162a:	00e6e463          	bltu	a3,a4,1632 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    162e:	fee7eae3          	bltu	a5,a4,1622 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    1632:	ff852583          	lw	a1,-8(a0)
    1636:	6390                	ld	a2,0(a5)
    1638:	02059813          	slli	a6,a1,0x20
    163c:	01c85713          	srli	a4,a6,0x1c
    1640:	9736                	add	a4,a4,a3
    1642:	fae60de3          	beq	a2,a4,15fc <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    1646:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    164a:	4790                	lw	a2,8(a5)
    164c:	02061593          	slli	a1,a2,0x20
    1650:	01c5d713          	srli	a4,a1,0x1c
    1654:	973e                	add	a4,a4,a5
    1656:	fae68ae3          	beq	a3,a4,160a <free+0x22>
        p->s.ptr = bp->s.ptr;
    165a:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    165c:	00001717          	auipc	a4,0x1
    1660:	9af73e23          	sd	a5,-1604(a4) # 2018 <freep>
}
    1664:	6422                	ld	s0,8(sp)
    1666:	0141                	addi	sp,sp,16
    1668:	8082                	ret

000000000000166a <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    166a:	7139                	addi	sp,sp,-64
    166c:	fc06                	sd	ra,56(sp)
    166e:	f822                	sd	s0,48(sp)
    1670:	f426                	sd	s1,40(sp)
    1672:	f04a                	sd	s2,32(sp)
    1674:	ec4e                	sd	s3,24(sp)
    1676:	e852                	sd	s4,16(sp)
    1678:	e456                	sd	s5,8(sp)
    167a:	e05a                	sd	s6,0(sp)
    167c:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    167e:	02051493          	slli	s1,a0,0x20
    1682:	9081                	srli	s1,s1,0x20
    1684:	04bd                	addi	s1,s1,15
    1686:	8091                	srli	s1,s1,0x4
    1688:	0014899b          	addiw	s3,s1,1
    168c:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    168e:	00001517          	auipc	a0,0x1
    1692:	98a53503          	ld	a0,-1654(a0) # 2018 <freep>
    1696:	c515                	beqz	a0,16c2 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    1698:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    169a:	4798                	lw	a4,8(a5)
    169c:	02977f63          	bgeu	a4,s1,16da <malloc+0x70>
    if (nu < 4096)
    16a0:	8a4e                	mv	s4,s3
    16a2:	0009871b          	sext.w	a4,s3
    16a6:	6685                	lui	a3,0x1
    16a8:	00d77363          	bgeu	a4,a3,16ae <malloc+0x44>
    16ac:	6a05                	lui	s4,0x1
    16ae:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    16b2:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    16b6:	00001917          	auipc	s2,0x1
    16ba:	96290913          	addi	s2,s2,-1694 # 2018 <freep>
    if (p == (char *)-1)
    16be:	5afd                	li	s5,-1
    16c0:	a895                	j	1734 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    16c2:	00001797          	auipc	a5,0x1
    16c6:	dc678793          	addi	a5,a5,-570 # 2488 <base>
    16ca:	00001717          	auipc	a4,0x1
    16ce:	94f73723          	sd	a5,-1714(a4) # 2018 <freep>
    16d2:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    16d4:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    16d8:	b7e1                	j	16a0 <malloc+0x36>
            if (p->s.size == nunits)
    16da:	02e48c63          	beq	s1,a4,1712 <malloc+0xa8>
                p->s.size -= nunits;
    16de:	4137073b          	subw	a4,a4,s3
    16e2:	c798                	sw	a4,8(a5)
                p += p->s.size;
    16e4:	02071693          	slli	a3,a4,0x20
    16e8:	01c6d713          	srli	a4,a3,0x1c
    16ec:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    16ee:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    16f2:	00001717          	auipc	a4,0x1
    16f6:	92a73323          	sd	a0,-1754(a4) # 2018 <freep>
            return (void *)(p + 1);
    16fa:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    16fe:	70e2                	ld	ra,56(sp)
    1700:	7442                	ld	s0,48(sp)
    1702:	74a2                	ld	s1,40(sp)
    1704:	7902                	ld	s2,32(sp)
    1706:	69e2                	ld	s3,24(sp)
    1708:	6a42                	ld	s4,16(sp)
    170a:	6aa2                	ld	s5,8(sp)
    170c:	6b02                	ld	s6,0(sp)
    170e:	6121                	addi	sp,sp,64
    1710:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    1712:	6398                	ld	a4,0(a5)
    1714:	e118                	sd	a4,0(a0)
    1716:	bff1                	j	16f2 <malloc+0x88>
    hp->s.size = nu;
    1718:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    171c:	0541                	addi	a0,a0,16
    171e:	00000097          	auipc	ra,0x0
    1722:	eca080e7          	jalr	-310(ra) # 15e8 <free>
    return freep;
    1726:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    172a:	d971                	beqz	a0,16fe <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    172c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    172e:	4798                	lw	a4,8(a5)
    1730:	fa9775e3          	bgeu	a4,s1,16da <malloc+0x70>
        if (p == freep)
    1734:	00093703          	ld	a4,0(s2)
    1738:	853e                	mv	a0,a5
    173a:	fef719e3          	bne	a4,a5,172c <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    173e:	8552                	mv	a0,s4
    1740:	00000097          	auipc	ra,0x0
    1744:	b7a080e7          	jalr	-1158(ra) # 12ba <sbrk>
    if (p == (char *)-1)
    1748:	fd5518e3          	bne	a0,s5,1718 <malloc+0xae>
                return 0;
    174c:	4501                	li	a0,0
    174e:	bf45                	j	16fe <malloc+0x94>
