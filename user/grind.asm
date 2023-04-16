
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
      94:	25c080e7          	jalr	604(ra) # 12ec <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	6f650513          	addi	a0,a0,1782 # 1790 <malloc+0xf4>
      a2:	00001097          	auipc	ra,0x1
      a6:	22a080e7          	jalr	554(ra) # 12cc <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	6e650513          	addi	a0,a0,1766 # 1790 <malloc+0xf4>
      b2:	00001097          	auipc	ra,0x1
      b6:	222080e7          	jalr	546(ra) # 12d4 <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	6dc50513          	addi	a0,a0,1756 # 1798 <malloc+0xfc>
      c4:	00001097          	auipc	ra,0x1
      c8:	520080e7          	jalr	1312(ra) # 15e4 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	196080e7          	jalr	406(ra) # 1264 <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	6e250513          	addi	a0,a0,1762 # 17b8 <malloc+0x11c>
      de:	00001097          	auipc	ra,0x1
      e2:	1f6080e7          	jalr	502(ra) # 12d4 <chdir>
      e6:	00001997          	auipc	s3,0x1
      ea:	6e298993          	addi	s3,s3,1762 # 17c8 <malloc+0x12c>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	6d098993          	addi	s3,s3,1744 # 17c0 <malloc+0x124>
  uint64 iters = 0;
      f8:	4481                	li	s1,0
  int fd = -1;
      fa:	5a7d                	li	s4,-1
      fc:	00002917          	auipc	s2,0x2
     100:	97c90913          	addi	s2,s2,-1668 # 1a78 <malloc+0x3dc>
     104:	a839                	j	122 <go+0xaa>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	6c650513          	addi	a0,a0,1734 # 17d0 <malloc+0x134>
     112:	00001097          	auipc	ra,0x1
     116:	192080e7          	jalr	402(ra) # 12a4 <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	172080e7          	jalr	370(ra) # 128c <close>
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
     138:	150080e7          	jalr	336(ra) # 1284 <write>
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
     168:	67c50513          	addi	a0,a0,1660 # 17e0 <malloc+0x144>
     16c:	00001097          	auipc	ra,0x1
     170:	138080e7          	jalr	312(ra) # 12a4 <open>
     174:	00001097          	auipc	ra,0x1
     178:	118080e7          	jalr	280(ra) # 128c <close>
     17c:	b75d                	j	122 <go+0xaa>
    } else if(what == 3){
      unlink("grindir/../a");
     17e:	00001517          	auipc	a0,0x1
     182:	65250513          	addi	a0,a0,1618 # 17d0 <malloc+0x134>
     186:	00001097          	auipc	ra,0x1
     18a:	12e080e7          	jalr	302(ra) # 12b4 <unlink>
     18e:	bf51                	j	122 <go+0xaa>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     190:	00001517          	auipc	a0,0x1
     194:	60050513          	addi	a0,a0,1536 # 1790 <malloc+0xf4>
     198:	00001097          	auipc	ra,0x1
     19c:	13c080e7          	jalr	316(ra) # 12d4 <chdir>
     1a0:	e115                	bnez	a0,1c4 <go+0x14c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     1a2:	00001517          	auipc	a0,0x1
     1a6:	65650513          	addi	a0,a0,1622 # 17f8 <malloc+0x15c>
     1aa:	00001097          	auipc	ra,0x1
     1ae:	10a080e7          	jalr	266(ra) # 12b4 <unlink>
      chdir("/");
     1b2:	00001517          	auipc	a0,0x1
     1b6:	60650513          	addi	a0,a0,1542 # 17b8 <malloc+0x11c>
     1ba:	00001097          	auipc	ra,0x1
     1be:	11a080e7          	jalr	282(ra) # 12d4 <chdir>
     1c2:	b785                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     1c4:	00001517          	auipc	a0,0x1
     1c8:	5d450513          	addi	a0,a0,1492 # 1798 <malloc+0xfc>
     1cc:	00001097          	auipc	ra,0x1
     1d0:	418080e7          	jalr	1048(ra) # 15e4 <printf>
        exit(1);
     1d4:	4505                	li	a0,1
     1d6:	00001097          	auipc	ra,0x1
     1da:	08e080e7          	jalr	142(ra) # 1264 <exit>
    } else if(what == 5){
      close(fd);
     1de:	8552                	mv	a0,s4
     1e0:	00001097          	auipc	ra,0x1
     1e4:	0ac080e7          	jalr	172(ra) # 128c <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1e8:	20200593          	li	a1,514
     1ec:	00001517          	auipc	a0,0x1
     1f0:	61450513          	addi	a0,a0,1556 # 1800 <malloc+0x164>
     1f4:	00001097          	auipc	ra,0x1
     1f8:	0b0080e7          	jalr	176(ra) # 12a4 <open>
     1fc:	8a2a                	mv	s4,a0
     1fe:	b715                	j	122 <go+0xaa>
    } else if(what == 6){
      close(fd);
     200:	8552                	mv	a0,s4
     202:	00001097          	auipc	ra,0x1
     206:	08a080e7          	jalr	138(ra) # 128c <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	60250513          	addi	a0,a0,1538 # 1810 <malloc+0x174>
     216:	00001097          	auipc	ra,0x1
     21a:	08e080e7          	jalr	142(ra) # 12a4 <open>
     21e:	8a2a                	mv	s4,a0
     220:	b709                	j	122 <go+0xaa>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     222:	3e700613          	li	a2,999
     226:	00002597          	auipc	a1,0x2
     22a:	dfa58593          	addi	a1,a1,-518 # 2020 <buf.0>
     22e:	8552                	mv	a0,s4
     230:	00001097          	auipc	ra,0x1
     234:	054080e7          	jalr	84(ra) # 1284 <write>
     238:	b5ed                	j	122 <go+0xaa>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     23a:	3e700613          	li	a2,999
     23e:	00002597          	auipc	a1,0x2
     242:	de258593          	addi	a1,a1,-542 # 2020 <buf.0>
     246:	8552                	mv	a0,s4
     248:	00001097          	auipc	ra,0x1
     24c:	034080e7          	jalr	52(ra) # 127c <read>
     250:	bdc9                	j	122 <go+0xaa>
    } else if(what == 9){
      mkdir("grindir/../a");
     252:	00001517          	auipc	a0,0x1
     256:	57e50513          	addi	a0,a0,1406 # 17d0 <malloc+0x134>
     25a:	00001097          	auipc	ra,0x1
     25e:	072080e7          	jalr	114(ra) # 12cc <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     262:	20200593          	li	a1,514
     266:	00001517          	auipc	a0,0x1
     26a:	5c250513          	addi	a0,a0,1474 # 1828 <malloc+0x18c>
     26e:	00001097          	auipc	ra,0x1
     272:	036080e7          	jalr	54(ra) # 12a4 <open>
     276:	00001097          	auipc	ra,0x1
     27a:	016080e7          	jalr	22(ra) # 128c <close>
      unlink("a/a");
     27e:	00001517          	auipc	a0,0x1
     282:	5ba50513          	addi	a0,a0,1466 # 1838 <malloc+0x19c>
     286:	00001097          	auipc	ra,0x1
     28a:	02e080e7          	jalr	46(ra) # 12b4 <unlink>
     28e:	bd51                	j	122 <go+0xaa>
    } else if(what == 10){
      mkdir("/../b");
     290:	00001517          	auipc	a0,0x1
     294:	5b050513          	addi	a0,a0,1456 # 1840 <malloc+0x1a4>
     298:	00001097          	auipc	ra,0x1
     29c:	034080e7          	jalr	52(ra) # 12cc <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2a0:	20200593          	li	a1,514
     2a4:	00001517          	auipc	a0,0x1
     2a8:	5a450513          	addi	a0,a0,1444 # 1848 <malloc+0x1ac>
     2ac:	00001097          	auipc	ra,0x1
     2b0:	ff8080e7          	jalr	-8(ra) # 12a4 <open>
     2b4:	00001097          	auipc	ra,0x1
     2b8:	fd8080e7          	jalr	-40(ra) # 128c <close>
      unlink("b/b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	59c50513          	addi	a0,a0,1436 # 1858 <malloc+0x1bc>
     2c4:	00001097          	auipc	ra,0x1
     2c8:	ff0080e7          	jalr	-16(ra) # 12b4 <unlink>
     2cc:	bd99                	j	122 <go+0xaa>
    } else if(what == 11){
      unlink("b");
     2ce:	00001517          	auipc	a0,0x1
     2d2:	55250513          	addi	a0,a0,1362 # 1820 <malloc+0x184>
     2d6:	00001097          	auipc	ra,0x1
     2da:	fde080e7          	jalr	-34(ra) # 12b4 <unlink>
      link("../grindir/./../a", "../b");
     2de:	00001597          	auipc	a1,0x1
     2e2:	51a58593          	addi	a1,a1,1306 # 17f8 <malloc+0x15c>
     2e6:	00001517          	auipc	a0,0x1
     2ea:	57a50513          	addi	a0,a0,1402 # 1860 <malloc+0x1c4>
     2ee:	00001097          	auipc	ra,0x1
     2f2:	fd6080e7          	jalr	-42(ra) # 12c4 <link>
     2f6:	b535                	j	122 <go+0xaa>
    } else if(what == 12){
      unlink("../grindir/../a");
     2f8:	00001517          	auipc	a0,0x1
     2fc:	58050513          	addi	a0,a0,1408 # 1878 <malloc+0x1dc>
     300:	00001097          	auipc	ra,0x1
     304:	fb4080e7          	jalr	-76(ra) # 12b4 <unlink>
      link(".././b", "/grindir/../a");
     308:	00001597          	auipc	a1,0x1
     30c:	4f858593          	addi	a1,a1,1272 # 1800 <malloc+0x164>
     310:	00001517          	auipc	a0,0x1
     314:	57850513          	addi	a0,a0,1400 # 1888 <malloc+0x1ec>
     318:	00001097          	auipc	ra,0x1
     31c:	fac080e7          	jalr	-84(ra) # 12c4 <link>
     320:	b509                	j	122 <go+0xaa>
    } else if(what == 13){
      int pid = fork();
     322:	00001097          	auipc	ra,0x1
     326:	f3a080e7          	jalr	-198(ra) # 125c <fork>
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
     336:	f3a080e7          	jalr	-198(ra) # 126c <wait>
     33a:	b3e5                	j	122 <go+0xaa>
        exit(0);
     33c:	00001097          	auipc	ra,0x1
     340:	f28080e7          	jalr	-216(ra) # 1264 <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	54c50513          	addi	a0,a0,1356 # 1890 <malloc+0x1f4>
     34c:	00001097          	auipc	ra,0x1
     350:	298080e7          	jalr	664(ra) # 15e4 <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	00001097          	auipc	ra,0x1
     35a:	f0e080e7          	jalr	-242(ra) # 1264 <exit>
    } else if(what == 14){
      int pid = fork();
     35e:	00001097          	auipc	ra,0x1
     362:	efe080e7          	jalr	-258(ra) # 125c <fork>
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
     372:	efe080e7          	jalr	-258(ra) # 126c <wait>
     376:	b375                	j	122 <go+0xaa>
        fork();
     378:	00001097          	auipc	ra,0x1
     37c:	ee4080e7          	jalr	-284(ra) # 125c <fork>
        fork();
     380:	00001097          	auipc	ra,0x1
     384:	edc080e7          	jalr	-292(ra) # 125c <fork>
        exit(0);
     388:	4501                	li	a0,0
     38a:	00001097          	auipc	ra,0x1
     38e:	eda080e7          	jalr	-294(ra) # 1264 <exit>
        printf("grind: fork failed\n");
     392:	00001517          	auipc	a0,0x1
     396:	4fe50513          	addi	a0,a0,1278 # 1890 <malloc+0x1f4>
     39a:	00001097          	auipc	ra,0x1
     39e:	24a080e7          	jalr	586(ra) # 15e4 <printf>
        exit(1);
     3a2:	4505                	li	a0,1
     3a4:	00001097          	auipc	ra,0x1
     3a8:	ec0080e7          	jalr	-320(ra) # 1264 <exit>
    } else if(what == 15){
      sbrk(6011);
     3ac:	6505                	lui	a0,0x1
     3ae:	77b50513          	addi	a0,a0,1915 # 177b <malloc+0xdf>
     3b2:	00001097          	auipc	ra,0x1
     3b6:	f3a080e7          	jalr	-198(ra) # 12ec <sbrk>
     3ba:	b3a5                	j	122 <go+0xaa>
    } else if(what == 16){
      if(sbrk(0) > break0)
     3bc:	4501                	li	a0,0
     3be:	00001097          	auipc	ra,0x1
     3c2:	f2e080e7          	jalr	-210(ra) # 12ec <sbrk>
     3c6:	d4aafee3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     3ca:	4501                	li	a0,0
     3cc:	00001097          	auipc	ra,0x1
     3d0:	f20080e7          	jalr	-224(ra) # 12ec <sbrk>
     3d4:	40aa853b          	subw	a0,s5,a0
     3d8:	00001097          	auipc	ra,0x1
     3dc:	f14080e7          	jalr	-236(ra) # 12ec <sbrk>
     3e0:	b389                	j	122 <go+0xaa>
    } else if(what == 17){
      int pid = fork();
     3e2:	00001097          	auipc	ra,0x1
     3e6:	e7a080e7          	jalr	-390(ra) # 125c <fork>
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
     3f6:	4b650513          	addi	a0,a0,1206 # 18a8 <malloc+0x20c>
     3fa:	00001097          	auipc	ra,0x1
     3fe:	eda080e7          	jalr	-294(ra) # 12d4 <chdir>
     402:	ed21                	bnez	a0,45a <go+0x3e2>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     404:	855a                	mv	a0,s6
     406:	00001097          	auipc	ra,0x1
     40a:	e8e080e7          	jalr	-370(ra) # 1294 <kill>
      wait(0);
     40e:	4501                	li	a0,0
     410:	00001097          	auipc	ra,0x1
     414:	e5c080e7          	jalr	-420(ra) # 126c <wait>
     418:	b329                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     41a:	20200593          	li	a1,514
     41e:	00001517          	auipc	a0,0x1
     422:	45250513          	addi	a0,a0,1106 # 1870 <malloc+0x1d4>
     426:	00001097          	auipc	ra,0x1
     42a:	e7e080e7          	jalr	-386(ra) # 12a4 <open>
     42e:	00001097          	auipc	ra,0x1
     432:	e5e080e7          	jalr	-418(ra) # 128c <close>
        exit(0);
     436:	4501                	li	a0,0
     438:	00001097          	auipc	ra,0x1
     43c:	e2c080e7          	jalr	-468(ra) # 1264 <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	45050513          	addi	a0,a0,1104 # 1890 <malloc+0x1f4>
     448:	00001097          	auipc	ra,0x1
     44c:	19c080e7          	jalr	412(ra) # 15e4 <printf>
        exit(1);
     450:	4505                	li	a0,1
     452:	00001097          	auipc	ra,0x1
     456:	e12080e7          	jalr	-494(ra) # 1264 <exit>
        printf("grind: chdir failed\n");
     45a:	00001517          	auipc	a0,0x1
     45e:	45e50513          	addi	a0,a0,1118 # 18b8 <malloc+0x21c>
     462:	00001097          	auipc	ra,0x1
     466:	182080e7          	jalr	386(ra) # 15e4 <printf>
        exit(1);
     46a:	4505                	li	a0,1
     46c:	00001097          	auipc	ra,0x1
     470:	df8080e7          	jalr	-520(ra) # 1264 <exit>
    } else if(what == 18){
      int pid = fork();
     474:	00001097          	auipc	ra,0x1
     478:	de8080e7          	jalr	-536(ra) # 125c <fork>
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
     488:	de8080e7          	jalr	-536(ra) # 126c <wait>
     48c:	b959                	j	122 <go+0xaa>
        kill(getpid());
     48e:	00001097          	auipc	ra,0x1
     492:	e56080e7          	jalr	-426(ra) # 12e4 <getpid>
     496:	00001097          	auipc	ra,0x1
     49a:	dfe080e7          	jalr	-514(ra) # 1294 <kill>
        exit(0);
     49e:	4501                	li	a0,0
     4a0:	00001097          	auipc	ra,0x1
     4a4:	dc4080e7          	jalr	-572(ra) # 1264 <exit>
        printf("grind: fork failed\n");
     4a8:	00001517          	auipc	a0,0x1
     4ac:	3e850513          	addi	a0,a0,1000 # 1890 <malloc+0x1f4>
     4b0:	00001097          	auipc	ra,0x1
     4b4:	134080e7          	jalr	308(ra) # 15e4 <printf>
        exit(1);
     4b8:	4505                	li	a0,1
     4ba:	00001097          	auipc	ra,0x1
     4be:	daa080e7          	jalr	-598(ra) # 1264 <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     4c2:	fa840513          	addi	a0,s0,-88
     4c6:	00001097          	auipc	ra,0x1
     4ca:	dae080e7          	jalr	-594(ra) # 1274 <pipe>
     4ce:	02054b63          	bltz	a0,504 <go+0x48c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     4d2:	00001097          	auipc	ra,0x1
     4d6:	d8a080e7          	jalr	-630(ra) # 125c <fork>
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
     4e8:	da8080e7          	jalr	-600(ra) # 128c <close>
      close(fds[1]);
     4ec:	fac42503          	lw	a0,-84(s0)
     4f0:	00001097          	auipc	ra,0x1
     4f4:	d9c080e7          	jalr	-612(ra) # 128c <close>
      wait(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	d72080e7          	jalr	-654(ra) # 126c <wait>
     502:	b105                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     504:	00001517          	auipc	a0,0x1
     508:	3cc50513          	addi	a0,a0,972 # 18d0 <malloc+0x234>
     50c:	00001097          	auipc	ra,0x1
     510:	0d8080e7          	jalr	216(ra) # 15e4 <printf>
        exit(1);
     514:	4505                	li	a0,1
     516:	00001097          	auipc	ra,0x1
     51a:	d4e080e7          	jalr	-690(ra) # 1264 <exit>
        fork();
     51e:	00001097          	auipc	ra,0x1
     522:	d3e080e7          	jalr	-706(ra) # 125c <fork>
        fork();
     526:	00001097          	auipc	ra,0x1
     52a:	d36080e7          	jalr	-714(ra) # 125c <fork>
        if(write(fds[1], "x", 1) != 1)
     52e:	4605                	li	a2,1
     530:	00001597          	auipc	a1,0x1
     534:	3b858593          	addi	a1,a1,952 # 18e8 <malloc+0x24c>
     538:	fac42503          	lw	a0,-84(s0)
     53c:	00001097          	auipc	ra,0x1
     540:	d48080e7          	jalr	-696(ra) # 1284 <write>
     544:	4785                	li	a5,1
     546:	02f51363          	bne	a0,a5,56c <go+0x4f4>
        if(read(fds[0], &c, 1) != 1)
     54a:	4605                	li	a2,1
     54c:	fa040593          	addi	a1,s0,-96
     550:	fa842503          	lw	a0,-88(s0)
     554:	00001097          	auipc	ra,0x1
     558:	d28080e7          	jalr	-728(ra) # 127c <read>
     55c:	4785                	li	a5,1
     55e:	02f51063          	bne	a0,a5,57e <go+0x506>
        exit(0);
     562:	4501                	li	a0,0
     564:	00001097          	auipc	ra,0x1
     568:	d00080e7          	jalr	-768(ra) # 1264 <exit>
          printf("grind: pipe write failed\n");
     56c:	00001517          	auipc	a0,0x1
     570:	38450513          	addi	a0,a0,900 # 18f0 <malloc+0x254>
     574:	00001097          	auipc	ra,0x1
     578:	070080e7          	jalr	112(ra) # 15e4 <printf>
     57c:	b7f9                	j	54a <go+0x4d2>
          printf("grind: pipe read failed\n");
     57e:	00001517          	auipc	a0,0x1
     582:	39250513          	addi	a0,a0,914 # 1910 <malloc+0x274>
     586:	00001097          	auipc	ra,0x1
     58a:	05e080e7          	jalr	94(ra) # 15e4 <printf>
     58e:	bfd1                	j	562 <go+0x4ea>
        printf("grind: fork failed\n");
     590:	00001517          	auipc	a0,0x1
     594:	30050513          	addi	a0,a0,768 # 1890 <malloc+0x1f4>
     598:	00001097          	auipc	ra,0x1
     59c:	04c080e7          	jalr	76(ra) # 15e4 <printf>
        exit(1);
     5a0:	4505                	li	a0,1
     5a2:	00001097          	auipc	ra,0x1
     5a6:	cc2080e7          	jalr	-830(ra) # 1264 <exit>
    } else if(what == 20){
      int pid = fork();
     5aa:	00001097          	auipc	ra,0x1
     5ae:	cb2080e7          	jalr	-846(ra) # 125c <fork>
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
     5be:	cb2080e7          	jalr	-846(ra) # 126c <wait>
     5c2:	b685                	j	122 <go+0xaa>
        unlink("a");
     5c4:	00001517          	auipc	a0,0x1
     5c8:	2ac50513          	addi	a0,a0,684 # 1870 <malloc+0x1d4>
     5cc:	00001097          	auipc	ra,0x1
     5d0:	ce8080e7          	jalr	-792(ra) # 12b4 <unlink>
        mkdir("a");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	29c50513          	addi	a0,a0,668 # 1870 <malloc+0x1d4>
     5dc:	00001097          	auipc	ra,0x1
     5e0:	cf0080e7          	jalr	-784(ra) # 12cc <mkdir>
        chdir("a");
     5e4:	00001517          	auipc	a0,0x1
     5e8:	28c50513          	addi	a0,a0,652 # 1870 <malloc+0x1d4>
     5ec:	00001097          	auipc	ra,0x1
     5f0:	ce8080e7          	jalr	-792(ra) # 12d4 <chdir>
        unlink("../a");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	1e450513          	addi	a0,a0,484 # 17d8 <malloc+0x13c>
     5fc:	00001097          	auipc	ra,0x1
     600:	cb8080e7          	jalr	-840(ra) # 12b4 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     604:	20200593          	li	a1,514
     608:	00001517          	auipc	a0,0x1
     60c:	2e050513          	addi	a0,a0,736 # 18e8 <malloc+0x24c>
     610:	00001097          	auipc	ra,0x1
     614:	c94080e7          	jalr	-876(ra) # 12a4 <open>
        unlink("x");
     618:	00001517          	auipc	a0,0x1
     61c:	2d050513          	addi	a0,a0,720 # 18e8 <malloc+0x24c>
     620:	00001097          	auipc	ra,0x1
     624:	c94080e7          	jalr	-876(ra) # 12b4 <unlink>
        exit(0);
     628:	4501                	li	a0,0
     62a:	00001097          	auipc	ra,0x1
     62e:	c3a080e7          	jalr	-966(ra) # 1264 <exit>
        printf("grind: fork failed\n");
     632:	00001517          	auipc	a0,0x1
     636:	25e50513          	addi	a0,a0,606 # 1890 <malloc+0x1f4>
     63a:	00001097          	auipc	ra,0x1
     63e:	faa080e7          	jalr	-86(ra) # 15e4 <printf>
        exit(1);
     642:	4505                	li	a0,1
     644:	00001097          	auipc	ra,0x1
     648:	c20080e7          	jalr	-992(ra) # 1264 <exit>
    } else if(what == 21){
      unlink("c");
     64c:	00001517          	auipc	a0,0x1
     650:	2e450513          	addi	a0,a0,740 # 1930 <malloc+0x294>
     654:	00001097          	auipc	ra,0x1
     658:	c60080e7          	jalr	-928(ra) # 12b4 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     65c:	20200593          	li	a1,514
     660:	00001517          	auipc	a0,0x1
     664:	2d050513          	addi	a0,a0,720 # 1930 <malloc+0x294>
     668:	00001097          	auipc	ra,0x1
     66c:	c3c080e7          	jalr	-964(ra) # 12a4 <open>
     670:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     672:	04054f63          	bltz	a0,6d0 <go+0x658>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     676:	4605                	li	a2,1
     678:	00001597          	auipc	a1,0x1
     67c:	27058593          	addi	a1,a1,624 # 18e8 <malloc+0x24c>
     680:	00001097          	auipc	ra,0x1
     684:	c04080e7          	jalr	-1020(ra) # 1284 <write>
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
     698:	c28080e7          	jalr	-984(ra) # 12bc <fstat>
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
     6ba:	bd6080e7          	jalr	-1066(ra) # 128c <close>
      unlink("c");
     6be:	00001517          	auipc	a0,0x1
     6c2:	27250513          	addi	a0,a0,626 # 1930 <malloc+0x294>
     6c6:	00001097          	auipc	ra,0x1
     6ca:	bee080e7          	jalr	-1042(ra) # 12b4 <unlink>
     6ce:	bc91                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     6d0:	00001517          	auipc	a0,0x1
     6d4:	26850513          	addi	a0,a0,616 # 1938 <malloc+0x29c>
     6d8:	00001097          	auipc	ra,0x1
     6dc:	f0c080e7          	jalr	-244(ra) # 15e4 <printf>
        exit(1);
     6e0:	4505                	li	a0,1
     6e2:	00001097          	auipc	ra,0x1
     6e6:	b82080e7          	jalr	-1150(ra) # 1264 <exit>
        printf("grind: write c failed\n");
     6ea:	00001517          	auipc	a0,0x1
     6ee:	26650513          	addi	a0,a0,614 # 1950 <malloc+0x2b4>
     6f2:	00001097          	auipc	ra,0x1
     6f6:	ef2080e7          	jalr	-270(ra) # 15e4 <printf>
        exit(1);
     6fa:	4505                	li	a0,1
     6fc:	00001097          	auipc	ra,0x1
     700:	b68080e7          	jalr	-1176(ra) # 1264 <exit>
        printf("grind: fstat failed\n");
     704:	00001517          	auipc	a0,0x1
     708:	26450513          	addi	a0,a0,612 # 1968 <malloc+0x2cc>
     70c:	00001097          	auipc	ra,0x1
     710:	ed8080e7          	jalr	-296(ra) # 15e4 <printf>
        exit(1);
     714:	4505                	li	a0,1
     716:	00001097          	auipc	ra,0x1
     71a:	b4e080e7          	jalr	-1202(ra) # 1264 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     71e:	2581                	sext.w	a1,a1
     720:	00001517          	auipc	a0,0x1
     724:	26050513          	addi	a0,a0,608 # 1980 <malloc+0x2e4>
     728:	00001097          	auipc	ra,0x1
     72c:	ebc080e7          	jalr	-324(ra) # 15e4 <printf>
        exit(1);
     730:	4505                	li	a0,1
     732:	00001097          	auipc	ra,0x1
     736:	b32080e7          	jalr	-1230(ra) # 1264 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     73a:	00001517          	auipc	a0,0x1
     73e:	26e50513          	addi	a0,a0,622 # 19a8 <malloc+0x30c>
     742:	00001097          	auipc	ra,0x1
     746:	ea2080e7          	jalr	-350(ra) # 15e4 <printf>
        exit(1);
     74a:	4505                	li	a0,1
     74c:	00001097          	auipc	ra,0x1
     750:	b18080e7          	jalr	-1256(ra) # 1264 <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     754:	f9840513          	addi	a0,s0,-104
     758:	00001097          	auipc	ra,0x1
     75c:	b1c080e7          	jalr	-1252(ra) # 1274 <pipe>
     760:	10054063          	bltz	a0,860 <go+0x7e8>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     764:	fa040513          	addi	a0,s0,-96
     768:	00001097          	auipc	ra,0x1
     76c:	b0c080e7          	jalr	-1268(ra) # 1274 <pipe>
     770:	10054663          	bltz	a0,87c <go+0x804>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     774:	00001097          	auipc	ra,0x1
     778:	ae8080e7          	jalr	-1304(ra) # 125c <fork>
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
     788:	ad8080e7          	jalr	-1320(ra) # 125c <fork>
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
     79c:	af4080e7          	jalr	-1292(ra) # 128c <close>
      close(aa[1]);
     7a0:	f9c42503          	lw	a0,-100(s0)
     7a4:	00001097          	auipc	ra,0x1
     7a8:	ae8080e7          	jalr	-1304(ra) # 128c <close>
      close(bb[1]);
     7ac:	fa442503          	lw	a0,-92(s0)
     7b0:	00001097          	auipc	ra,0x1
     7b4:	adc080e7          	jalr	-1316(ra) # 128c <close>
      char buf[4] = { 0, 0, 0, 0 };
     7b8:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     7bc:	4605                	li	a2,1
     7be:	f9040593          	addi	a1,s0,-112
     7c2:	fa042503          	lw	a0,-96(s0)
     7c6:	00001097          	auipc	ra,0x1
     7ca:	ab6080e7          	jalr	-1354(ra) # 127c <read>
      read(bb[0], buf+1, 1);
     7ce:	4605                	li	a2,1
     7d0:	f9140593          	addi	a1,s0,-111
     7d4:	fa042503          	lw	a0,-96(s0)
     7d8:	00001097          	auipc	ra,0x1
     7dc:	aa4080e7          	jalr	-1372(ra) # 127c <read>
      read(bb[0], buf+2, 1);
     7e0:	4605                	li	a2,1
     7e2:	f9240593          	addi	a1,s0,-110
     7e6:	fa042503          	lw	a0,-96(s0)
     7ea:	00001097          	auipc	ra,0x1
     7ee:	a92080e7          	jalr	-1390(ra) # 127c <read>
      close(bb[0]);
     7f2:	fa042503          	lw	a0,-96(s0)
     7f6:	00001097          	auipc	ra,0x1
     7fa:	a96080e7          	jalr	-1386(ra) # 128c <close>
      int st1, st2;
      wait(&st1);
     7fe:	f9440513          	addi	a0,s0,-108
     802:	00001097          	auipc	ra,0x1
     806:	a6a080e7          	jalr	-1430(ra) # 126c <wait>
      wait(&st2);
     80a:	fa840513          	addi	a0,s0,-88
     80e:	00001097          	auipc	ra,0x1
     812:	a5e080e7          	jalr	-1442(ra) # 126c <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     816:	f9442783          	lw	a5,-108(s0)
     81a:	fa842703          	lw	a4,-88(s0)
     81e:	8fd9                	or	a5,a5,a4
     820:	ef89                	bnez	a5,83a <go+0x7c2>
     822:	00001597          	auipc	a1,0x1
     826:	22658593          	addi	a1,a1,550 # 1a48 <malloc+0x3ac>
     82a:	f9040513          	addi	a0,s0,-112
     82e:	00000097          	auipc	ra,0x0
     832:	7e6080e7          	jalr	2022(ra) # 1014 <strcmp>
     836:	8e0506e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     83a:	f9040693          	addi	a3,s0,-112
     83e:	fa842603          	lw	a2,-88(s0)
     842:	f9442583          	lw	a1,-108(s0)
     846:	00001517          	auipc	a0,0x1
     84a:	20a50513          	addi	a0,a0,522 # 1a50 <malloc+0x3b4>
     84e:	00001097          	auipc	ra,0x1
     852:	d96080e7          	jalr	-618(ra) # 15e4 <printf>
        exit(1);
     856:	4505                	li	a0,1
     858:	00001097          	auipc	ra,0x1
     85c:	a0c080e7          	jalr	-1524(ra) # 1264 <exit>
        fprintf(2, "grind: pipe failed\n");
     860:	00001597          	auipc	a1,0x1
     864:	07058593          	addi	a1,a1,112 # 18d0 <malloc+0x234>
     868:	4509                	li	a0,2
     86a:	00001097          	auipc	ra,0x1
     86e:	d4c080e7          	jalr	-692(ra) # 15b6 <fprintf>
        exit(1);
     872:	4505                	li	a0,1
     874:	00001097          	auipc	ra,0x1
     878:	9f0080e7          	jalr	-1552(ra) # 1264 <exit>
        fprintf(2, "grind: pipe failed\n");
     87c:	00001597          	auipc	a1,0x1
     880:	05458593          	addi	a1,a1,84 # 18d0 <malloc+0x234>
     884:	4509                	li	a0,2
     886:	00001097          	auipc	ra,0x1
     88a:	d30080e7          	jalr	-720(ra) # 15b6 <fprintf>
        exit(1);
     88e:	4505                	li	a0,1
     890:	00001097          	auipc	ra,0x1
     894:	9d4080e7          	jalr	-1580(ra) # 1264 <exit>
        close(bb[0]);
     898:	fa042503          	lw	a0,-96(s0)
     89c:	00001097          	auipc	ra,0x1
     8a0:	9f0080e7          	jalr	-1552(ra) # 128c <close>
        close(bb[1]);
     8a4:	fa442503          	lw	a0,-92(s0)
     8a8:	00001097          	auipc	ra,0x1
     8ac:	9e4080e7          	jalr	-1564(ra) # 128c <close>
        close(aa[0]);
     8b0:	f9842503          	lw	a0,-104(s0)
     8b4:	00001097          	auipc	ra,0x1
     8b8:	9d8080e7          	jalr	-1576(ra) # 128c <close>
        close(1);
     8bc:	4505                	li	a0,1
     8be:	00001097          	auipc	ra,0x1
     8c2:	9ce080e7          	jalr	-1586(ra) # 128c <close>
        if(dup(aa[1]) != 1){
     8c6:	f9c42503          	lw	a0,-100(s0)
     8ca:	00001097          	auipc	ra,0x1
     8ce:	a12080e7          	jalr	-1518(ra) # 12dc <dup>
     8d2:	4785                	li	a5,1
     8d4:	02f50063          	beq	a0,a5,8f4 <go+0x87c>
          fprintf(2, "grind: dup failed\n");
     8d8:	00001597          	auipc	a1,0x1
     8dc:	0f858593          	addi	a1,a1,248 # 19d0 <malloc+0x334>
     8e0:	4509                	li	a0,2
     8e2:	00001097          	auipc	ra,0x1
     8e6:	cd4080e7          	jalr	-812(ra) # 15b6 <fprintf>
          exit(1);
     8ea:	4505                	li	a0,1
     8ec:	00001097          	auipc	ra,0x1
     8f0:	978080e7          	jalr	-1672(ra) # 1264 <exit>
        close(aa[1]);
     8f4:	f9c42503          	lw	a0,-100(s0)
     8f8:	00001097          	auipc	ra,0x1
     8fc:	994080e7          	jalr	-1644(ra) # 128c <close>
        char *args[3] = { "echo", "hi", 0 };
     900:	00001797          	auipc	a5,0x1
     904:	0e878793          	addi	a5,a5,232 # 19e8 <malloc+0x34c>
     908:	faf43423          	sd	a5,-88(s0)
     90c:	00001797          	auipc	a5,0x1
     910:	0e478793          	addi	a5,a5,228 # 19f0 <malloc+0x354>
     914:	faf43823          	sd	a5,-80(s0)
     918:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     91c:	fa840593          	addi	a1,s0,-88
     920:	00001517          	auipc	a0,0x1
     924:	0d850513          	addi	a0,a0,216 # 19f8 <malloc+0x35c>
     928:	00001097          	auipc	ra,0x1
     92c:	974080e7          	jalr	-1676(ra) # 129c <exec>
        fprintf(2, "grind: echo: not found\n");
     930:	00001597          	auipc	a1,0x1
     934:	0d858593          	addi	a1,a1,216 # 1a08 <malloc+0x36c>
     938:	4509                	li	a0,2
     93a:	00001097          	auipc	ra,0x1
     93e:	c7c080e7          	jalr	-900(ra) # 15b6 <fprintf>
        exit(2);
     942:	4509                	li	a0,2
     944:	00001097          	auipc	ra,0x1
     948:	920080e7          	jalr	-1760(ra) # 1264 <exit>
        fprintf(2, "grind: fork failed\n");
     94c:	00001597          	auipc	a1,0x1
     950:	f4458593          	addi	a1,a1,-188 # 1890 <malloc+0x1f4>
     954:	4509                	li	a0,2
     956:	00001097          	auipc	ra,0x1
     95a:	c60080e7          	jalr	-928(ra) # 15b6 <fprintf>
        exit(3);
     95e:	450d                	li	a0,3
     960:	00001097          	auipc	ra,0x1
     964:	904080e7          	jalr	-1788(ra) # 1264 <exit>
        close(aa[1]);
     968:	f9c42503          	lw	a0,-100(s0)
     96c:	00001097          	auipc	ra,0x1
     970:	920080e7          	jalr	-1760(ra) # 128c <close>
        close(bb[0]);
     974:	fa042503          	lw	a0,-96(s0)
     978:	00001097          	auipc	ra,0x1
     97c:	914080e7          	jalr	-1772(ra) # 128c <close>
        close(0);
     980:	4501                	li	a0,0
     982:	00001097          	auipc	ra,0x1
     986:	90a080e7          	jalr	-1782(ra) # 128c <close>
        if(dup(aa[0]) != 0){
     98a:	f9842503          	lw	a0,-104(s0)
     98e:	00001097          	auipc	ra,0x1
     992:	94e080e7          	jalr	-1714(ra) # 12dc <dup>
     996:	cd19                	beqz	a0,9b4 <go+0x93c>
          fprintf(2, "grind: dup failed\n");
     998:	00001597          	auipc	a1,0x1
     99c:	03858593          	addi	a1,a1,56 # 19d0 <malloc+0x334>
     9a0:	4509                	li	a0,2
     9a2:	00001097          	auipc	ra,0x1
     9a6:	c14080e7          	jalr	-1004(ra) # 15b6 <fprintf>
          exit(4);
     9aa:	4511                	li	a0,4
     9ac:	00001097          	auipc	ra,0x1
     9b0:	8b8080e7          	jalr	-1864(ra) # 1264 <exit>
        close(aa[0]);
     9b4:	f9842503          	lw	a0,-104(s0)
     9b8:	00001097          	auipc	ra,0x1
     9bc:	8d4080e7          	jalr	-1836(ra) # 128c <close>
        close(1);
     9c0:	4505                	li	a0,1
     9c2:	00001097          	auipc	ra,0x1
     9c6:	8ca080e7          	jalr	-1846(ra) # 128c <close>
        if(dup(bb[1]) != 1){
     9ca:	fa442503          	lw	a0,-92(s0)
     9ce:	00001097          	auipc	ra,0x1
     9d2:	90e080e7          	jalr	-1778(ra) # 12dc <dup>
     9d6:	4785                	li	a5,1
     9d8:	02f50063          	beq	a0,a5,9f8 <go+0x980>
          fprintf(2, "grind: dup failed\n");
     9dc:	00001597          	auipc	a1,0x1
     9e0:	ff458593          	addi	a1,a1,-12 # 19d0 <malloc+0x334>
     9e4:	4509                	li	a0,2
     9e6:	00001097          	auipc	ra,0x1
     9ea:	bd0080e7          	jalr	-1072(ra) # 15b6 <fprintf>
          exit(5);
     9ee:	4515                	li	a0,5
     9f0:	00001097          	auipc	ra,0x1
     9f4:	874080e7          	jalr	-1932(ra) # 1264 <exit>
        close(bb[1]);
     9f8:	fa442503          	lw	a0,-92(s0)
     9fc:	00001097          	auipc	ra,0x1
     a00:	890080e7          	jalr	-1904(ra) # 128c <close>
        char *args[2] = { "cat", 0 };
     a04:	00001797          	auipc	a5,0x1
     a08:	01c78793          	addi	a5,a5,28 # 1a20 <malloc+0x384>
     a0c:	faf43423          	sd	a5,-88(s0)
     a10:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a14:	fa840593          	addi	a1,s0,-88
     a18:	00001517          	auipc	a0,0x1
     a1c:	01050513          	addi	a0,a0,16 # 1a28 <malloc+0x38c>
     a20:	00001097          	auipc	ra,0x1
     a24:	87c080e7          	jalr	-1924(ra) # 129c <exec>
        fprintf(2, "grind: cat: not found\n");
     a28:	00001597          	auipc	a1,0x1
     a2c:	00858593          	addi	a1,a1,8 # 1a30 <malloc+0x394>
     a30:	4509                	li	a0,2
     a32:	00001097          	auipc	ra,0x1
     a36:	b84080e7          	jalr	-1148(ra) # 15b6 <fprintf>
        exit(6);
     a3a:	4519                	li	a0,6
     a3c:	00001097          	auipc	ra,0x1
     a40:	828080e7          	jalr	-2008(ra) # 1264 <exit>
        fprintf(2, "grind: fork failed\n");
     a44:	00001597          	auipc	a1,0x1
     a48:	e4c58593          	addi	a1,a1,-436 # 1890 <malloc+0x1f4>
     a4c:	4509                	li	a0,2
     a4e:	00001097          	auipc	ra,0x1
     a52:	b68080e7          	jalr	-1176(ra) # 15b6 <fprintf>
        exit(7);
     a56:	451d                	li	a0,7
     a58:	00001097          	auipc	ra,0x1
     a5c:	80c080e7          	jalr	-2036(ra) # 1264 <exit>

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
     a70:	e0450513          	addi	a0,a0,-508 # 1870 <malloc+0x1d4>
     a74:	00001097          	auipc	ra,0x1
     a78:	840080e7          	jalr	-1984(ra) # 12b4 <unlink>
  unlink("b");
     a7c:	00001517          	auipc	a0,0x1
     a80:	da450513          	addi	a0,a0,-604 # 1820 <malloc+0x184>
     a84:	00001097          	auipc	ra,0x1
     a88:	830080e7          	jalr	-2000(ra) # 12b4 <unlink>
  
  int pid1 = fork();
     a8c:	00000097          	auipc	ra,0x0
     a90:	7d0080e7          	jalr	2000(ra) # 125c <fork>
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
     aba:	dda50513          	addi	a0,a0,-550 # 1890 <malloc+0x1f4>
     abe:	00001097          	auipc	ra,0x1
     ac2:	b26080e7          	jalr	-1242(ra) # 15e4 <printf>
    exit(1);
     ac6:	4505                	li	a0,1
     ac8:	00000097          	auipc	ra,0x0
     acc:	79c080e7          	jalr	1948(ra) # 1264 <exit>
    exit(0);
  }

  int pid2 = fork();
     ad0:	00000097          	auipc	ra,0x0
     ad4:	78c080e7          	jalr	1932(ra) # 125c <fork>
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
     aec:	c0970713          	addi	a4,a4,-1015 # 1c09 <malloc+0x56d>
     af0:	8fb9                	xor	a5,a5,a4
     af2:	e29c                	sd	a5,0(a3)
    go(1);
     af4:	4505                	li	a0,1
     af6:	fffff097          	auipc	ra,0xfffff
     afa:	582080e7          	jalr	1410(ra) # 78 <go>
    printf("grind: fork failed\n");
     afe:	00001517          	auipc	a0,0x1
     b02:	d9250513          	addi	a0,a0,-622 # 1890 <malloc+0x1f4>
     b06:	00001097          	auipc	ra,0x1
     b0a:	ade080e7          	jalr	-1314(ra) # 15e4 <printf>
    exit(1);
     b0e:	4505                	li	a0,1
     b10:	00000097          	auipc	ra,0x0
     b14:	754080e7          	jalr	1876(ra) # 1264 <exit>
    exit(0);
  }

  int st1 = -1;
     b18:	57fd                	li	a5,-1
     b1a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b1e:	fdc40513          	addi	a0,s0,-36
     b22:	00000097          	auipc	ra,0x0
     b26:	74a080e7          	jalr	1866(ra) # 126c <wait>
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
     b3e:	732080e7          	jalr	1842(ra) # 126c <wait>

  exit(0);
     b42:	4501                	li	a0,0
     b44:	00000097          	auipc	ra,0x0
     b48:	720080e7          	jalr	1824(ra) # 1264 <exit>
    kill(pid1);
     b4c:	8526                	mv	a0,s1
     b4e:	00000097          	auipc	ra,0x0
     b52:	746080e7          	jalr	1862(ra) # 1294 <kill>
    kill(pid2);
     b56:	854a                	mv	a0,s2
     b58:	00000097          	auipc	ra,0x0
     b5c:	73c080e7          	jalr	1852(ra) # 1294 <kill>
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
     b84:	774080e7          	jalr	1908(ra) # 12f4 <sleep>
    rand_next += 1;
     b88:	609c                	ld	a5,0(s1)
     b8a:	0785                	addi	a5,a5,1
     b8c:	e09c                	sd	a5,0(s1)
    int pid = fork();
     b8e:	00000097          	auipc	ra,0x0
     b92:	6ce080e7          	jalr	1742(ra) # 125c <fork>
    if(pid == 0){
     b96:	d165                	beqz	a0,b76 <main+0x14>
    if(pid > 0){
     b98:	fea053e3          	blez	a0,b7e <main+0x1c>
      wait(0);
     b9c:	4501                	li	a0,0
     b9e:	00000097          	auipc	ra,0x0
     ba2:	6ce080e7          	jalr	1742(ra) # 126c <wait>
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
     bdc:	2dc080e7          	jalr	732(ra) # eb4 <twhoami>
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
     c28:	eb450513          	addi	a0,a0,-332 # 1ad8 <malloc+0x43c>
     c2c:	00001097          	auipc	ra,0x1
     c30:	9b8080e7          	jalr	-1608(ra) # 15e4 <printf>
        exit(-1);
     c34:	557d                	li	a0,-1
     c36:	00000097          	auipc	ra,0x0
     c3a:	62e080e7          	jalr	1582(ra) # 1264 <exit>
    {
        // give up the cpu for other threads
        tyield();
     c3e:	00000097          	auipc	ra,0x0
     c42:	252080e7          	jalr	594(ra) # e90 <tyield>
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
     c5c:	25c080e7          	jalr	604(ra) # eb4 <twhoami>
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
     ca0:	1f4080e7          	jalr	500(ra) # e90 <tyield>
}
     ca4:	60e2                	ld	ra,24(sp)
     ca6:	6442                	ld	s0,16(sp)
     ca8:	64a2                	ld	s1,8(sp)
     caa:	6105                	addi	sp,sp,32
     cac:	8082                	ret
        printf("releasing lock we are not holding");
     cae:	00001517          	auipc	a0,0x1
     cb2:	e5250513          	addi	a0,a0,-430 # 1b00 <malloc+0x464>
     cb6:	00001097          	auipc	ra,0x1
     cba:	92e080e7          	jalr	-1746(ra) # 15e4 <printf>
        exit(-1);
     cbe:	557d                	li	a0,-1
     cc0:	00000097          	auipc	ra,0x0
     cc4:	5a4080e7          	jalr	1444(ra) # 1264 <exit>

0000000000000cc8 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
     cc8:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     cca:	00001617          	auipc	a2,0x1
     cce:	73e60613          	addi	a2,a2,1854 # 2408 <threads>
     cd2:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
     cd4:	45c1                	li	a1,16
     cd6:	a021                	j	cde <tsched+0x16>
     cd8:	2685                	addiw	a3,a3,1
     cda:	08b68c63          	beq	a3,a1,d72 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
     cde:	41f6d71b          	sraiw	a4,a3,0x1f
     ce2:	01c7571b          	srliw	a4,a4,0x1c
     ce6:	00d707bb          	addw	a5,a4,a3
     cea:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     cec:	9f99                	subw	a5,a5,a4
     cee:	078e                	slli	a5,a5,0x3
     cf0:	97b2                	add	a5,a5,a2
     cf2:	639c                	ld	a5,0(a5)
     cf4:	d3f5                	beqz	a5,cd8 <tsched+0x10>
     cf6:	5fb8                	lw	a4,120(a5)
     cf8:	fea710e3          	bne	a4,a0,cd8 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
     cfc:	00001717          	auipc	a4,0x1
     d00:	70c73703          	ld	a4,1804(a4) # 2408 <threads>
     d04:	5f30                	lw	a2,120(a4)
     d06:	468d                	li	a3,3
     d08:	06d60363          	beq	a2,a3,d6e <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
     d0c:	c3a5                	beqz	a5,d6c <tsched+0xa4>
{
     d0e:	1101                	addi	sp,sp,-32
     d10:	ec06                	sd	ra,24(sp)
     d12:	e822                	sd	s0,16(sp)
     d14:	e426                	sd	s1,8(sp)
     d16:	e04a                	sd	s2,0(sp)
     d18:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
     d1a:	00001497          	auipc	s1,0x1
     d1e:	2f648493          	addi	s1,s1,758 # 2010 <current_thread>
     d22:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
     d26:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
     d28:	0007c603          	lbu	a2,0(a5)
     d2c:	00094583          	lbu	a1,0(s2)
     d30:	00001517          	auipc	a0,0x1
     d34:	df850513          	addi	a0,a0,-520 # 1b28 <malloc+0x48c>
     d38:	00001097          	auipc	ra,0x1
     d3c:	8ac080e7          	jalr	-1876(ra) # 15e4 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
     d40:	608c                	ld	a1,0(s1)
     d42:	05a1                	addi	a1,a1,8
     d44:	00890513          	addi	a0,s2,8
     d48:	00000097          	auipc	ra,0x0
     d4c:	184080e7          	jalr	388(ra) # ecc <tswtch>
        printf("Thread switch complete\n");
     d50:	00001517          	auipc	a0,0x1
     d54:	e0050513          	addi	a0,a0,-512 # 1b50 <malloc+0x4b4>
     d58:	00001097          	auipc	ra,0x1
     d5c:	88c080e7          	jalr	-1908(ra) # 15e4 <printf>
    }
}
     d60:	60e2                	ld	ra,24(sp)
     d62:	6442                	ld	s0,16(sp)
     d64:	64a2                	ld	s1,8(sp)
     d66:	6902                	ld	s2,0(sp)
     d68:	6105                	addi	sp,sp,32
     d6a:	8082                	ret
     d6c:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
     d6e:	87ba                	mv	a5,a4
     d70:	bf79                	j	d0e <tsched+0x46>
     d72:	00001797          	auipc	a5,0x1
     d76:	6967b783          	ld	a5,1686(a5) # 2408 <threads>
     d7a:	5fb4                	lw	a3,120(a5)
     d7c:	470d                	li	a4,3
     d7e:	f8e688e3          	beq	a3,a4,d0e <tsched+0x46>
     d82:	8082                	ret

0000000000000d84 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     d84:	7179                	addi	sp,sp,-48
     d86:	f406                	sd	ra,40(sp)
     d88:	f022                	sd	s0,32(sp)
     d8a:	ec26                	sd	s1,24(sp)
     d8c:	e84a                	sd	s2,16(sp)
     d8e:	e44e                	sd	s3,8(sp)
     d90:	1800                	addi	s0,sp,48
     d92:	84aa                	mv	s1,a0
     d94:	89b2                	mv	s3,a2
     d96:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     d98:	09000513          	li	a0,144
     d9c:	00001097          	auipc	ra,0x1
     da0:	900080e7          	jalr	-1792(ra) # 169c <malloc>
     da4:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     da6:	478d                	li	a5,3
     da8:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     daa:	609c                	ld	a5,0(s1)
     dac:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
     db0:	609c                	ld	a5,0(s1)
     db2:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
     db6:	00001717          	auipc	a4,0x1
     dba:	25270713          	addi	a4,a4,594 # 2008 <next_tid>
     dbe:	431c                	lw	a5,0(a4)
     dc0:	0017869b          	addiw	a3,a5,1
     dc4:	c314                	sw	a3,0(a4)
     dc6:	6098                	ld	a4,0(s1)
     dc8:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
     dcc:	00001717          	auipc	a4,0x1
     dd0:	63c70713          	addi	a4,a4,1596 # 2408 <threads>
     dd4:	4781                	li	a5,0
     dd6:	4641                	li	a2,16
    if (threads[i] == NULL) {
     dd8:	6314                	ld	a3,0(a4)
     dda:	ce81                	beqz	a3,df2 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
     ddc:	2785                	addiw	a5,a5,1
     dde:	0721                	addi	a4,a4,8
     de0:	fec79ce3          	bne	a5,a2,dd8 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
     de4:	70a2                	ld	ra,40(sp)
     de6:	7402                	ld	s0,32(sp)
     de8:	64e2                	ld	s1,24(sp)
     dea:	6942                	ld	s2,16(sp)
     dec:	69a2                	ld	s3,8(sp)
     dee:	6145                	addi	sp,sp,48
     df0:	8082                	ret
        threads[i] = *thread;
     df2:	6094                	ld	a3,0(s1)
     df4:	078e                	slli	a5,a5,0x3
     df6:	00001717          	auipc	a4,0x1
     dfa:	61270713          	addi	a4,a4,1554 # 2408 <threads>
     dfe:	97ba                	add	a5,a5,a4
     e00:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
     e02:	0006c583          	lbu	a1,0(a3)
     e06:	00001517          	auipc	a0,0x1
     e0a:	d6250513          	addi	a0,a0,-670 # 1b68 <malloc+0x4cc>
     e0e:	00000097          	auipc	ra,0x0
     e12:	7d6080e7          	jalr	2006(ra) # 15e4 <printf>
        break;
     e16:	b7f9                	j	de4 <tcreate+0x60>

0000000000000e18 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
     e18:	7179                	addi	sp,sp,-48
     e1a:	f406                	sd	ra,40(sp)
     e1c:	f022                	sd	s0,32(sp)
     e1e:	ec26                	sd	s1,24(sp)
     e20:	e84a                	sd	s2,16(sp)
     e22:	e44e                	sd	s3,8(sp)
     e24:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
     e26:	00001797          	auipc	a5,0x1
     e2a:	5e278793          	addi	a5,a5,1506 # 2408 <threads>
     e2e:	00001697          	auipc	a3,0x1
     e32:	65a68693          	addi	a3,a3,1626 # 2488 <base>
     e36:	a021                	j	e3e <tjoin+0x26>
     e38:	07a1                	addi	a5,a5,8
     e3a:	04d78763          	beq	a5,a3,e88 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
     e3e:	6384                	ld	s1,0(a5)
     e40:	dce5                	beqz	s1,e38 <tjoin+0x20>
     e42:	0004c703          	lbu	a4,0(s1)
     e46:	fea719e3          	bne	a4,a0,e38 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
     e4a:	5cb8                	lw	a4,120(s1)
     e4c:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
     e4e:	00001997          	auipc	s3,0x1
     e52:	d4a98993          	addi	s3,s3,-694 # 1b98 <malloc+0x4fc>
    while (target_thread->state != EXITED) {
     e56:	4919                	li	s2,6
     e58:	02f70a63          	beq	a4,a5,e8c <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
     e5c:	0004c583          	lbu	a1,0(s1)
     e60:	854e                	mv	a0,s3
     e62:	00000097          	auipc	ra,0x0
     e66:	782080e7          	jalr	1922(ra) # 15e4 <printf>
        tsched();
     e6a:	00000097          	auipc	ra,0x0
     e6e:	e5e080e7          	jalr	-418(ra) # cc8 <tsched>
    while (target_thread->state != EXITED) {
     e72:	5cbc                	lw	a5,120(s1)
     e74:	ff2794e3          	bne	a5,s2,e5c <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
     e78:	4501                	li	a0,0
}
     e7a:	70a2                	ld	ra,40(sp)
     e7c:	7402                	ld	s0,32(sp)
     e7e:	64e2                	ld	s1,24(sp)
     e80:	6942                	ld	s2,16(sp)
     e82:	69a2                	ld	s3,8(sp)
     e84:	6145                	addi	sp,sp,48
     e86:	8082                	ret
        return -1;
     e88:	557d                	li	a0,-1
     e8a:	bfc5                	j	e7a <tjoin+0x62>
    return 0;
     e8c:	4501                	li	a0,0
     e8e:	b7f5                	j	e7a <tjoin+0x62>

0000000000000e90 <tyield>:


void tyield()
{
     e90:	1141                	addi	sp,sp,-16
     e92:	e406                	sd	ra,8(sp)
     e94:	e022                	sd	s0,0(sp)
     e96:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
     e98:	00001797          	auipc	a5,0x1
     e9c:	1787b783          	ld	a5,376(a5) # 2010 <current_thread>
     ea0:	470d                	li	a4,3
     ea2:	dfb8                	sw	a4,120(a5)
    tsched();
     ea4:	00000097          	auipc	ra,0x0
     ea8:	e24080e7          	jalr	-476(ra) # cc8 <tsched>
}
     eac:	60a2                	ld	ra,8(sp)
     eae:	6402                	ld	s0,0(sp)
     eb0:	0141                	addi	sp,sp,16
     eb2:	8082                	ret

0000000000000eb4 <twhoami>:

uint8 twhoami()
{
     eb4:	1141                	addi	sp,sp,-16
     eb6:	e422                	sd	s0,8(sp)
     eb8:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
     eba:	00001797          	auipc	a5,0x1
     ebe:	1567b783          	ld	a5,342(a5) # 2010 <current_thread>
     ec2:	0007c503          	lbu	a0,0(a5)
     ec6:	6422                	ld	s0,8(sp)
     ec8:	0141                	addi	sp,sp,16
     eca:	8082                	ret

0000000000000ecc <tswtch>:
     ecc:	00153023          	sd	ra,0(a0)
     ed0:	00253423          	sd	sp,8(a0)
     ed4:	e900                	sd	s0,16(a0)
     ed6:	ed04                	sd	s1,24(a0)
     ed8:	03253023          	sd	s2,32(a0)
     edc:	03353423          	sd	s3,40(a0)
     ee0:	03453823          	sd	s4,48(a0)
     ee4:	03553c23          	sd	s5,56(a0)
     ee8:	05653023          	sd	s6,64(a0)
     eec:	05753423          	sd	s7,72(a0)
     ef0:	05853823          	sd	s8,80(a0)
     ef4:	05953c23          	sd	s9,88(a0)
     ef8:	07a53023          	sd	s10,96(a0)
     efc:	07b53423          	sd	s11,104(a0)
     f00:	0005b083          	ld	ra,0(a1)
     f04:	0085b103          	ld	sp,8(a1)
     f08:	6980                	ld	s0,16(a1)
     f0a:	6d84                	ld	s1,24(a1)
     f0c:	0205b903          	ld	s2,32(a1)
     f10:	0285b983          	ld	s3,40(a1)
     f14:	0305ba03          	ld	s4,48(a1)
     f18:	0385ba83          	ld	s5,56(a1)
     f1c:	0405bb03          	ld	s6,64(a1)
     f20:	0485bb83          	ld	s7,72(a1)
     f24:	0505bc03          	ld	s8,80(a1)
     f28:	0585bc83          	ld	s9,88(a1)
     f2c:	0605bd03          	ld	s10,96(a1)
     f30:	0685bd83          	ld	s11,104(a1)
     f34:	8082                	ret

0000000000000f36 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     f36:	715d                	addi	sp,sp,-80
     f38:	e486                	sd	ra,72(sp)
     f3a:	e0a2                	sd	s0,64(sp)
     f3c:	fc26                	sd	s1,56(sp)
     f3e:	f84a                	sd	s2,48(sp)
     f40:	f44e                	sd	s3,40(sp)
     f42:	f052                	sd	s4,32(sp)
     f44:	ec56                	sd	s5,24(sp)
     f46:	e85a                	sd	s6,16(sp)
     f48:	e45e                	sd	s7,8(sp)
     f4a:	0880                	addi	s0,sp,80
     f4c:	892a                	mv	s2,a0
     f4e:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
     f50:	00001517          	auipc	a0,0x1
     f54:	c6850513          	addi	a0,a0,-920 # 1bb8 <malloc+0x51c>
     f58:	00000097          	auipc	ra,0x0
     f5c:	68c080e7          	jalr	1676(ra) # 15e4 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     f60:	09000513          	li	a0,144
     f64:	00000097          	auipc	ra,0x0
     f68:	738080e7          	jalr	1848(ra) # 169c <malloc>

    main_thread->tid = 0;
     f6c:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
     f70:	4791                	li	a5,4
     f72:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
     f74:	00001797          	auipc	a5,0x1
     f78:	08a7be23          	sd	a0,156(a5) # 2010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
     f7c:	00001a17          	auipc	s4,0x1
     f80:	48ca0a13          	addi	s4,s4,1164 # 2408 <threads>
     f84:	00001497          	auipc	s1,0x1
     f88:	50448493          	addi	s1,s1,1284 # 2488 <base>
    current_thread = main_thread;
     f8c:	87d2                	mv	a5,s4
        threads[i] = NULL;
     f8e:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
     f92:	07a1                	addi	a5,a5,8
     f94:	fe979de3          	bne	a5,s1,f8e <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
     f98:	00001797          	auipc	a5,0x1
     f9c:	46a7b823          	sd	a0,1136(a5) # 2408 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     fa0:	85ce                	mv	a1,s3
     fa2:	854a                	mv	a0,s2
     fa4:	00000097          	auipc	ra,0x0
     fa8:	bbe080e7          	jalr	-1090(ra) # b62 <main>
     fac:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
     fae:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
     fb0:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
     fb2:	00001a97          	auipc	s5,0x1
     fb6:	c26a8a93          	addi	s5,s5,-986 # 1bd8 <malloc+0x53c>
     fba:	a03d                	j	fe8 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
     fbc:	07a1                	addi	a5,a5,8
     fbe:	00978963          	beq	a5,s1,fd0 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
     fc2:	6398                	ld	a4,0(a5)
     fc4:	df65                	beqz	a4,fbc <_main+0x86>
     fc6:	5f38                	lw	a4,120(a4)
     fc8:	ff370ae3          	beq	a4,s3,fbc <_main+0x86>
                running_threads++;
     fcc:	2905                	addiw	s2,s2,1
     fce:	b7fd                	j	fbc <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
     fd0:	85ca                	mv	a1,s2
     fd2:	8556                	mv	a0,s5
     fd4:	00000097          	auipc	ra,0x0
     fd8:	610080e7          	jalr	1552(ra) # 15e4 <printf>
        if (running_threads > 0) {
     fdc:	01205963          	blez	s2,fee <_main+0xb8>
            tsched(); // Schedule another thread to run
     fe0:	00000097          	auipc	ra,0x0
     fe4:	ce8080e7          	jalr	-792(ra) # cc8 <tsched>
    current_thread = main_thread;
     fe8:	87d2                	mv	a5,s4
        running_threads = 0;
     fea:	895a                	mv	s2,s6
     fec:	bfd9                	j	fc2 <_main+0x8c>
        }
    }

    exit(res);
     fee:	855e                	mv	a0,s7
     ff0:	00000097          	auipc	ra,0x0
     ff4:	274080e7          	jalr	628(ra) # 1264 <exit>

0000000000000ff8 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     ff8:	1141                	addi	sp,sp,-16
     ffa:	e422                	sd	s0,8(sp)
     ffc:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
     ffe:	87aa                	mv	a5,a0
    1000:	0585                	addi	a1,a1,1
    1002:	0785                	addi	a5,a5,1
    1004:	fff5c703          	lbu	a4,-1(a1)
    1008:	fee78fa3          	sb	a4,-1(a5)
    100c:	fb75                	bnez	a4,1000 <strcpy+0x8>
        ;
    return os;
}
    100e:	6422                	ld	s0,8(sp)
    1010:	0141                	addi	sp,sp,16
    1012:	8082                	ret

0000000000001014 <strcmp>:

int strcmp(const char *p, const char *q)
{
    1014:	1141                	addi	sp,sp,-16
    1016:	e422                	sd	s0,8(sp)
    1018:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
    101a:	00054783          	lbu	a5,0(a0)
    101e:	cb91                	beqz	a5,1032 <strcmp+0x1e>
    1020:	0005c703          	lbu	a4,0(a1)
    1024:	00f71763          	bne	a4,a5,1032 <strcmp+0x1e>
        p++, q++;
    1028:	0505                	addi	a0,a0,1
    102a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
    102c:	00054783          	lbu	a5,0(a0)
    1030:	fbe5                	bnez	a5,1020 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
    1032:	0005c503          	lbu	a0,0(a1)
}
    1036:	40a7853b          	subw	a0,a5,a0
    103a:	6422                	ld	s0,8(sp)
    103c:	0141                	addi	sp,sp,16
    103e:	8082                	ret

0000000000001040 <strlen>:

uint strlen(const char *s)
{
    1040:	1141                	addi	sp,sp,-16
    1042:	e422                	sd	s0,8(sp)
    1044:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
    1046:	00054783          	lbu	a5,0(a0)
    104a:	cf91                	beqz	a5,1066 <strlen+0x26>
    104c:	0505                	addi	a0,a0,1
    104e:	87aa                	mv	a5,a0
    1050:	86be                	mv	a3,a5
    1052:	0785                	addi	a5,a5,1
    1054:	fff7c703          	lbu	a4,-1(a5)
    1058:	ff65                	bnez	a4,1050 <strlen+0x10>
    105a:	40a6853b          	subw	a0,a3,a0
    105e:	2505                	addiw	a0,a0,1
        ;
    return n;
}
    1060:	6422                	ld	s0,8(sp)
    1062:	0141                	addi	sp,sp,16
    1064:	8082                	ret
    for (n = 0; s[n]; n++)
    1066:	4501                	li	a0,0
    1068:	bfe5                	j	1060 <strlen+0x20>

000000000000106a <memset>:

void *
memset(void *dst, int c, uint n)
{
    106a:	1141                	addi	sp,sp,-16
    106c:	e422                	sd	s0,8(sp)
    106e:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
    1070:	ca19                	beqz	a2,1086 <memset+0x1c>
    1072:	87aa                	mv	a5,a0
    1074:	1602                	slli	a2,a2,0x20
    1076:	9201                	srli	a2,a2,0x20
    1078:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
    107c:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
    1080:	0785                	addi	a5,a5,1
    1082:	fee79de3          	bne	a5,a4,107c <memset+0x12>
    }
    return dst;
}
    1086:	6422                	ld	s0,8(sp)
    1088:	0141                	addi	sp,sp,16
    108a:	8082                	ret

000000000000108c <strchr>:

char *
strchr(const char *s, char c)
{
    108c:	1141                	addi	sp,sp,-16
    108e:	e422                	sd	s0,8(sp)
    1090:	0800                	addi	s0,sp,16
    for (; *s; s++)
    1092:	00054783          	lbu	a5,0(a0)
    1096:	cb99                	beqz	a5,10ac <strchr+0x20>
        if (*s == c)
    1098:	00f58763          	beq	a1,a5,10a6 <strchr+0x1a>
    for (; *s; s++)
    109c:	0505                	addi	a0,a0,1
    109e:	00054783          	lbu	a5,0(a0)
    10a2:	fbfd                	bnez	a5,1098 <strchr+0xc>
            return (char *)s;
    return 0;
    10a4:	4501                	li	a0,0
}
    10a6:	6422                	ld	s0,8(sp)
    10a8:	0141                	addi	sp,sp,16
    10aa:	8082                	ret
    return 0;
    10ac:	4501                	li	a0,0
    10ae:	bfe5                	j	10a6 <strchr+0x1a>

00000000000010b0 <gets>:

char *
gets(char *buf, int max)
{
    10b0:	711d                	addi	sp,sp,-96
    10b2:	ec86                	sd	ra,88(sp)
    10b4:	e8a2                	sd	s0,80(sp)
    10b6:	e4a6                	sd	s1,72(sp)
    10b8:	e0ca                	sd	s2,64(sp)
    10ba:	fc4e                	sd	s3,56(sp)
    10bc:	f852                	sd	s4,48(sp)
    10be:	f456                	sd	s5,40(sp)
    10c0:	f05a                	sd	s6,32(sp)
    10c2:	ec5e                	sd	s7,24(sp)
    10c4:	1080                	addi	s0,sp,96
    10c6:	8baa                	mv	s7,a0
    10c8:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
    10ca:	892a                	mv	s2,a0
    10cc:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
    10ce:	4aa9                	li	s5,10
    10d0:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
    10d2:	89a6                	mv	s3,s1
    10d4:	2485                	addiw	s1,s1,1
    10d6:	0344d863          	bge	s1,s4,1106 <gets+0x56>
        cc = read(0, &c, 1);
    10da:	4605                	li	a2,1
    10dc:	faf40593          	addi	a1,s0,-81
    10e0:	4501                	li	a0,0
    10e2:	00000097          	auipc	ra,0x0
    10e6:	19a080e7          	jalr	410(ra) # 127c <read>
        if (cc < 1)
    10ea:	00a05e63          	blez	a0,1106 <gets+0x56>
        buf[i++] = c;
    10ee:	faf44783          	lbu	a5,-81(s0)
    10f2:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
    10f6:	01578763          	beq	a5,s5,1104 <gets+0x54>
    10fa:	0905                	addi	s2,s2,1
    10fc:	fd679be3          	bne	a5,s6,10d2 <gets+0x22>
    for (i = 0; i + 1 < max;)
    1100:	89a6                	mv	s3,s1
    1102:	a011                	j	1106 <gets+0x56>
    1104:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
    1106:	99de                	add	s3,s3,s7
    1108:	00098023          	sb	zero,0(s3)
    return buf;
}
    110c:	855e                	mv	a0,s7
    110e:	60e6                	ld	ra,88(sp)
    1110:	6446                	ld	s0,80(sp)
    1112:	64a6                	ld	s1,72(sp)
    1114:	6906                	ld	s2,64(sp)
    1116:	79e2                	ld	s3,56(sp)
    1118:	7a42                	ld	s4,48(sp)
    111a:	7aa2                	ld	s5,40(sp)
    111c:	7b02                	ld	s6,32(sp)
    111e:	6be2                	ld	s7,24(sp)
    1120:	6125                	addi	sp,sp,96
    1122:	8082                	ret

0000000000001124 <stat>:

int stat(const char *n, struct stat *st)
{
    1124:	1101                	addi	sp,sp,-32
    1126:	ec06                	sd	ra,24(sp)
    1128:	e822                	sd	s0,16(sp)
    112a:	e426                	sd	s1,8(sp)
    112c:	e04a                	sd	s2,0(sp)
    112e:	1000                	addi	s0,sp,32
    1130:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    1132:	4581                	li	a1,0
    1134:	00000097          	auipc	ra,0x0
    1138:	170080e7          	jalr	368(ra) # 12a4 <open>
    if (fd < 0)
    113c:	02054563          	bltz	a0,1166 <stat+0x42>
    1140:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
    1142:	85ca                	mv	a1,s2
    1144:	00000097          	auipc	ra,0x0
    1148:	178080e7          	jalr	376(ra) # 12bc <fstat>
    114c:	892a                	mv	s2,a0
    close(fd);
    114e:	8526                	mv	a0,s1
    1150:	00000097          	auipc	ra,0x0
    1154:	13c080e7          	jalr	316(ra) # 128c <close>
    return r;
}
    1158:	854a                	mv	a0,s2
    115a:	60e2                	ld	ra,24(sp)
    115c:	6442                	ld	s0,16(sp)
    115e:	64a2                	ld	s1,8(sp)
    1160:	6902                	ld	s2,0(sp)
    1162:	6105                	addi	sp,sp,32
    1164:	8082                	ret
        return -1;
    1166:	597d                	li	s2,-1
    1168:	bfc5                	j	1158 <stat+0x34>

000000000000116a <atoi>:

int atoi(const char *s)
{
    116a:	1141                	addi	sp,sp,-16
    116c:	e422                	sd	s0,8(sp)
    116e:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
    1170:	00054683          	lbu	a3,0(a0)
    1174:	fd06879b          	addiw	a5,a3,-48
    1178:	0ff7f793          	zext.b	a5,a5
    117c:	4625                	li	a2,9
    117e:	02f66863          	bltu	a2,a5,11ae <atoi+0x44>
    1182:	872a                	mv	a4,a0
    n = 0;
    1184:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
    1186:	0705                	addi	a4,a4,1
    1188:	0025179b          	slliw	a5,a0,0x2
    118c:	9fa9                	addw	a5,a5,a0
    118e:	0017979b          	slliw	a5,a5,0x1
    1192:	9fb5                	addw	a5,a5,a3
    1194:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    1198:	00074683          	lbu	a3,0(a4)
    119c:	fd06879b          	addiw	a5,a3,-48
    11a0:	0ff7f793          	zext.b	a5,a5
    11a4:	fef671e3          	bgeu	a2,a5,1186 <atoi+0x1c>
    return n;
}
    11a8:	6422                	ld	s0,8(sp)
    11aa:	0141                	addi	sp,sp,16
    11ac:	8082                	ret
    n = 0;
    11ae:	4501                	li	a0,0
    11b0:	bfe5                	j	11a8 <atoi+0x3e>

00000000000011b2 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    11b2:	1141                	addi	sp,sp,-16
    11b4:	e422                	sd	s0,8(sp)
    11b6:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
    11b8:	02b57463          	bgeu	a0,a1,11e0 <memmove+0x2e>
    {
        while (n-- > 0)
    11bc:	00c05f63          	blez	a2,11da <memmove+0x28>
    11c0:	1602                	slli	a2,a2,0x20
    11c2:	9201                	srli	a2,a2,0x20
    11c4:	00c507b3          	add	a5,a0,a2
    dst = vdst;
    11c8:	872a                	mv	a4,a0
            *dst++ = *src++;
    11ca:	0585                	addi	a1,a1,1
    11cc:	0705                	addi	a4,a4,1
    11ce:	fff5c683          	lbu	a3,-1(a1)
    11d2:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    11d6:	fee79ae3          	bne	a5,a4,11ca <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
    11da:	6422                	ld	s0,8(sp)
    11dc:	0141                	addi	sp,sp,16
    11de:	8082                	ret
        dst += n;
    11e0:	00c50733          	add	a4,a0,a2
        src += n;
    11e4:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    11e6:	fec05ae3          	blez	a2,11da <memmove+0x28>
    11ea:	fff6079b          	addiw	a5,a2,-1
    11ee:	1782                	slli	a5,a5,0x20
    11f0:	9381                	srli	a5,a5,0x20
    11f2:	fff7c793          	not	a5,a5
    11f6:	97ba                	add	a5,a5,a4
            *--dst = *--src;
    11f8:	15fd                	addi	a1,a1,-1
    11fa:	177d                	addi	a4,a4,-1
    11fc:	0005c683          	lbu	a3,0(a1)
    1200:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    1204:	fee79ae3          	bne	a5,a4,11f8 <memmove+0x46>
    1208:	bfc9                	j	11da <memmove+0x28>

000000000000120a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    120a:	1141                	addi	sp,sp,-16
    120c:	e422                	sd	s0,8(sp)
    120e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
    1210:	ca05                	beqz	a2,1240 <memcmp+0x36>
    1212:	fff6069b          	addiw	a3,a2,-1
    1216:	1682                	slli	a3,a3,0x20
    1218:	9281                	srli	a3,a3,0x20
    121a:	0685                	addi	a3,a3,1
    121c:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
    121e:	00054783          	lbu	a5,0(a0)
    1222:	0005c703          	lbu	a4,0(a1)
    1226:	00e79863          	bne	a5,a4,1236 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
    122a:	0505                	addi	a0,a0,1
        p2++;
    122c:	0585                	addi	a1,a1,1
    while (n-- > 0)
    122e:	fed518e3          	bne	a0,a3,121e <memcmp+0x14>
    }
    return 0;
    1232:	4501                	li	a0,0
    1234:	a019                	j	123a <memcmp+0x30>
            return *p1 - *p2;
    1236:	40e7853b          	subw	a0,a5,a4
}
    123a:	6422                	ld	s0,8(sp)
    123c:	0141                	addi	sp,sp,16
    123e:	8082                	ret
    return 0;
    1240:	4501                	li	a0,0
    1242:	bfe5                	j	123a <memcmp+0x30>

0000000000001244 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1244:	1141                	addi	sp,sp,-16
    1246:	e406                	sd	ra,8(sp)
    1248:	e022                	sd	s0,0(sp)
    124a:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    124c:	00000097          	auipc	ra,0x0
    1250:	f66080e7          	jalr	-154(ra) # 11b2 <memmove>
}
    1254:	60a2                	ld	ra,8(sp)
    1256:	6402                	ld	s0,0(sp)
    1258:	0141                	addi	sp,sp,16
    125a:	8082                	ret

000000000000125c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    125c:	4885                	li	a7,1
 ecall
    125e:	00000073          	ecall
 ret
    1262:	8082                	ret

0000000000001264 <exit>:
.global exit
exit:
 li a7, SYS_exit
    1264:	4889                	li	a7,2
 ecall
    1266:	00000073          	ecall
 ret
    126a:	8082                	ret

000000000000126c <wait>:
.global wait
wait:
 li a7, SYS_wait
    126c:	488d                	li	a7,3
 ecall
    126e:	00000073          	ecall
 ret
    1272:	8082                	ret

0000000000001274 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    1274:	4891                	li	a7,4
 ecall
    1276:	00000073          	ecall
 ret
    127a:	8082                	ret

000000000000127c <read>:
.global read
read:
 li a7, SYS_read
    127c:	4895                	li	a7,5
 ecall
    127e:	00000073          	ecall
 ret
    1282:	8082                	ret

0000000000001284 <write>:
.global write
write:
 li a7, SYS_write
    1284:	48c1                	li	a7,16
 ecall
    1286:	00000073          	ecall
 ret
    128a:	8082                	ret

000000000000128c <close>:
.global close
close:
 li a7, SYS_close
    128c:	48d5                	li	a7,21
 ecall
    128e:	00000073          	ecall
 ret
    1292:	8082                	ret

0000000000001294 <kill>:
.global kill
kill:
 li a7, SYS_kill
    1294:	4899                	li	a7,6
 ecall
    1296:	00000073          	ecall
 ret
    129a:	8082                	ret

000000000000129c <exec>:
.global exec
exec:
 li a7, SYS_exec
    129c:	489d                	li	a7,7
 ecall
    129e:	00000073          	ecall
 ret
    12a2:	8082                	ret

00000000000012a4 <open>:
.global open
open:
 li a7, SYS_open
    12a4:	48bd                	li	a7,15
 ecall
    12a6:	00000073          	ecall
 ret
    12aa:	8082                	ret

00000000000012ac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    12ac:	48c5                	li	a7,17
 ecall
    12ae:	00000073          	ecall
 ret
    12b2:	8082                	ret

00000000000012b4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    12b4:	48c9                	li	a7,18
 ecall
    12b6:	00000073          	ecall
 ret
    12ba:	8082                	ret

00000000000012bc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    12bc:	48a1                	li	a7,8
 ecall
    12be:	00000073          	ecall
 ret
    12c2:	8082                	ret

00000000000012c4 <link>:
.global link
link:
 li a7, SYS_link
    12c4:	48cd                	li	a7,19
 ecall
    12c6:	00000073          	ecall
 ret
    12ca:	8082                	ret

00000000000012cc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    12cc:	48d1                	li	a7,20
 ecall
    12ce:	00000073          	ecall
 ret
    12d2:	8082                	ret

00000000000012d4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    12d4:	48a5                	li	a7,9
 ecall
    12d6:	00000073          	ecall
 ret
    12da:	8082                	ret

00000000000012dc <dup>:
.global dup
dup:
 li a7, SYS_dup
    12dc:	48a9                	li	a7,10
 ecall
    12de:	00000073          	ecall
 ret
    12e2:	8082                	ret

00000000000012e4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    12e4:	48ad                	li	a7,11
 ecall
    12e6:	00000073          	ecall
 ret
    12ea:	8082                	ret

00000000000012ec <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    12ec:	48b1                	li	a7,12
 ecall
    12ee:	00000073          	ecall
 ret
    12f2:	8082                	ret

00000000000012f4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    12f4:	48b5                	li	a7,13
 ecall
    12f6:	00000073          	ecall
 ret
    12fa:	8082                	ret

00000000000012fc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    12fc:	48b9                	li	a7,14
 ecall
    12fe:	00000073          	ecall
 ret
    1302:	8082                	ret

0000000000001304 <ps>:
.global ps
ps:
 li a7, SYS_ps
    1304:	48d9                	li	a7,22
 ecall
    1306:	00000073          	ecall
 ret
    130a:	8082                	ret

000000000000130c <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
    130c:	48dd                	li	a7,23
 ecall
    130e:	00000073          	ecall
 ret
    1312:	8082                	ret

0000000000001314 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
    1314:	48e1                	li	a7,24
 ecall
    1316:	00000073          	ecall
 ret
    131a:	8082                	ret

000000000000131c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    131c:	1101                	addi	sp,sp,-32
    131e:	ec06                	sd	ra,24(sp)
    1320:	e822                	sd	s0,16(sp)
    1322:	1000                	addi	s0,sp,32
    1324:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    1328:	4605                	li	a2,1
    132a:	fef40593          	addi	a1,s0,-17
    132e:	00000097          	auipc	ra,0x0
    1332:	f56080e7          	jalr	-170(ra) # 1284 <write>
}
    1336:	60e2                	ld	ra,24(sp)
    1338:	6442                	ld	s0,16(sp)
    133a:	6105                	addi	sp,sp,32
    133c:	8082                	ret

000000000000133e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    133e:	7139                	addi	sp,sp,-64
    1340:	fc06                	sd	ra,56(sp)
    1342:	f822                	sd	s0,48(sp)
    1344:	f426                	sd	s1,40(sp)
    1346:	f04a                	sd	s2,32(sp)
    1348:	ec4e                	sd	s3,24(sp)
    134a:	0080                	addi	s0,sp,64
    134c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    134e:	c299                	beqz	a3,1354 <printint+0x16>
    1350:	0805c963          	bltz	a1,13e2 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1354:	2581                	sext.w	a1,a1
  neg = 0;
    1356:	4881                	li	a7,0
    1358:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    135c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    135e:	2601                	sext.w	a2,a2
    1360:	00001517          	auipc	a0,0x1
    1364:	8f850513          	addi	a0,a0,-1800 # 1c58 <digits>
    1368:	883a                	mv	a6,a4
    136a:	2705                	addiw	a4,a4,1
    136c:	02c5f7bb          	remuw	a5,a1,a2
    1370:	1782                	slli	a5,a5,0x20
    1372:	9381                	srli	a5,a5,0x20
    1374:	97aa                	add	a5,a5,a0
    1376:	0007c783          	lbu	a5,0(a5)
    137a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    137e:	0005879b          	sext.w	a5,a1
    1382:	02c5d5bb          	divuw	a1,a1,a2
    1386:	0685                	addi	a3,a3,1
    1388:	fec7f0e3          	bgeu	a5,a2,1368 <printint+0x2a>
  if(neg)
    138c:	00088c63          	beqz	a7,13a4 <printint+0x66>
    buf[i++] = '-';
    1390:	fd070793          	addi	a5,a4,-48
    1394:	00878733          	add	a4,a5,s0
    1398:	02d00793          	li	a5,45
    139c:	fef70823          	sb	a5,-16(a4)
    13a0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    13a4:	02e05863          	blez	a4,13d4 <printint+0x96>
    13a8:	fc040793          	addi	a5,s0,-64
    13ac:	00e78933          	add	s2,a5,a4
    13b0:	fff78993          	addi	s3,a5,-1
    13b4:	99ba                	add	s3,s3,a4
    13b6:	377d                	addiw	a4,a4,-1
    13b8:	1702                	slli	a4,a4,0x20
    13ba:	9301                	srli	a4,a4,0x20
    13bc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    13c0:	fff94583          	lbu	a1,-1(s2)
    13c4:	8526                	mv	a0,s1
    13c6:	00000097          	auipc	ra,0x0
    13ca:	f56080e7          	jalr	-170(ra) # 131c <putc>
  while(--i >= 0)
    13ce:	197d                	addi	s2,s2,-1
    13d0:	ff3918e3          	bne	s2,s3,13c0 <printint+0x82>
}
    13d4:	70e2                	ld	ra,56(sp)
    13d6:	7442                	ld	s0,48(sp)
    13d8:	74a2                	ld	s1,40(sp)
    13da:	7902                	ld	s2,32(sp)
    13dc:	69e2                	ld	s3,24(sp)
    13de:	6121                	addi	sp,sp,64
    13e0:	8082                	ret
    x = -xx;
    13e2:	40b005bb          	negw	a1,a1
    neg = 1;
    13e6:	4885                	li	a7,1
    x = -xx;
    13e8:	bf85                	j	1358 <printint+0x1a>

00000000000013ea <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    13ea:	715d                	addi	sp,sp,-80
    13ec:	e486                	sd	ra,72(sp)
    13ee:	e0a2                	sd	s0,64(sp)
    13f0:	fc26                	sd	s1,56(sp)
    13f2:	f84a                	sd	s2,48(sp)
    13f4:	f44e                	sd	s3,40(sp)
    13f6:	f052                	sd	s4,32(sp)
    13f8:	ec56                	sd	s5,24(sp)
    13fa:	e85a                	sd	s6,16(sp)
    13fc:	e45e                	sd	s7,8(sp)
    13fe:	e062                	sd	s8,0(sp)
    1400:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1402:	0005c903          	lbu	s2,0(a1)
    1406:	18090c63          	beqz	s2,159e <vprintf+0x1b4>
    140a:	8aaa                	mv	s5,a0
    140c:	8bb2                	mv	s7,a2
    140e:	00158493          	addi	s1,a1,1
  state = 0;
    1412:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1414:	02500a13          	li	s4,37
    1418:	4b55                	li	s6,21
    141a:	a839                	j	1438 <vprintf+0x4e>
        putc(fd, c);
    141c:	85ca                	mv	a1,s2
    141e:	8556                	mv	a0,s5
    1420:	00000097          	auipc	ra,0x0
    1424:	efc080e7          	jalr	-260(ra) # 131c <putc>
    1428:	a019                	j	142e <vprintf+0x44>
    } else if(state == '%'){
    142a:	01498d63          	beq	s3,s4,1444 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    142e:	0485                	addi	s1,s1,1
    1430:	fff4c903          	lbu	s2,-1(s1)
    1434:	16090563          	beqz	s2,159e <vprintf+0x1b4>
    if(state == 0){
    1438:	fe0999e3          	bnez	s3,142a <vprintf+0x40>
      if(c == '%'){
    143c:	ff4910e3          	bne	s2,s4,141c <vprintf+0x32>
        state = '%';
    1440:	89d2                	mv	s3,s4
    1442:	b7f5                	j	142e <vprintf+0x44>
      if(c == 'd'){
    1444:	13490263          	beq	s2,s4,1568 <vprintf+0x17e>
    1448:	f9d9079b          	addiw	a5,s2,-99
    144c:	0ff7f793          	zext.b	a5,a5
    1450:	12fb6563          	bltu	s6,a5,157a <vprintf+0x190>
    1454:	f9d9079b          	addiw	a5,s2,-99
    1458:	0ff7f713          	zext.b	a4,a5
    145c:	10eb6f63          	bltu	s6,a4,157a <vprintf+0x190>
    1460:	00271793          	slli	a5,a4,0x2
    1464:	00000717          	auipc	a4,0x0
    1468:	79c70713          	addi	a4,a4,1948 # 1c00 <malloc+0x564>
    146c:	97ba                	add	a5,a5,a4
    146e:	439c                	lw	a5,0(a5)
    1470:	97ba                	add	a5,a5,a4
    1472:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1474:	008b8913          	addi	s2,s7,8
    1478:	4685                	li	a3,1
    147a:	4629                	li	a2,10
    147c:	000ba583          	lw	a1,0(s7)
    1480:	8556                	mv	a0,s5
    1482:	00000097          	auipc	ra,0x0
    1486:	ebc080e7          	jalr	-324(ra) # 133e <printint>
    148a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    148c:	4981                	li	s3,0
    148e:	b745                	j	142e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1490:	008b8913          	addi	s2,s7,8
    1494:	4681                	li	a3,0
    1496:	4629                	li	a2,10
    1498:	000ba583          	lw	a1,0(s7)
    149c:	8556                	mv	a0,s5
    149e:	00000097          	auipc	ra,0x0
    14a2:	ea0080e7          	jalr	-352(ra) # 133e <printint>
    14a6:	8bca                	mv	s7,s2
      state = 0;
    14a8:	4981                	li	s3,0
    14aa:	b751                	j	142e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    14ac:	008b8913          	addi	s2,s7,8
    14b0:	4681                	li	a3,0
    14b2:	4641                	li	a2,16
    14b4:	000ba583          	lw	a1,0(s7)
    14b8:	8556                	mv	a0,s5
    14ba:	00000097          	auipc	ra,0x0
    14be:	e84080e7          	jalr	-380(ra) # 133e <printint>
    14c2:	8bca                	mv	s7,s2
      state = 0;
    14c4:	4981                	li	s3,0
    14c6:	b7a5                	j	142e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    14c8:	008b8c13          	addi	s8,s7,8
    14cc:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    14d0:	03000593          	li	a1,48
    14d4:	8556                	mv	a0,s5
    14d6:	00000097          	auipc	ra,0x0
    14da:	e46080e7          	jalr	-442(ra) # 131c <putc>
  putc(fd, 'x');
    14de:	07800593          	li	a1,120
    14e2:	8556                	mv	a0,s5
    14e4:	00000097          	auipc	ra,0x0
    14e8:	e38080e7          	jalr	-456(ra) # 131c <putc>
    14ec:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    14ee:	00000b97          	auipc	s7,0x0
    14f2:	76ab8b93          	addi	s7,s7,1898 # 1c58 <digits>
    14f6:	03c9d793          	srli	a5,s3,0x3c
    14fa:	97de                	add	a5,a5,s7
    14fc:	0007c583          	lbu	a1,0(a5)
    1500:	8556                	mv	a0,s5
    1502:	00000097          	auipc	ra,0x0
    1506:	e1a080e7          	jalr	-486(ra) # 131c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    150a:	0992                	slli	s3,s3,0x4
    150c:	397d                	addiw	s2,s2,-1
    150e:	fe0914e3          	bnez	s2,14f6 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1512:	8be2                	mv	s7,s8
      state = 0;
    1514:	4981                	li	s3,0
    1516:	bf21                	j	142e <vprintf+0x44>
        s = va_arg(ap, char*);
    1518:	008b8993          	addi	s3,s7,8
    151c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    1520:	02090163          	beqz	s2,1542 <vprintf+0x158>
        while(*s != 0){
    1524:	00094583          	lbu	a1,0(s2)
    1528:	c9a5                	beqz	a1,1598 <vprintf+0x1ae>
          putc(fd, *s);
    152a:	8556                	mv	a0,s5
    152c:	00000097          	auipc	ra,0x0
    1530:	df0080e7          	jalr	-528(ra) # 131c <putc>
          s++;
    1534:	0905                	addi	s2,s2,1
        while(*s != 0){
    1536:	00094583          	lbu	a1,0(s2)
    153a:	f9e5                	bnez	a1,152a <vprintf+0x140>
        s = va_arg(ap, char*);
    153c:	8bce                	mv	s7,s3
      state = 0;
    153e:	4981                	li	s3,0
    1540:	b5fd                	j	142e <vprintf+0x44>
          s = "(null)";
    1542:	00000917          	auipc	s2,0x0
    1546:	6b690913          	addi	s2,s2,1718 # 1bf8 <malloc+0x55c>
        while(*s != 0){
    154a:	02800593          	li	a1,40
    154e:	bff1                	j	152a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    1550:	008b8913          	addi	s2,s7,8
    1554:	000bc583          	lbu	a1,0(s7)
    1558:	8556                	mv	a0,s5
    155a:	00000097          	auipc	ra,0x0
    155e:	dc2080e7          	jalr	-574(ra) # 131c <putc>
    1562:	8bca                	mv	s7,s2
      state = 0;
    1564:	4981                	li	s3,0
    1566:	b5e1                	j	142e <vprintf+0x44>
        putc(fd, c);
    1568:	02500593          	li	a1,37
    156c:	8556                	mv	a0,s5
    156e:	00000097          	auipc	ra,0x0
    1572:	dae080e7          	jalr	-594(ra) # 131c <putc>
      state = 0;
    1576:	4981                	li	s3,0
    1578:	bd5d                	j	142e <vprintf+0x44>
        putc(fd, '%');
    157a:	02500593          	li	a1,37
    157e:	8556                	mv	a0,s5
    1580:	00000097          	auipc	ra,0x0
    1584:	d9c080e7          	jalr	-612(ra) # 131c <putc>
        putc(fd, c);
    1588:	85ca                	mv	a1,s2
    158a:	8556                	mv	a0,s5
    158c:	00000097          	auipc	ra,0x0
    1590:	d90080e7          	jalr	-624(ra) # 131c <putc>
      state = 0;
    1594:	4981                	li	s3,0
    1596:	bd61                	j	142e <vprintf+0x44>
        s = va_arg(ap, char*);
    1598:	8bce                	mv	s7,s3
      state = 0;
    159a:	4981                	li	s3,0
    159c:	bd49                	j	142e <vprintf+0x44>
    }
  }
}
    159e:	60a6                	ld	ra,72(sp)
    15a0:	6406                	ld	s0,64(sp)
    15a2:	74e2                	ld	s1,56(sp)
    15a4:	7942                	ld	s2,48(sp)
    15a6:	79a2                	ld	s3,40(sp)
    15a8:	7a02                	ld	s4,32(sp)
    15aa:	6ae2                	ld	s5,24(sp)
    15ac:	6b42                	ld	s6,16(sp)
    15ae:	6ba2                	ld	s7,8(sp)
    15b0:	6c02                	ld	s8,0(sp)
    15b2:	6161                	addi	sp,sp,80
    15b4:	8082                	ret

00000000000015b6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    15b6:	715d                	addi	sp,sp,-80
    15b8:	ec06                	sd	ra,24(sp)
    15ba:	e822                	sd	s0,16(sp)
    15bc:	1000                	addi	s0,sp,32
    15be:	e010                	sd	a2,0(s0)
    15c0:	e414                	sd	a3,8(s0)
    15c2:	e818                	sd	a4,16(s0)
    15c4:	ec1c                	sd	a5,24(s0)
    15c6:	03043023          	sd	a6,32(s0)
    15ca:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    15ce:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    15d2:	8622                	mv	a2,s0
    15d4:	00000097          	auipc	ra,0x0
    15d8:	e16080e7          	jalr	-490(ra) # 13ea <vprintf>
}
    15dc:	60e2                	ld	ra,24(sp)
    15de:	6442                	ld	s0,16(sp)
    15e0:	6161                	addi	sp,sp,80
    15e2:	8082                	ret

00000000000015e4 <printf>:

void
printf(const char *fmt, ...)
{
    15e4:	711d                	addi	sp,sp,-96
    15e6:	ec06                	sd	ra,24(sp)
    15e8:	e822                	sd	s0,16(sp)
    15ea:	1000                	addi	s0,sp,32
    15ec:	e40c                	sd	a1,8(s0)
    15ee:	e810                	sd	a2,16(s0)
    15f0:	ec14                	sd	a3,24(s0)
    15f2:	f018                	sd	a4,32(s0)
    15f4:	f41c                	sd	a5,40(s0)
    15f6:	03043823          	sd	a6,48(s0)
    15fa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    15fe:	00840613          	addi	a2,s0,8
    1602:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1606:	85aa                	mv	a1,a0
    1608:	4505                	li	a0,1
    160a:	00000097          	auipc	ra,0x0
    160e:	de0080e7          	jalr	-544(ra) # 13ea <vprintf>
}
    1612:	60e2                	ld	ra,24(sp)
    1614:	6442                	ld	s0,16(sp)
    1616:	6125                	addi	sp,sp,96
    1618:	8082                	ret

000000000000161a <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    161a:	1141                	addi	sp,sp,-16
    161c:	e422                	sd	s0,8(sp)
    161e:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    1620:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1624:	00001797          	auipc	a5,0x1
    1628:	9f47b783          	ld	a5,-1548(a5) # 2018 <freep>
    162c:	a02d                	j	1656 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    162e:	4618                	lw	a4,8(a2)
    1630:	9f2d                	addw	a4,a4,a1
    1632:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    1636:	6398                	ld	a4,0(a5)
    1638:	6310                	ld	a2,0(a4)
    163a:	a83d                	j	1678 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    163c:	ff852703          	lw	a4,-8(a0)
    1640:	9f31                	addw	a4,a4,a2
    1642:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    1644:	ff053683          	ld	a3,-16(a0)
    1648:	a091                	j	168c <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    164a:	6398                	ld	a4,0(a5)
    164c:	00e7e463          	bltu	a5,a4,1654 <free+0x3a>
    1650:	00e6ea63          	bltu	a3,a4,1664 <free+0x4a>
{
    1654:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1656:	fed7fae3          	bgeu	a5,a3,164a <free+0x30>
    165a:	6398                	ld	a4,0(a5)
    165c:	00e6e463          	bltu	a3,a4,1664 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1660:	fee7eae3          	bltu	a5,a4,1654 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    1664:	ff852583          	lw	a1,-8(a0)
    1668:	6390                	ld	a2,0(a5)
    166a:	02059813          	slli	a6,a1,0x20
    166e:	01c85713          	srli	a4,a6,0x1c
    1672:	9736                	add	a4,a4,a3
    1674:	fae60de3          	beq	a2,a4,162e <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    1678:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    167c:	4790                	lw	a2,8(a5)
    167e:	02061593          	slli	a1,a2,0x20
    1682:	01c5d713          	srli	a4,a1,0x1c
    1686:	973e                	add	a4,a4,a5
    1688:	fae68ae3          	beq	a3,a4,163c <free+0x22>
        p->s.ptr = bp->s.ptr;
    168c:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    168e:	00001717          	auipc	a4,0x1
    1692:	98f73523          	sd	a5,-1654(a4) # 2018 <freep>
}
    1696:	6422                	ld	s0,8(sp)
    1698:	0141                	addi	sp,sp,16
    169a:	8082                	ret

000000000000169c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    169c:	7139                	addi	sp,sp,-64
    169e:	fc06                	sd	ra,56(sp)
    16a0:	f822                	sd	s0,48(sp)
    16a2:	f426                	sd	s1,40(sp)
    16a4:	f04a                	sd	s2,32(sp)
    16a6:	ec4e                	sd	s3,24(sp)
    16a8:	e852                	sd	s4,16(sp)
    16aa:	e456                	sd	s5,8(sp)
    16ac:	e05a                	sd	s6,0(sp)
    16ae:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    16b0:	02051493          	slli	s1,a0,0x20
    16b4:	9081                	srli	s1,s1,0x20
    16b6:	04bd                	addi	s1,s1,15
    16b8:	8091                	srli	s1,s1,0x4
    16ba:	0014899b          	addiw	s3,s1,1
    16be:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    16c0:	00001517          	auipc	a0,0x1
    16c4:	95853503          	ld	a0,-1704(a0) # 2018 <freep>
    16c8:	c515                	beqz	a0,16f4 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    16ca:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    16cc:	4798                	lw	a4,8(a5)
    16ce:	02977f63          	bgeu	a4,s1,170c <malloc+0x70>
    if (nu < 4096)
    16d2:	8a4e                	mv	s4,s3
    16d4:	0009871b          	sext.w	a4,s3
    16d8:	6685                	lui	a3,0x1
    16da:	00d77363          	bgeu	a4,a3,16e0 <malloc+0x44>
    16de:	6a05                	lui	s4,0x1
    16e0:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    16e4:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    16e8:	00001917          	auipc	s2,0x1
    16ec:	93090913          	addi	s2,s2,-1744 # 2018 <freep>
    if (p == (char *)-1)
    16f0:	5afd                	li	s5,-1
    16f2:	a895                	j	1766 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    16f4:	00001797          	auipc	a5,0x1
    16f8:	d9478793          	addi	a5,a5,-620 # 2488 <base>
    16fc:	00001717          	auipc	a4,0x1
    1700:	90f73e23          	sd	a5,-1764(a4) # 2018 <freep>
    1704:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    1706:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    170a:	b7e1                	j	16d2 <malloc+0x36>
            if (p->s.size == nunits)
    170c:	02e48c63          	beq	s1,a4,1744 <malloc+0xa8>
                p->s.size -= nunits;
    1710:	4137073b          	subw	a4,a4,s3
    1714:	c798                	sw	a4,8(a5)
                p += p->s.size;
    1716:	02071693          	slli	a3,a4,0x20
    171a:	01c6d713          	srli	a4,a3,0x1c
    171e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    1720:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    1724:	00001717          	auipc	a4,0x1
    1728:	8ea73a23          	sd	a0,-1804(a4) # 2018 <freep>
            return (void *)(p + 1);
    172c:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    1730:	70e2                	ld	ra,56(sp)
    1732:	7442                	ld	s0,48(sp)
    1734:	74a2                	ld	s1,40(sp)
    1736:	7902                	ld	s2,32(sp)
    1738:	69e2                	ld	s3,24(sp)
    173a:	6a42                	ld	s4,16(sp)
    173c:	6aa2                	ld	s5,8(sp)
    173e:	6b02                	ld	s6,0(sp)
    1740:	6121                	addi	sp,sp,64
    1742:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    1744:	6398                	ld	a4,0(a5)
    1746:	e118                	sd	a4,0(a0)
    1748:	bff1                	j	1724 <malloc+0x88>
    hp->s.size = nu;
    174a:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    174e:	0541                	addi	a0,a0,16
    1750:	00000097          	auipc	ra,0x0
    1754:	eca080e7          	jalr	-310(ra) # 161a <free>
    return freep;
    1758:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    175c:	d971                	beqz	a0,1730 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    175e:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    1760:	4798                	lw	a4,8(a5)
    1762:	fa9775e3          	bgeu	a4,s1,170c <malloc+0x70>
        if (p == freep)
    1766:	00093703          	ld	a4,0(s2)
    176a:	853e                	mv	a0,a5
    176c:	fef719e3          	bne	a4,a5,175e <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    1770:	8552                	mv	a0,s4
    1772:	00000097          	auipc	ra,0x0
    1776:	b7a080e7          	jalr	-1158(ra) # 12ec <sbrk>
    if (p == (char *)-1)
    177a:	fd5518e3          	bne	a0,s5,174a <malloc+0xae>
                return 0;
    177e:	4501                	li	a0,0
    1780:	bf45                	j	1730 <malloc+0x94>
