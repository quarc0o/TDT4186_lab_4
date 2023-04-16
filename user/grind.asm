
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
      18:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
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
      94:	05a080e7          	jalr	90(ra) # 10ea <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	4e650513          	addi	a0,a0,1254 # 1580 <malloc+0xe6>
      a2:	00001097          	auipc	ra,0x1
      a6:	028080e7          	jalr	40(ra) # 10ca <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	4d650513          	addi	a0,a0,1238 # 1580 <malloc+0xe6>
      b2:	00001097          	auipc	ra,0x1
      b6:	020080e7          	jalr	32(ra) # 10d2 <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	4cc50513          	addi	a0,a0,1228 # 1588 <malloc+0xee>
      c4:	00001097          	auipc	ra,0x1
      c8:	31e080e7          	jalr	798(ra) # 13e2 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	f94080e7          	jalr	-108(ra) # 1062 <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	4d250513          	addi	a0,a0,1234 # 15a8 <malloc+0x10e>
      de:	00001097          	auipc	ra,0x1
      e2:	ff4080e7          	jalr	-12(ra) # 10d2 <chdir>
      e6:	00001997          	auipc	s3,0x1
      ea:	4d298993          	addi	s3,s3,1234 # 15b8 <malloc+0x11e>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	4c098993          	addi	s3,s3,1216 # 15b0 <malloc+0x116>
  uint64 iters = 0;
      f8:	4481                	li	s1,0
  int fd = -1;
      fa:	5a7d                	li	s4,-1
      fc:	00001917          	auipc	s2,0x1
     100:	76c90913          	addi	s2,s2,1900 # 1868 <malloc+0x3ce>
     104:	a839                	j	122 <go+0xaa>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	4b650513          	addi	a0,a0,1206 # 15c0 <malloc+0x126>
     112:	00001097          	auipc	ra,0x1
     116:	f90080e7          	jalr	-112(ra) # 10a2 <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	f70080e7          	jalr	-144(ra) # 108a <close>
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
     138:	f4e080e7          	jalr	-178(ra) # 1082 <write>
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
     168:	46c50513          	addi	a0,a0,1132 # 15d0 <malloc+0x136>
     16c:	00001097          	auipc	ra,0x1
     170:	f36080e7          	jalr	-202(ra) # 10a2 <open>
     174:	00001097          	auipc	ra,0x1
     178:	f16080e7          	jalr	-234(ra) # 108a <close>
     17c:	b75d                	j	122 <go+0xaa>
    } else if(what == 3){
      unlink("grindir/../a");
     17e:	00001517          	auipc	a0,0x1
     182:	44250513          	addi	a0,a0,1090 # 15c0 <malloc+0x126>
     186:	00001097          	auipc	ra,0x1
     18a:	f2c080e7          	jalr	-212(ra) # 10b2 <unlink>
     18e:	bf51                	j	122 <go+0xaa>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     190:	00001517          	auipc	a0,0x1
     194:	3f050513          	addi	a0,a0,1008 # 1580 <malloc+0xe6>
     198:	00001097          	auipc	ra,0x1
     19c:	f3a080e7          	jalr	-198(ra) # 10d2 <chdir>
     1a0:	e115                	bnez	a0,1c4 <go+0x14c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     1a2:	00001517          	auipc	a0,0x1
     1a6:	44650513          	addi	a0,a0,1094 # 15e8 <malloc+0x14e>
     1aa:	00001097          	auipc	ra,0x1
     1ae:	f08080e7          	jalr	-248(ra) # 10b2 <unlink>
      chdir("/");
     1b2:	00001517          	auipc	a0,0x1
     1b6:	3f650513          	addi	a0,a0,1014 # 15a8 <malloc+0x10e>
     1ba:	00001097          	auipc	ra,0x1
     1be:	f18080e7          	jalr	-232(ra) # 10d2 <chdir>
     1c2:	b785                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     1c4:	00001517          	auipc	a0,0x1
     1c8:	3c450513          	addi	a0,a0,964 # 1588 <malloc+0xee>
     1cc:	00001097          	auipc	ra,0x1
     1d0:	216080e7          	jalr	534(ra) # 13e2 <printf>
        exit(1);
     1d4:	4505                	li	a0,1
     1d6:	00001097          	auipc	ra,0x1
     1da:	e8c080e7          	jalr	-372(ra) # 1062 <exit>
    } else if(what == 5){
      close(fd);
     1de:	8552                	mv	a0,s4
     1e0:	00001097          	auipc	ra,0x1
     1e4:	eaa080e7          	jalr	-342(ra) # 108a <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1e8:	20200593          	li	a1,514
     1ec:	00001517          	auipc	a0,0x1
     1f0:	40450513          	addi	a0,a0,1028 # 15f0 <malloc+0x156>
     1f4:	00001097          	auipc	ra,0x1
     1f8:	eae080e7          	jalr	-338(ra) # 10a2 <open>
     1fc:	8a2a                	mv	s4,a0
     1fe:	b715                	j	122 <go+0xaa>
    } else if(what == 6){
      close(fd);
     200:	8552                	mv	a0,s4
     202:	00001097          	auipc	ra,0x1
     206:	e88080e7          	jalr	-376(ra) # 108a <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	3f250513          	addi	a0,a0,1010 # 1600 <malloc+0x166>
     216:	00001097          	auipc	ra,0x1
     21a:	e8c080e7          	jalr	-372(ra) # 10a2 <open>
     21e:	8a2a                	mv	s4,a0
     220:	b709                	j	122 <go+0xaa>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     222:	3e700613          	li	a2,999
     226:	00002597          	auipc	a1,0x2
     22a:	dfa58593          	addi	a1,a1,-518 # 2020 <buf.0>
     22e:	8552                	mv	a0,s4
     230:	00001097          	auipc	ra,0x1
     234:	e52080e7          	jalr	-430(ra) # 1082 <write>
     238:	b5ed                	j	122 <go+0xaa>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     23a:	3e700613          	li	a2,999
     23e:	00002597          	auipc	a1,0x2
     242:	de258593          	addi	a1,a1,-542 # 2020 <buf.0>
     246:	8552                	mv	a0,s4
     248:	00001097          	auipc	ra,0x1
     24c:	e32080e7          	jalr	-462(ra) # 107a <read>
     250:	bdc9                	j	122 <go+0xaa>
    } else if(what == 9){
      mkdir("grindir/../a");
     252:	00001517          	auipc	a0,0x1
     256:	36e50513          	addi	a0,a0,878 # 15c0 <malloc+0x126>
     25a:	00001097          	auipc	ra,0x1
     25e:	e70080e7          	jalr	-400(ra) # 10ca <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     262:	20200593          	li	a1,514
     266:	00001517          	auipc	a0,0x1
     26a:	3b250513          	addi	a0,a0,946 # 1618 <malloc+0x17e>
     26e:	00001097          	auipc	ra,0x1
     272:	e34080e7          	jalr	-460(ra) # 10a2 <open>
     276:	00001097          	auipc	ra,0x1
     27a:	e14080e7          	jalr	-492(ra) # 108a <close>
      unlink("a/a");
     27e:	00001517          	auipc	a0,0x1
     282:	3aa50513          	addi	a0,a0,938 # 1628 <malloc+0x18e>
     286:	00001097          	auipc	ra,0x1
     28a:	e2c080e7          	jalr	-468(ra) # 10b2 <unlink>
     28e:	bd51                	j	122 <go+0xaa>
    } else if(what == 10){
      mkdir("/../b");
     290:	00001517          	auipc	a0,0x1
     294:	3a050513          	addi	a0,a0,928 # 1630 <malloc+0x196>
     298:	00001097          	auipc	ra,0x1
     29c:	e32080e7          	jalr	-462(ra) # 10ca <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2a0:	20200593          	li	a1,514
     2a4:	00001517          	auipc	a0,0x1
     2a8:	39450513          	addi	a0,a0,916 # 1638 <malloc+0x19e>
     2ac:	00001097          	auipc	ra,0x1
     2b0:	df6080e7          	jalr	-522(ra) # 10a2 <open>
     2b4:	00001097          	auipc	ra,0x1
     2b8:	dd6080e7          	jalr	-554(ra) # 108a <close>
      unlink("b/b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	38c50513          	addi	a0,a0,908 # 1648 <malloc+0x1ae>
     2c4:	00001097          	auipc	ra,0x1
     2c8:	dee080e7          	jalr	-530(ra) # 10b2 <unlink>
     2cc:	bd99                	j	122 <go+0xaa>
    } else if(what == 11){
      unlink("b");
     2ce:	00001517          	auipc	a0,0x1
     2d2:	34250513          	addi	a0,a0,834 # 1610 <malloc+0x176>
     2d6:	00001097          	auipc	ra,0x1
     2da:	ddc080e7          	jalr	-548(ra) # 10b2 <unlink>
      link("../grindir/./../a", "../b");
     2de:	00001597          	auipc	a1,0x1
     2e2:	30a58593          	addi	a1,a1,778 # 15e8 <malloc+0x14e>
     2e6:	00001517          	auipc	a0,0x1
     2ea:	36a50513          	addi	a0,a0,874 # 1650 <malloc+0x1b6>
     2ee:	00001097          	auipc	ra,0x1
     2f2:	dd4080e7          	jalr	-556(ra) # 10c2 <link>
     2f6:	b535                	j	122 <go+0xaa>
    } else if(what == 12){
      unlink("../grindir/../a");
     2f8:	00001517          	auipc	a0,0x1
     2fc:	37050513          	addi	a0,a0,880 # 1668 <malloc+0x1ce>
     300:	00001097          	auipc	ra,0x1
     304:	db2080e7          	jalr	-590(ra) # 10b2 <unlink>
      link(".././b", "/grindir/../a");
     308:	00001597          	auipc	a1,0x1
     30c:	2e858593          	addi	a1,a1,744 # 15f0 <malloc+0x156>
     310:	00001517          	auipc	a0,0x1
     314:	36850513          	addi	a0,a0,872 # 1678 <malloc+0x1de>
     318:	00001097          	auipc	ra,0x1
     31c:	daa080e7          	jalr	-598(ra) # 10c2 <link>
     320:	b509                	j	122 <go+0xaa>
    } else if(what == 13){
      int pid = fork();
     322:	00001097          	auipc	ra,0x1
     326:	d38080e7          	jalr	-712(ra) # 105a <fork>
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
     336:	d38080e7          	jalr	-712(ra) # 106a <wait>
     33a:	b3e5                	j	122 <go+0xaa>
        exit(0);
     33c:	00001097          	auipc	ra,0x1
     340:	d26080e7          	jalr	-730(ra) # 1062 <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	33c50513          	addi	a0,a0,828 # 1680 <malloc+0x1e6>
     34c:	00001097          	auipc	ra,0x1
     350:	096080e7          	jalr	150(ra) # 13e2 <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	00001097          	auipc	ra,0x1
     35a:	d0c080e7          	jalr	-756(ra) # 1062 <exit>
    } else if(what == 14){
      int pid = fork();
     35e:	00001097          	auipc	ra,0x1
     362:	cfc080e7          	jalr	-772(ra) # 105a <fork>
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
     372:	cfc080e7          	jalr	-772(ra) # 106a <wait>
     376:	b375                	j	122 <go+0xaa>
        fork();
     378:	00001097          	auipc	ra,0x1
     37c:	ce2080e7          	jalr	-798(ra) # 105a <fork>
        fork();
     380:	00001097          	auipc	ra,0x1
     384:	cda080e7          	jalr	-806(ra) # 105a <fork>
        exit(0);
     388:	4501                	li	a0,0
     38a:	00001097          	auipc	ra,0x1
     38e:	cd8080e7          	jalr	-808(ra) # 1062 <exit>
        printf("grind: fork failed\n");
     392:	00001517          	auipc	a0,0x1
     396:	2ee50513          	addi	a0,a0,750 # 1680 <malloc+0x1e6>
     39a:	00001097          	auipc	ra,0x1
     39e:	048080e7          	jalr	72(ra) # 13e2 <printf>
        exit(1);
     3a2:	4505                	li	a0,1
     3a4:	00001097          	auipc	ra,0x1
     3a8:	cbe080e7          	jalr	-834(ra) # 1062 <exit>
    } else if(what == 15){
      sbrk(6011);
     3ac:	6505                	lui	a0,0x1
     3ae:	77b50513          	addi	a0,a0,1915 # 177b <malloc+0x2e1>
     3b2:	00001097          	auipc	ra,0x1
     3b6:	d38080e7          	jalr	-712(ra) # 10ea <sbrk>
     3ba:	b3a5                	j	122 <go+0xaa>
    } else if(what == 16){
      if(sbrk(0) > break0)
     3bc:	4501                	li	a0,0
     3be:	00001097          	auipc	ra,0x1
     3c2:	d2c080e7          	jalr	-724(ra) # 10ea <sbrk>
     3c6:	d4aafee3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     3ca:	4501                	li	a0,0
     3cc:	00001097          	auipc	ra,0x1
     3d0:	d1e080e7          	jalr	-738(ra) # 10ea <sbrk>
     3d4:	40aa853b          	subw	a0,s5,a0
     3d8:	00001097          	auipc	ra,0x1
     3dc:	d12080e7          	jalr	-750(ra) # 10ea <sbrk>
     3e0:	b389                	j	122 <go+0xaa>
    } else if(what == 17){
      int pid = fork();
     3e2:	00001097          	auipc	ra,0x1
     3e6:	c78080e7          	jalr	-904(ra) # 105a <fork>
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
     3f6:	2a650513          	addi	a0,a0,678 # 1698 <malloc+0x1fe>
     3fa:	00001097          	auipc	ra,0x1
     3fe:	cd8080e7          	jalr	-808(ra) # 10d2 <chdir>
     402:	ed21                	bnez	a0,45a <go+0x3e2>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     404:	855a                	mv	a0,s6
     406:	00001097          	auipc	ra,0x1
     40a:	c8c080e7          	jalr	-884(ra) # 1092 <kill>
      wait(0);
     40e:	4501                	li	a0,0
     410:	00001097          	auipc	ra,0x1
     414:	c5a080e7          	jalr	-934(ra) # 106a <wait>
     418:	b329                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     41a:	20200593          	li	a1,514
     41e:	00001517          	auipc	a0,0x1
     422:	24250513          	addi	a0,a0,578 # 1660 <malloc+0x1c6>
     426:	00001097          	auipc	ra,0x1
     42a:	c7c080e7          	jalr	-900(ra) # 10a2 <open>
     42e:	00001097          	auipc	ra,0x1
     432:	c5c080e7          	jalr	-932(ra) # 108a <close>
        exit(0);
     436:	4501                	li	a0,0
     438:	00001097          	auipc	ra,0x1
     43c:	c2a080e7          	jalr	-982(ra) # 1062 <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	24050513          	addi	a0,a0,576 # 1680 <malloc+0x1e6>
     448:	00001097          	auipc	ra,0x1
     44c:	f9a080e7          	jalr	-102(ra) # 13e2 <printf>
        exit(1);
     450:	4505                	li	a0,1
     452:	00001097          	auipc	ra,0x1
     456:	c10080e7          	jalr	-1008(ra) # 1062 <exit>
        printf("grind: chdir failed\n");
     45a:	00001517          	auipc	a0,0x1
     45e:	24e50513          	addi	a0,a0,590 # 16a8 <malloc+0x20e>
     462:	00001097          	auipc	ra,0x1
     466:	f80080e7          	jalr	-128(ra) # 13e2 <printf>
        exit(1);
     46a:	4505                	li	a0,1
     46c:	00001097          	auipc	ra,0x1
     470:	bf6080e7          	jalr	-1034(ra) # 1062 <exit>
    } else if(what == 18){
      int pid = fork();
     474:	00001097          	auipc	ra,0x1
     478:	be6080e7          	jalr	-1050(ra) # 105a <fork>
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
     488:	be6080e7          	jalr	-1050(ra) # 106a <wait>
     48c:	b959                	j	122 <go+0xaa>
        kill(getpid());
     48e:	00001097          	auipc	ra,0x1
     492:	c54080e7          	jalr	-940(ra) # 10e2 <getpid>
     496:	00001097          	auipc	ra,0x1
     49a:	bfc080e7          	jalr	-1028(ra) # 1092 <kill>
        exit(0);
     49e:	4501                	li	a0,0
     4a0:	00001097          	auipc	ra,0x1
     4a4:	bc2080e7          	jalr	-1086(ra) # 1062 <exit>
        printf("grind: fork failed\n");
     4a8:	00001517          	auipc	a0,0x1
     4ac:	1d850513          	addi	a0,a0,472 # 1680 <malloc+0x1e6>
     4b0:	00001097          	auipc	ra,0x1
     4b4:	f32080e7          	jalr	-206(ra) # 13e2 <printf>
        exit(1);
     4b8:	4505                	li	a0,1
     4ba:	00001097          	auipc	ra,0x1
     4be:	ba8080e7          	jalr	-1112(ra) # 1062 <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     4c2:	fa840513          	addi	a0,s0,-88
     4c6:	00001097          	auipc	ra,0x1
     4ca:	bac080e7          	jalr	-1108(ra) # 1072 <pipe>
     4ce:	02054b63          	bltz	a0,504 <go+0x48c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     4d2:	00001097          	auipc	ra,0x1
     4d6:	b88080e7          	jalr	-1144(ra) # 105a <fork>
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
     4e8:	ba6080e7          	jalr	-1114(ra) # 108a <close>
      close(fds[1]);
     4ec:	fac42503          	lw	a0,-84(s0)
     4f0:	00001097          	auipc	ra,0x1
     4f4:	b9a080e7          	jalr	-1126(ra) # 108a <close>
      wait(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	b70080e7          	jalr	-1168(ra) # 106a <wait>
     502:	b105                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     504:	00001517          	auipc	a0,0x1
     508:	1bc50513          	addi	a0,a0,444 # 16c0 <malloc+0x226>
     50c:	00001097          	auipc	ra,0x1
     510:	ed6080e7          	jalr	-298(ra) # 13e2 <printf>
        exit(1);
     514:	4505                	li	a0,1
     516:	00001097          	auipc	ra,0x1
     51a:	b4c080e7          	jalr	-1204(ra) # 1062 <exit>
        fork();
     51e:	00001097          	auipc	ra,0x1
     522:	b3c080e7          	jalr	-1220(ra) # 105a <fork>
        fork();
     526:	00001097          	auipc	ra,0x1
     52a:	b34080e7          	jalr	-1228(ra) # 105a <fork>
        if(write(fds[1], "x", 1) != 1)
     52e:	4605                	li	a2,1
     530:	00001597          	auipc	a1,0x1
     534:	1a858593          	addi	a1,a1,424 # 16d8 <malloc+0x23e>
     538:	fac42503          	lw	a0,-84(s0)
     53c:	00001097          	auipc	ra,0x1
     540:	b46080e7          	jalr	-1210(ra) # 1082 <write>
     544:	4785                	li	a5,1
     546:	02f51363          	bne	a0,a5,56c <go+0x4f4>
        if(read(fds[0], &c, 1) != 1)
     54a:	4605                	li	a2,1
     54c:	fa040593          	addi	a1,s0,-96
     550:	fa842503          	lw	a0,-88(s0)
     554:	00001097          	auipc	ra,0x1
     558:	b26080e7          	jalr	-1242(ra) # 107a <read>
     55c:	4785                	li	a5,1
     55e:	02f51063          	bne	a0,a5,57e <go+0x506>
        exit(0);
     562:	4501                	li	a0,0
     564:	00001097          	auipc	ra,0x1
     568:	afe080e7          	jalr	-1282(ra) # 1062 <exit>
          printf("grind: pipe write failed\n");
     56c:	00001517          	auipc	a0,0x1
     570:	17450513          	addi	a0,a0,372 # 16e0 <malloc+0x246>
     574:	00001097          	auipc	ra,0x1
     578:	e6e080e7          	jalr	-402(ra) # 13e2 <printf>
     57c:	b7f9                	j	54a <go+0x4d2>
          printf("grind: pipe read failed\n");
     57e:	00001517          	auipc	a0,0x1
     582:	18250513          	addi	a0,a0,386 # 1700 <malloc+0x266>
     586:	00001097          	auipc	ra,0x1
     58a:	e5c080e7          	jalr	-420(ra) # 13e2 <printf>
     58e:	bfd1                	j	562 <go+0x4ea>
        printf("grind: fork failed\n");
     590:	00001517          	auipc	a0,0x1
     594:	0f050513          	addi	a0,a0,240 # 1680 <malloc+0x1e6>
     598:	00001097          	auipc	ra,0x1
     59c:	e4a080e7          	jalr	-438(ra) # 13e2 <printf>
        exit(1);
     5a0:	4505                	li	a0,1
     5a2:	00001097          	auipc	ra,0x1
     5a6:	ac0080e7          	jalr	-1344(ra) # 1062 <exit>
    } else if(what == 20){
      int pid = fork();
     5aa:	00001097          	auipc	ra,0x1
     5ae:	ab0080e7          	jalr	-1360(ra) # 105a <fork>
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
     5be:	ab0080e7          	jalr	-1360(ra) # 106a <wait>
     5c2:	b685                	j	122 <go+0xaa>
        unlink("a");
     5c4:	00001517          	auipc	a0,0x1
     5c8:	09c50513          	addi	a0,a0,156 # 1660 <malloc+0x1c6>
     5cc:	00001097          	auipc	ra,0x1
     5d0:	ae6080e7          	jalr	-1306(ra) # 10b2 <unlink>
        mkdir("a");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	08c50513          	addi	a0,a0,140 # 1660 <malloc+0x1c6>
     5dc:	00001097          	auipc	ra,0x1
     5e0:	aee080e7          	jalr	-1298(ra) # 10ca <mkdir>
        chdir("a");
     5e4:	00001517          	auipc	a0,0x1
     5e8:	07c50513          	addi	a0,a0,124 # 1660 <malloc+0x1c6>
     5ec:	00001097          	auipc	ra,0x1
     5f0:	ae6080e7          	jalr	-1306(ra) # 10d2 <chdir>
        unlink("../a");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	fd450513          	addi	a0,a0,-44 # 15c8 <malloc+0x12e>
     5fc:	00001097          	auipc	ra,0x1
     600:	ab6080e7          	jalr	-1354(ra) # 10b2 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     604:	20200593          	li	a1,514
     608:	00001517          	auipc	a0,0x1
     60c:	0d050513          	addi	a0,a0,208 # 16d8 <malloc+0x23e>
     610:	00001097          	auipc	ra,0x1
     614:	a92080e7          	jalr	-1390(ra) # 10a2 <open>
        unlink("x");
     618:	00001517          	auipc	a0,0x1
     61c:	0c050513          	addi	a0,a0,192 # 16d8 <malloc+0x23e>
     620:	00001097          	auipc	ra,0x1
     624:	a92080e7          	jalr	-1390(ra) # 10b2 <unlink>
        exit(0);
     628:	4501                	li	a0,0
     62a:	00001097          	auipc	ra,0x1
     62e:	a38080e7          	jalr	-1480(ra) # 1062 <exit>
        printf("grind: fork failed\n");
     632:	00001517          	auipc	a0,0x1
     636:	04e50513          	addi	a0,a0,78 # 1680 <malloc+0x1e6>
     63a:	00001097          	auipc	ra,0x1
     63e:	da8080e7          	jalr	-600(ra) # 13e2 <printf>
        exit(1);
     642:	4505                	li	a0,1
     644:	00001097          	auipc	ra,0x1
     648:	a1e080e7          	jalr	-1506(ra) # 1062 <exit>
    } else if(what == 21){
      unlink("c");
     64c:	00001517          	auipc	a0,0x1
     650:	0d450513          	addi	a0,a0,212 # 1720 <malloc+0x286>
     654:	00001097          	auipc	ra,0x1
     658:	a5e080e7          	jalr	-1442(ra) # 10b2 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     65c:	20200593          	li	a1,514
     660:	00001517          	auipc	a0,0x1
     664:	0c050513          	addi	a0,a0,192 # 1720 <malloc+0x286>
     668:	00001097          	auipc	ra,0x1
     66c:	a3a080e7          	jalr	-1478(ra) # 10a2 <open>
     670:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     672:	04054f63          	bltz	a0,6d0 <go+0x658>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     676:	4605                	li	a2,1
     678:	00001597          	auipc	a1,0x1
     67c:	06058593          	addi	a1,a1,96 # 16d8 <malloc+0x23e>
     680:	00001097          	auipc	ra,0x1
     684:	a02080e7          	jalr	-1534(ra) # 1082 <write>
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
     698:	a26080e7          	jalr	-1498(ra) # 10ba <fstat>
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
     6ba:	9d4080e7          	jalr	-1580(ra) # 108a <close>
      unlink("c");
     6be:	00001517          	auipc	a0,0x1
     6c2:	06250513          	addi	a0,a0,98 # 1720 <malloc+0x286>
     6c6:	00001097          	auipc	ra,0x1
     6ca:	9ec080e7          	jalr	-1556(ra) # 10b2 <unlink>
     6ce:	bc91                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     6d0:	00001517          	auipc	a0,0x1
     6d4:	05850513          	addi	a0,a0,88 # 1728 <malloc+0x28e>
     6d8:	00001097          	auipc	ra,0x1
     6dc:	d0a080e7          	jalr	-758(ra) # 13e2 <printf>
        exit(1);
     6e0:	4505                	li	a0,1
     6e2:	00001097          	auipc	ra,0x1
     6e6:	980080e7          	jalr	-1664(ra) # 1062 <exit>
        printf("grind: write c failed\n");
     6ea:	00001517          	auipc	a0,0x1
     6ee:	05650513          	addi	a0,a0,86 # 1740 <malloc+0x2a6>
     6f2:	00001097          	auipc	ra,0x1
     6f6:	cf0080e7          	jalr	-784(ra) # 13e2 <printf>
        exit(1);
     6fa:	4505                	li	a0,1
     6fc:	00001097          	auipc	ra,0x1
     700:	966080e7          	jalr	-1690(ra) # 1062 <exit>
        printf("grind: fstat failed\n");
     704:	00001517          	auipc	a0,0x1
     708:	05450513          	addi	a0,a0,84 # 1758 <malloc+0x2be>
     70c:	00001097          	auipc	ra,0x1
     710:	cd6080e7          	jalr	-810(ra) # 13e2 <printf>
        exit(1);
     714:	4505                	li	a0,1
     716:	00001097          	auipc	ra,0x1
     71a:	94c080e7          	jalr	-1716(ra) # 1062 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     71e:	2581                	sext.w	a1,a1
     720:	00001517          	auipc	a0,0x1
     724:	05050513          	addi	a0,a0,80 # 1770 <malloc+0x2d6>
     728:	00001097          	auipc	ra,0x1
     72c:	cba080e7          	jalr	-838(ra) # 13e2 <printf>
        exit(1);
     730:	4505                	li	a0,1
     732:	00001097          	auipc	ra,0x1
     736:	930080e7          	jalr	-1744(ra) # 1062 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     73a:	00001517          	auipc	a0,0x1
     73e:	05e50513          	addi	a0,a0,94 # 1798 <malloc+0x2fe>
     742:	00001097          	auipc	ra,0x1
     746:	ca0080e7          	jalr	-864(ra) # 13e2 <printf>
        exit(1);
     74a:	4505                	li	a0,1
     74c:	00001097          	auipc	ra,0x1
     750:	916080e7          	jalr	-1770(ra) # 1062 <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     754:	f9840513          	addi	a0,s0,-104
     758:	00001097          	auipc	ra,0x1
     75c:	91a080e7          	jalr	-1766(ra) # 1072 <pipe>
     760:	10054063          	bltz	a0,860 <go+0x7e8>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     764:	fa040513          	addi	a0,s0,-96
     768:	00001097          	auipc	ra,0x1
     76c:	90a080e7          	jalr	-1782(ra) # 1072 <pipe>
     770:	10054663          	bltz	a0,87c <go+0x804>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     774:	00001097          	auipc	ra,0x1
     778:	8e6080e7          	jalr	-1818(ra) # 105a <fork>
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
     788:	8d6080e7          	jalr	-1834(ra) # 105a <fork>
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
     79c:	8f2080e7          	jalr	-1806(ra) # 108a <close>
      close(aa[1]);
     7a0:	f9c42503          	lw	a0,-100(s0)
     7a4:	00001097          	auipc	ra,0x1
     7a8:	8e6080e7          	jalr	-1818(ra) # 108a <close>
      close(bb[1]);
     7ac:	fa442503          	lw	a0,-92(s0)
     7b0:	00001097          	auipc	ra,0x1
     7b4:	8da080e7          	jalr	-1830(ra) # 108a <close>
      char buf[4] = { 0, 0, 0, 0 };
     7b8:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     7bc:	4605                	li	a2,1
     7be:	f9040593          	addi	a1,s0,-112
     7c2:	fa042503          	lw	a0,-96(s0)
     7c6:	00001097          	auipc	ra,0x1
     7ca:	8b4080e7          	jalr	-1868(ra) # 107a <read>
      read(bb[0], buf+1, 1);
     7ce:	4605                	li	a2,1
     7d0:	f9140593          	addi	a1,s0,-111
     7d4:	fa042503          	lw	a0,-96(s0)
     7d8:	00001097          	auipc	ra,0x1
     7dc:	8a2080e7          	jalr	-1886(ra) # 107a <read>
      read(bb[0], buf+2, 1);
     7e0:	4605                	li	a2,1
     7e2:	f9240593          	addi	a1,s0,-110
     7e6:	fa042503          	lw	a0,-96(s0)
     7ea:	00001097          	auipc	ra,0x1
     7ee:	890080e7          	jalr	-1904(ra) # 107a <read>
      close(bb[0]);
     7f2:	fa042503          	lw	a0,-96(s0)
     7f6:	00001097          	auipc	ra,0x1
     7fa:	894080e7          	jalr	-1900(ra) # 108a <close>
      int st1, st2;
      wait(&st1);
     7fe:	f9440513          	addi	a0,s0,-108
     802:	00001097          	auipc	ra,0x1
     806:	868080e7          	jalr	-1944(ra) # 106a <wait>
      wait(&st2);
     80a:	fa840513          	addi	a0,s0,-88
     80e:	00001097          	auipc	ra,0x1
     812:	85c080e7          	jalr	-1956(ra) # 106a <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     816:	f9442783          	lw	a5,-108(s0)
     81a:	fa842703          	lw	a4,-88(s0)
     81e:	8fd9                	or	a5,a5,a4
     820:	ef89                	bnez	a5,83a <go+0x7c2>
     822:	00001597          	auipc	a1,0x1
     826:	01658593          	addi	a1,a1,22 # 1838 <malloc+0x39e>
     82a:	f9040513          	addi	a0,s0,-112
     82e:	00000097          	auipc	ra,0x0
     832:	5e4080e7          	jalr	1508(ra) # e12 <strcmp>
     836:	8e0506e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     83a:	f9040693          	addi	a3,s0,-112
     83e:	fa842603          	lw	a2,-88(s0)
     842:	f9442583          	lw	a1,-108(s0)
     846:	00001517          	auipc	a0,0x1
     84a:	ffa50513          	addi	a0,a0,-6 # 1840 <malloc+0x3a6>
     84e:	00001097          	auipc	ra,0x1
     852:	b94080e7          	jalr	-1132(ra) # 13e2 <printf>
        exit(1);
     856:	4505                	li	a0,1
     858:	00001097          	auipc	ra,0x1
     85c:	80a080e7          	jalr	-2038(ra) # 1062 <exit>
        fprintf(2, "grind: pipe failed\n");
     860:	00001597          	auipc	a1,0x1
     864:	e6058593          	addi	a1,a1,-416 # 16c0 <malloc+0x226>
     868:	4509                	li	a0,2
     86a:	00001097          	auipc	ra,0x1
     86e:	b4a080e7          	jalr	-1206(ra) # 13b4 <fprintf>
        exit(1);
     872:	4505                	li	a0,1
     874:	00000097          	auipc	ra,0x0
     878:	7ee080e7          	jalr	2030(ra) # 1062 <exit>
        fprintf(2, "grind: pipe failed\n");
     87c:	00001597          	auipc	a1,0x1
     880:	e4458593          	addi	a1,a1,-444 # 16c0 <malloc+0x226>
     884:	4509                	li	a0,2
     886:	00001097          	auipc	ra,0x1
     88a:	b2e080e7          	jalr	-1234(ra) # 13b4 <fprintf>
        exit(1);
     88e:	4505                	li	a0,1
     890:	00000097          	auipc	ra,0x0
     894:	7d2080e7          	jalr	2002(ra) # 1062 <exit>
        close(bb[0]);
     898:	fa042503          	lw	a0,-96(s0)
     89c:	00000097          	auipc	ra,0x0
     8a0:	7ee080e7          	jalr	2030(ra) # 108a <close>
        close(bb[1]);
     8a4:	fa442503          	lw	a0,-92(s0)
     8a8:	00000097          	auipc	ra,0x0
     8ac:	7e2080e7          	jalr	2018(ra) # 108a <close>
        close(aa[0]);
     8b0:	f9842503          	lw	a0,-104(s0)
     8b4:	00000097          	auipc	ra,0x0
     8b8:	7d6080e7          	jalr	2006(ra) # 108a <close>
        close(1);
     8bc:	4505                	li	a0,1
     8be:	00000097          	auipc	ra,0x0
     8c2:	7cc080e7          	jalr	1996(ra) # 108a <close>
        if(dup(aa[1]) != 1){
     8c6:	f9c42503          	lw	a0,-100(s0)
     8ca:	00001097          	auipc	ra,0x1
     8ce:	810080e7          	jalr	-2032(ra) # 10da <dup>
     8d2:	4785                	li	a5,1
     8d4:	02f50063          	beq	a0,a5,8f4 <go+0x87c>
          fprintf(2, "grind: dup failed\n");
     8d8:	00001597          	auipc	a1,0x1
     8dc:	ee858593          	addi	a1,a1,-280 # 17c0 <malloc+0x326>
     8e0:	4509                	li	a0,2
     8e2:	00001097          	auipc	ra,0x1
     8e6:	ad2080e7          	jalr	-1326(ra) # 13b4 <fprintf>
          exit(1);
     8ea:	4505                	li	a0,1
     8ec:	00000097          	auipc	ra,0x0
     8f0:	776080e7          	jalr	1910(ra) # 1062 <exit>
        close(aa[1]);
     8f4:	f9c42503          	lw	a0,-100(s0)
     8f8:	00000097          	auipc	ra,0x0
     8fc:	792080e7          	jalr	1938(ra) # 108a <close>
        char *args[3] = { "echo", "hi", 0 };
     900:	00001797          	auipc	a5,0x1
     904:	ed878793          	addi	a5,a5,-296 # 17d8 <malloc+0x33e>
     908:	faf43423          	sd	a5,-88(s0)
     90c:	00001797          	auipc	a5,0x1
     910:	ed478793          	addi	a5,a5,-300 # 17e0 <malloc+0x346>
     914:	faf43823          	sd	a5,-80(s0)
     918:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     91c:	fa840593          	addi	a1,s0,-88
     920:	00001517          	auipc	a0,0x1
     924:	ec850513          	addi	a0,a0,-312 # 17e8 <malloc+0x34e>
     928:	00000097          	auipc	ra,0x0
     92c:	772080e7          	jalr	1906(ra) # 109a <exec>
        fprintf(2, "grind: echo: not found\n");
     930:	00001597          	auipc	a1,0x1
     934:	ec858593          	addi	a1,a1,-312 # 17f8 <malloc+0x35e>
     938:	4509                	li	a0,2
     93a:	00001097          	auipc	ra,0x1
     93e:	a7a080e7          	jalr	-1414(ra) # 13b4 <fprintf>
        exit(2);
     942:	4509                	li	a0,2
     944:	00000097          	auipc	ra,0x0
     948:	71e080e7          	jalr	1822(ra) # 1062 <exit>
        fprintf(2, "grind: fork failed\n");
     94c:	00001597          	auipc	a1,0x1
     950:	d3458593          	addi	a1,a1,-716 # 1680 <malloc+0x1e6>
     954:	4509                	li	a0,2
     956:	00001097          	auipc	ra,0x1
     95a:	a5e080e7          	jalr	-1442(ra) # 13b4 <fprintf>
        exit(3);
     95e:	450d                	li	a0,3
     960:	00000097          	auipc	ra,0x0
     964:	702080e7          	jalr	1794(ra) # 1062 <exit>
        close(aa[1]);
     968:	f9c42503          	lw	a0,-100(s0)
     96c:	00000097          	auipc	ra,0x0
     970:	71e080e7          	jalr	1822(ra) # 108a <close>
        close(bb[0]);
     974:	fa042503          	lw	a0,-96(s0)
     978:	00000097          	auipc	ra,0x0
     97c:	712080e7          	jalr	1810(ra) # 108a <close>
        close(0);
     980:	4501                	li	a0,0
     982:	00000097          	auipc	ra,0x0
     986:	708080e7          	jalr	1800(ra) # 108a <close>
        if(dup(aa[0]) != 0){
     98a:	f9842503          	lw	a0,-104(s0)
     98e:	00000097          	auipc	ra,0x0
     992:	74c080e7          	jalr	1868(ra) # 10da <dup>
     996:	cd19                	beqz	a0,9b4 <go+0x93c>
          fprintf(2, "grind: dup failed\n");
     998:	00001597          	auipc	a1,0x1
     99c:	e2858593          	addi	a1,a1,-472 # 17c0 <malloc+0x326>
     9a0:	4509                	li	a0,2
     9a2:	00001097          	auipc	ra,0x1
     9a6:	a12080e7          	jalr	-1518(ra) # 13b4 <fprintf>
          exit(4);
     9aa:	4511                	li	a0,4
     9ac:	00000097          	auipc	ra,0x0
     9b0:	6b6080e7          	jalr	1718(ra) # 1062 <exit>
        close(aa[0]);
     9b4:	f9842503          	lw	a0,-104(s0)
     9b8:	00000097          	auipc	ra,0x0
     9bc:	6d2080e7          	jalr	1746(ra) # 108a <close>
        close(1);
     9c0:	4505                	li	a0,1
     9c2:	00000097          	auipc	ra,0x0
     9c6:	6c8080e7          	jalr	1736(ra) # 108a <close>
        if(dup(bb[1]) != 1){
     9ca:	fa442503          	lw	a0,-92(s0)
     9ce:	00000097          	auipc	ra,0x0
     9d2:	70c080e7          	jalr	1804(ra) # 10da <dup>
     9d6:	4785                	li	a5,1
     9d8:	02f50063          	beq	a0,a5,9f8 <go+0x980>
          fprintf(2, "grind: dup failed\n");
     9dc:	00001597          	auipc	a1,0x1
     9e0:	de458593          	addi	a1,a1,-540 # 17c0 <malloc+0x326>
     9e4:	4509                	li	a0,2
     9e6:	00001097          	auipc	ra,0x1
     9ea:	9ce080e7          	jalr	-1586(ra) # 13b4 <fprintf>
          exit(5);
     9ee:	4515                	li	a0,5
     9f0:	00000097          	auipc	ra,0x0
     9f4:	672080e7          	jalr	1650(ra) # 1062 <exit>
        close(bb[1]);
     9f8:	fa442503          	lw	a0,-92(s0)
     9fc:	00000097          	auipc	ra,0x0
     a00:	68e080e7          	jalr	1678(ra) # 108a <close>
        char *args[2] = { "cat", 0 };
     a04:	00001797          	auipc	a5,0x1
     a08:	e0c78793          	addi	a5,a5,-500 # 1810 <malloc+0x376>
     a0c:	faf43423          	sd	a5,-88(s0)
     a10:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a14:	fa840593          	addi	a1,s0,-88
     a18:	00001517          	auipc	a0,0x1
     a1c:	e0050513          	addi	a0,a0,-512 # 1818 <malloc+0x37e>
     a20:	00000097          	auipc	ra,0x0
     a24:	67a080e7          	jalr	1658(ra) # 109a <exec>
        fprintf(2, "grind: cat: not found\n");
     a28:	00001597          	auipc	a1,0x1
     a2c:	df858593          	addi	a1,a1,-520 # 1820 <malloc+0x386>
     a30:	4509                	li	a0,2
     a32:	00001097          	auipc	ra,0x1
     a36:	982080e7          	jalr	-1662(ra) # 13b4 <fprintf>
        exit(6);
     a3a:	4519                	li	a0,6
     a3c:	00000097          	auipc	ra,0x0
     a40:	626080e7          	jalr	1574(ra) # 1062 <exit>
        fprintf(2, "grind: fork failed\n");
     a44:	00001597          	auipc	a1,0x1
     a48:	c3c58593          	addi	a1,a1,-964 # 1680 <malloc+0x1e6>
     a4c:	4509                	li	a0,2
     a4e:	00001097          	auipc	ra,0x1
     a52:	966080e7          	jalr	-1690(ra) # 13b4 <fprintf>
        exit(7);
     a56:	451d                	li	a0,7
     a58:	00000097          	auipc	ra,0x0
     a5c:	60a080e7          	jalr	1546(ra) # 1062 <exit>

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
     a70:	bf450513          	addi	a0,a0,-1036 # 1660 <malloc+0x1c6>
     a74:	00000097          	auipc	ra,0x0
     a78:	63e080e7          	jalr	1598(ra) # 10b2 <unlink>
  unlink("b");
     a7c:	00001517          	auipc	a0,0x1
     a80:	b9450513          	addi	a0,a0,-1132 # 1610 <malloc+0x176>
     a84:	00000097          	auipc	ra,0x0
     a88:	62e080e7          	jalr	1582(ra) # 10b2 <unlink>
  
  int pid1 = fork();
     a8c:	00000097          	auipc	ra,0x0
     a90:	5ce080e7          	jalr	1486(ra) # 105a <fork>
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
     aba:	bca50513          	addi	a0,a0,-1078 # 1680 <malloc+0x1e6>
     abe:	00001097          	auipc	ra,0x1
     ac2:	924080e7          	jalr	-1756(ra) # 13e2 <printf>
    exit(1);
     ac6:	4505                	li	a0,1
     ac8:	00000097          	auipc	ra,0x0
     acc:	59a080e7          	jalr	1434(ra) # 1062 <exit>
    exit(0);
  }

  int pid2 = fork();
     ad0:	00000097          	auipc	ra,0x0
     ad4:	58a080e7          	jalr	1418(ra) # 105a <fork>
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
     aec:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x291>
     af0:	8fb9                	xor	a5,a5,a4
     af2:	e29c                	sd	a5,0(a3)
    go(1);
     af4:	4505                	li	a0,1
     af6:	fffff097          	auipc	ra,0xfffff
     afa:	582080e7          	jalr	1410(ra) # 78 <go>
    printf("grind: fork failed\n");
     afe:	00001517          	auipc	a0,0x1
     b02:	b8250513          	addi	a0,a0,-1150 # 1680 <malloc+0x1e6>
     b06:	00001097          	auipc	ra,0x1
     b0a:	8dc080e7          	jalr	-1828(ra) # 13e2 <printf>
    exit(1);
     b0e:	4505                	li	a0,1
     b10:	00000097          	auipc	ra,0x0
     b14:	552080e7          	jalr	1362(ra) # 1062 <exit>
    exit(0);
  }

  int st1 = -1;
     b18:	57fd                	li	a5,-1
     b1a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b1e:	fdc40513          	addi	a0,s0,-36
     b22:	00000097          	auipc	ra,0x0
     b26:	548080e7          	jalr	1352(ra) # 106a <wait>
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
     b3e:	530080e7          	jalr	1328(ra) # 106a <wait>

  exit(0);
     b42:	4501                	li	a0,0
     b44:	00000097          	auipc	ra,0x0
     b48:	51e080e7          	jalr	1310(ra) # 1062 <exit>
    kill(pid1);
     b4c:	8526                	mv	a0,s1
     b4e:	00000097          	auipc	ra,0x0
     b52:	544080e7          	jalr	1348(ra) # 1092 <kill>
    kill(pid2);
     b56:	854a                	mv	a0,s2
     b58:	00000097          	auipc	ra,0x0
     b5c:	53a080e7          	jalr	1338(ra) # 1092 <kill>
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
     b84:	572080e7          	jalr	1394(ra) # 10f2 <sleep>
    rand_next += 1;
     b88:	609c                	ld	a5,0(s1)
     b8a:	0785                	addi	a5,a5,1
     b8c:	e09c                	sd	a5,0(s1)
    int pid = fork();
     b8e:	00000097          	auipc	ra,0x0
     b92:	4cc080e7          	jalr	1228(ra) # 105a <fork>
    if(pid == 0){
     b96:	d165                	beqz	a0,b76 <main+0x14>
    if(pid > 0){
     b98:	fea053e3          	blez	a0,b7e <main+0x1c>
      wait(0);
     b9c:	4501                	li	a0,0
     b9e:	00000097          	auipc	ra,0x0
     ba2:	4cc080e7          	jalr	1228(ra) # 106a <wait>
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
     bdc:	172080e7          	jalr	370(ra) # d4a <twhoami>
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
     c28:	ca450513          	addi	a0,a0,-860 # 18c8 <malloc+0x42e>
     c2c:	00000097          	auipc	ra,0x0
     c30:	7b6080e7          	jalr	1974(ra) # 13e2 <printf>
        exit(-1);
     c34:	557d                	li	a0,-1
     c36:	00000097          	auipc	ra,0x0
     c3a:	42c080e7          	jalr	1068(ra) # 1062 <exit>
    {
        // give up the cpu for other threads
        tyield();
     c3e:	00000097          	auipc	ra,0x0
     c42:	0f4080e7          	jalr	244(ra) # d32 <tyield>
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
     c5c:	0f2080e7          	jalr	242(ra) # d4a <twhoami>
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
     ca0:	096080e7          	jalr	150(ra) # d32 <tyield>
}
     ca4:	60e2                	ld	ra,24(sp)
     ca6:	6442                	ld	s0,16(sp)
     ca8:	64a2                	ld	s1,8(sp)
     caa:	6105                	addi	sp,sp,32
     cac:	8082                	ret
        printf("releasing lock we are not holding");
     cae:	00001517          	auipc	a0,0x1
     cb2:	c4250513          	addi	a0,a0,-958 # 18f0 <malloc+0x456>
     cb6:	00000097          	auipc	ra,0x0
     cba:	72c080e7          	jalr	1836(ra) # 13e2 <printf>
        exit(-1);
     cbe:	557d                	li	a0,-1
     cc0:	00000097          	auipc	ra,0x0
     cc4:	3a2080e7          	jalr	930(ra) # 1062 <exit>

0000000000000cc8 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
     cc8:	1141                	addi	sp,sp,-16
     cca:	e422                	sd	s0,8(sp)
     ccc:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
     cce:	00001717          	auipc	a4,0x1
     cd2:	34273703          	ld	a4,834(a4) # 2010 <current_thread>
     cd6:	47c1                	li	a5,16
     cd8:	c319                	beqz	a4,cde <tsched+0x16>
    for (int i = 0; i < 16; i++) {
     cda:	37fd                	addiw	a5,a5,-1
     cdc:	fff5                	bnez	a5,cd8 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
     cde:	6422                	ld	s0,8(sp)
     ce0:	0141                	addi	sp,sp,16
     ce2:	8082                	ret

0000000000000ce4 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     ce4:	7179                	addi	sp,sp,-48
     ce6:	f406                	sd	ra,40(sp)
     ce8:	f022                	sd	s0,32(sp)
     cea:	ec26                	sd	s1,24(sp)
     cec:	e84a                	sd	s2,16(sp)
     cee:	e44e                	sd	s3,8(sp)
     cf0:	1800                	addi	s0,sp,48
     cf2:	84aa                	mv	s1,a0
     cf4:	89b2                	mv	s3,a2
     cf6:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     cf8:	09000513          	li	a0,144
     cfc:	00000097          	auipc	ra,0x0
     d00:	79e080e7          	jalr	1950(ra) # 149a <malloc>
     d04:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     d06:	478d                	li	a5,3
     d08:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     d0a:	609c                	ld	a5,0(s1)
     d0c:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
     d10:	609c                	ld	a5,0(s1)
     d12:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
     d16:	70a2                	ld	ra,40(sp)
     d18:	7402                	ld	s0,32(sp)
     d1a:	64e2                	ld	s1,24(sp)
     d1c:	6942                	ld	s2,16(sp)
     d1e:	69a2                	ld	s3,8(sp)
     d20:	6145                	addi	sp,sp,48
     d22:	8082                	ret

0000000000000d24 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
     d24:	1141                	addi	sp,sp,-16
     d26:	e422                	sd	s0,8(sp)
     d28:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
     d2a:	4501                	li	a0,0
     d2c:	6422                	ld	s0,8(sp)
     d2e:	0141                	addi	sp,sp,16
     d30:	8082                	ret

0000000000000d32 <tyield>:

void tyield()
{
     d32:	1141                	addi	sp,sp,-16
     d34:	e422                	sd	s0,8(sp)
     d36:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
     d38:	00001797          	auipc	a5,0x1
     d3c:	2d87b783          	ld	a5,728(a5) # 2010 <current_thread>
     d40:	470d                	li	a4,3
     d42:	dfb8                	sw	a4,120(a5)
    tsched();
}
     d44:	6422                	ld	s0,8(sp)
     d46:	0141                	addi	sp,sp,16
     d48:	8082                	ret

0000000000000d4a <twhoami>:

uint8 twhoami()
{
     d4a:	1141                	addi	sp,sp,-16
     d4c:	e422                	sd	s0,8(sp)
     d4e:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
     d50:	4501                	li	a0,0
     d52:	6422                	ld	s0,8(sp)
     d54:	0141                	addi	sp,sp,16
     d56:	8082                	ret

0000000000000d58 <tswtch>:
     d58:	00153023          	sd	ra,0(a0)
     d5c:	00253423          	sd	sp,8(a0)
     d60:	e900                	sd	s0,16(a0)
     d62:	ed04                	sd	s1,24(a0)
     d64:	03253023          	sd	s2,32(a0)
     d68:	03353423          	sd	s3,40(a0)
     d6c:	03453823          	sd	s4,48(a0)
     d70:	03553c23          	sd	s5,56(a0)
     d74:	05653023          	sd	s6,64(a0)
     d78:	05753423          	sd	s7,72(a0)
     d7c:	05853823          	sd	s8,80(a0)
     d80:	05953c23          	sd	s9,88(a0)
     d84:	07a53023          	sd	s10,96(a0)
     d88:	07b53423          	sd	s11,104(a0)
     d8c:	0005b083          	ld	ra,0(a1)
     d90:	0085b103          	ld	sp,8(a1)
     d94:	6980                	ld	s0,16(a1)
     d96:	6d84                	ld	s1,24(a1)
     d98:	0205b903          	ld	s2,32(a1)
     d9c:	0285b983          	ld	s3,40(a1)
     da0:	0305ba03          	ld	s4,48(a1)
     da4:	0385ba83          	ld	s5,56(a1)
     da8:	0405bb03          	ld	s6,64(a1)
     dac:	0485bb83          	ld	s7,72(a1)
     db0:	0505bc03          	ld	s8,80(a1)
     db4:	0585bc83          	ld	s9,88(a1)
     db8:	0605bd03          	ld	s10,96(a1)
     dbc:	0685bd83          	ld	s11,104(a1)
     dc0:	8082                	ret

0000000000000dc2 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     dc2:	1101                	addi	sp,sp,-32
     dc4:	ec06                	sd	ra,24(sp)
     dc6:	e822                	sd	s0,16(sp)
     dc8:	e426                	sd	s1,8(sp)
     dca:	e04a                	sd	s2,0(sp)
     dcc:	1000                	addi	s0,sp,32
     dce:	84aa                	mv	s1,a0
     dd0:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     dd2:	09000513          	li	a0,144
     dd6:	00000097          	auipc	ra,0x0
     dda:	6c4080e7          	jalr	1732(ra) # 149a <malloc>

    main_thread->tid = 0;
     dde:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     de2:	85ca                	mv	a1,s2
     de4:	8526                	mv	a0,s1
     de6:	00000097          	auipc	ra,0x0
     dea:	d7c080e7          	jalr	-644(ra) # b62 <main>
    exit(res);
     dee:	00000097          	auipc	ra,0x0
     df2:	274080e7          	jalr	628(ra) # 1062 <exit>

0000000000000df6 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     df6:	1141                	addi	sp,sp,-16
     df8:	e422                	sd	s0,8(sp)
     dfa:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
     dfc:	87aa                	mv	a5,a0
     dfe:	0585                	addi	a1,a1,1
     e00:	0785                	addi	a5,a5,1
     e02:	fff5c703          	lbu	a4,-1(a1)
     e06:	fee78fa3          	sb	a4,-1(a5)
     e0a:	fb75                	bnez	a4,dfe <strcpy+0x8>
        ;
    return os;
}
     e0c:	6422                	ld	s0,8(sp)
     e0e:	0141                	addi	sp,sp,16
     e10:	8082                	ret

0000000000000e12 <strcmp>:

int strcmp(const char *p, const char *q)
{
     e12:	1141                	addi	sp,sp,-16
     e14:	e422                	sd	s0,8(sp)
     e16:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
     e18:	00054783          	lbu	a5,0(a0)
     e1c:	cb91                	beqz	a5,e30 <strcmp+0x1e>
     e1e:	0005c703          	lbu	a4,0(a1)
     e22:	00f71763          	bne	a4,a5,e30 <strcmp+0x1e>
        p++, q++;
     e26:	0505                	addi	a0,a0,1
     e28:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
     e2a:	00054783          	lbu	a5,0(a0)
     e2e:	fbe5                	bnez	a5,e1e <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
     e30:	0005c503          	lbu	a0,0(a1)
}
     e34:	40a7853b          	subw	a0,a5,a0
     e38:	6422                	ld	s0,8(sp)
     e3a:	0141                	addi	sp,sp,16
     e3c:	8082                	ret

0000000000000e3e <strlen>:

uint strlen(const char *s)
{
     e3e:	1141                	addi	sp,sp,-16
     e40:	e422                	sd	s0,8(sp)
     e42:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
     e44:	00054783          	lbu	a5,0(a0)
     e48:	cf91                	beqz	a5,e64 <strlen+0x26>
     e4a:	0505                	addi	a0,a0,1
     e4c:	87aa                	mv	a5,a0
     e4e:	86be                	mv	a3,a5
     e50:	0785                	addi	a5,a5,1
     e52:	fff7c703          	lbu	a4,-1(a5)
     e56:	ff65                	bnez	a4,e4e <strlen+0x10>
     e58:	40a6853b          	subw	a0,a3,a0
     e5c:	2505                	addiw	a0,a0,1
        ;
    return n;
}
     e5e:	6422                	ld	s0,8(sp)
     e60:	0141                	addi	sp,sp,16
     e62:	8082                	ret
    for (n = 0; s[n]; n++)
     e64:	4501                	li	a0,0
     e66:	bfe5                	j	e5e <strlen+0x20>

0000000000000e68 <memset>:

void *
memset(void *dst, int c, uint n)
{
     e68:	1141                	addi	sp,sp,-16
     e6a:	e422                	sd	s0,8(sp)
     e6c:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
     e6e:	ca19                	beqz	a2,e84 <memset+0x1c>
     e70:	87aa                	mv	a5,a0
     e72:	1602                	slli	a2,a2,0x20
     e74:	9201                	srli	a2,a2,0x20
     e76:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
     e7a:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
     e7e:	0785                	addi	a5,a5,1
     e80:	fee79de3          	bne	a5,a4,e7a <memset+0x12>
    }
    return dst;
}
     e84:	6422                	ld	s0,8(sp)
     e86:	0141                	addi	sp,sp,16
     e88:	8082                	ret

0000000000000e8a <strchr>:

char *
strchr(const char *s, char c)
{
     e8a:	1141                	addi	sp,sp,-16
     e8c:	e422                	sd	s0,8(sp)
     e8e:	0800                	addi	s0,sp,16
    for (; *s; s++)
     e90:	00054783          	lbu	a5,0(a0)
     e94:	cb99                	beqz	a5,eaa <strchr+0x20>
        if (*s == c)
     e96:	00f58763          	beq	a1,a5,ea4 <strchr+0x1a>
    for (; *s; s++)
     e9a:	0505                	addi	a0,a0,1
     e9c:	00054783          	lbu	a5,0(a0)
     ea0:	fbfd                	bnez	a5,e96 <strchr+0xc>
            return (char *)s;
    return 0;
     ea2:	4501                	li	a0,0
}
     ea4:	6422                	ld	s0,8(sp)
     ea6:	0141                	addi	sp,sp,16
     ea8:	8082                	ret
    return 0;
     eaa:	4501                	li	a0,0
     eac:	bfe5                	j	ea4 <strchr+0x1a>

0000000000000eae <gets>:

char *
gets(char *buf, int max)
{
     eae:	711d                	addi	sp,sp,-96
     eb0:	ec86                	sd	ra,88(sp)
     eb2:	e8a2                	sd	s0,80(sp)
     eb4:	e4a6                	sd	s1,72(sp)
     eb6:	e0ca                	sd	s2,64(sp)
     eb8:	fc4e                	sd	s3,56(sp)
     eba:	f852                	sd	s4,48(sp)
     ebc:	f456                	sd	s5,40(sp)
     ebe:	f05a                	sd	s6,32(sp)
     ec0:	ec5e                	sd	s7,24(sp)
     ec2:	1080                	addi	s0,sp,96
     ec4:	8baa                	mv	s7,a0
     ec6:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
     ec8:	892a                	mv	s2,a0
     eca:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
     ecc:	4aa9                	li	s5,10
     ece:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
     ed0:	89a6                	mv	s3,s1
     ed2:	2485                	addiw	s1,s1,1
     ed4:	0344d863          	bge	s1,s4,f04 <gets+0x56>
        cc = read(0, &c, 1);
     ed8:	4605                	li	a2,1
     eda:	faf40593          	addi	a1,s0,-81
     ede:	4501                	li	a0,0
     ee0:	00000097          	auipc	ra,0x0
     ee4:	19a080e7          	jalr	410(ra) # 107a <read>
        if (cc < 1)
     ee8:	00a05e63          	blez	a0,f04 <gets+0x56>
        buf[i++] = c;
     eec:	faf44783          	lbu	a5,-81(s0)
     ef0:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
     ef4:	01578763          	beq	a5,s5,f02 <gets+0x54>
     ef8:	0905                	addi	s2,s2,1
     efa:	fd679be3          	bne	a5,s6,ed0 <gets+0x22>
    for (i = 0; i + 1 < max;)
     efe:	89a6                	mv	s3,s1
     f00:	a011                	j	f04 <gets+0x56>
     f02:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
     f04:	99de                	add	s3,s3,s7
     f06:	00098023          	sb	zero,0(s3)
    return buf;
}
     f0a:	855e                	mv	a0,s7
     f0c:	60e6                	ld	ra,88(sp)
     f0e:	6446                	ld	s0,80(sp)
     f10:	64a6                	ld	s1,72(sp)
     f12:	6906                	ld	s2,64(sp)
     f14:	79e2                	ld	s3,56(sp)
     f16:	7a42                	ld	s4,48(sp)
     f18:	7aa2                	ld	s5,40(sp)
     f1a:	7b02                	ld	s6,32(sp)
     f1c:	6be2                	ld	s7,24(sp)
     f1e:	6125                	addi	sp,sp,96
     f20:	8082                	ret

0000000000000f22 <stat>:

int stat(const char *n, struct stat *st)
{
     f22:	1101                	addi	sp,sp,-32
     f24:	ec06                	sd	ra,24(sp)
     f26:	e822                	sd	s0,16(sp)
     f28:	e426                	sd	s1,8(sp)
     f2a:	e04a                	sd	s2,0(sp)
     f2c:	1000                	addi	s0,sp,32
     f2e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     f30:	4581                	li	a1,0
     f32:	00000097          	auipc	ra,0x0
     f36:	170080e7          	jalr	368(ra) # 10a2 <open>
    if (fd < 0)
     f3a:	02054563          	bltz	a0,f64 <stat+0x42>
     f3e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
     f40:	85ca                	mv	a1,s2
     f42:	00000097          	auipc	ra,0x0
     f46:	178080e7          	jalr	376(ra) # 10ba <fstat>
     f4a:	892a                	mv	s2,a0
    close(fd);
     f4c:	8526                	mv	a0,s1
     f4e:	00000097          	auipc	ra,0x0
     f52:	13c080e7          	jalr	316(ra) # 108a <close>
    return r;
}
     f56:	854a                	mv	a0,s2
     f58:	60e2                	ld	ra,24(sp)
     f5a:	6442                	ld	s0,16(sp)
     f5c:	64a2                	ld	s1,8(sp)
     f5e:	6902                	ld	s2,0(sp)
     f60:	6105                	addi	sp,sp,32
     f62:	8082                	ret
        return -1;
     f64:	597d                	li	s2,-1
     f66:	bfc5                	j	f56 <stat+0x34>

0000000000000f68 <atoi>:

int atoi(const char *s)
{
     f68:	1141                	addi	sp,sp,-16
     f6a:	e422                	sd	s0,8(sp)
     f6c:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
     f6e:	00054683          	lbu	a3,0(a0)
     f72:	fd06879b          	addiw	a5,a3,-48
     f76:	0ff7f793          	zext.b	a5,a5
     f7a:	4625                	li	a2,9
     f7c:	02f66863          	bltu	a2,a5,fac <atoi+0x44>
     f80:	872a                	mv	a4,a0
    n = 0;
     f82:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
     f84:	0705                	addi	a4,a4,1
     f86:	0025179b          	slliw	a5,a0,0x2
     f8a:	9fa9                	addw	a5,a5,a0
     f8c:	0017979b          	slliw	a5,a5,0x1
     f90:	9fb5                	addw	a5,a5,a3
     f92:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
     f96:	00074683          	lbu	a3,0(a4)
     f9a:	fd06879b          	addiw	a5,a3,-48
     f9e:	0ff7f793          	zext.b	a5,a5
     fa2:	fef671e3          	bgeu	a2,a5,f84 <atoi+0x1c>
    return n;
}
     fa6:	6422                	ld	s0,8(sp)
     fa8:	0141                	addi	sp,sp,16
     faa:	8082                	ret
    n = 0;
     fac:	4501                	li	a0,0
     fae:	bfe5                	j	fa6 <atoi+0x3e>

0000000000000fb0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
     fb0:	1141                	addi	sp,sp,-16
     fb2:	e422                	sd	s0,8(sp)
     fb4:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
     fb6:	02b57463          	bgeu	a0,a1,fde <memmove+0x2e>
    {
        while (n-- > 0)
     fba:	00c05f63          	blez	a2,fd8 <memmove+0x28>
     fbe:	1602                	slli	a2,a2,0x20
     fc0:	9201                	srli	a2,a2,0x20
     fc2:	00c507b3          	add	a5,a0,a2
    dst = vdst;
     fc6:	872a                	mv	a4,a0
            *dst++ = *src++;
     fc8:	0585                	addi	a1,a1,1
     fca:	0705                	addi	a4,a4,1
     fcc:	fff5c683          	lbu	a3,-1(a1)
     fd0:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
     fd4:	fee79ae3          	bne	a5,a4,fc8 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
     fd8:	6422                	ld	s0,8(sp)
     fda:	0141                	addi	sp,sp,16
     fdc:	8082                	ret
        dst += n;
     fde:	00c50733          	add	a4,a0,a2
        src += n;
     fe2:	95b2                	add	a1,a1,a2
        while (n-- > 0)
     fe4:	fec05ae3          	blez	a2,fd8 <memmove+0x28>
     fe8:	fff6079b          	addiw	a5,a2,-1
     fec:	1782                	slli	a5,a5,0x20
     fee:	9381                	srli	a5,a5,0x20
     ff0:	fff7c793          	not	a5,a5
     ff4:	97ba                	add	a5,a5,a4
            *--dst = *--src;
     ff6:	15fd                	addi	a1,a1,-1
     ff8:	177d                	addi	a4,a4,-1
     ffa:	0005c683          	lbu	a3,0(a1)
     ffe:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    1002:	fee79ae3          	bne	a5,a4,ff6 <memmove+0x46>
    1006:	bfc9                	j	fd8 <memmove+0x28>

0000000000001008 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    1008:	1141                	addi	sp,sp,-16
    100a:	e422                	sd	s0,8(sp)
    100c:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
    100e:	ca05                	beqz	a2,103e <memcmp+0x36>
    1010:	fff6069b          	addiw	a3,a2,-1
    1014:	1682                	slli	a3,a3,0x20
    1016:	9281                	srli	a3,a3,0x20
    1018:	0685                	addi	a3,a3,1
    101a:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
    101c:	00054783          	lbu	a5,0(a0)
    1020:	0005c703          	lbu	a4,0(a1)
    1024:	00e79863          	bne	a5,a4,1034 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
    1028:	0505                	addi	a0,a0,1
        p2++;
    102a:	0585                	addi	a1,a1,1
    while (n-- > 0)
    102c:	fed518e3          	bne	a0,a3,101c <memcmp+0x14>
    }
    return 0;
    1030:	4501                	li	a0,0
    1032:	a019                	j	1038 <memcmp+0x30>
            return *p1 - *p2;
    1034:	40e7853b          	subw	a0,a5,a4
}
    1038:	6422                	ld	s0,8(sp)
    103a:	0141                	addi	sp,sp,16
    103c:	8082                	ret
    return 0;
    103e:	4501                	li	a0,0
    1040:	bfe5                	j	1038 <memcmp+0x30>

0000000000001042 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1042:	1141                	addi	sp,sp,-16
    1044:	e406                	sd	ra,8(sp)
    1046:	e022                	sd	s0,0(sp)
    1048:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    104a:	00000097          	auipc	ra,0x0
    104e:	f66080e7          	jalr	-154(ra) # fb0 <memmove>
}
    1052:	60a2                	ld	ra,8(sp)
    1054:	6402                	ld	s0,0(sp)
    1056:	0141                	addi	sp,sp,16
    1058:	8082                	ret

000000000000105a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    105a:	4885                	li	a7,1
 ecall
    105c:	00000073          	ecall
 ret
    1060:	8082                	ret

0000000000001062 <exit>:
.global exit
exit:
 li a7, SYS_exit
    1062:	4889                	li	a7,2
 ecall
    1064:	00000073          	ecall
 ret
    1068:	8082                	ret

000000000000106a <wait>:
.global wait
wait:
 li a7, SYS_wait
    106a:	488d                	li	a7,3
 ecall
    106c:	00000073          	ecall
 ret
    1070:	8082                	ret

0000000000001072 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    1072:	4891                	li	a7,4
 ecall
    1074:	00000073          	ecall
 ret
    1078:	8082                	ret

000000000000107a <read>:
.global read
read:
 li a7, SYS_read
    107a:	4895                	li	a7,5
 ecall
    107c:	00000073          	ecall
 ret
    1080:	8082                	ret

0000000000001082 <write>:
.global write
write:
 li a7, SYS_write
    1082:	48c1                	li	a7,16
 ecall
    1084:	00000073          	ecall
 ret
    1088:	8082                	ret

000000000000108a <close>:
.global close
close:
 li a7, SYS_close
    108a:	48d5                	li	a7,21
 ecall
    108c:	00000073          	ecall
 ret
    1090:	8082                	ret

0000000000001092 <kill>:
.global kill
kill:
 li a7, SYS_kill
    1092:	4899                	li	a7,6
 ecall
    1094:	00000073          	ecall
 ret
    1098:	8082                	ret

000000000000109a <exec>:
.global exec
exec:
 li a7, SYS_exec
    109a:	489d                	li	a7,7
 ecall
    109c:	00000073          	ecall
 ret
    10a0:	8082                	ret

00000000000010a2 <open>:
.global open
open:
 li a7, SYS_open
    10a2:	48bd                	li	a7,15
 ecall
    10a4:	00000073          	ecall
 ret
    10a8:	8082                	ret

00000000000010aa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    10aa:	48c5                	li	a7,17
 ecall
    10ac:	00000073          	ecall
 ret
    10b0:	8082                	ret

00000000000010b2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    10b2:	48c9                	li	a7,18
 ecall
    10b4:	00000073          	ecall
 ret
    10b8:	8082                	ret

00000000000010ba <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    10ba:	48a1                	li	a7,8
 ecall
    10bc:	00000073          	ecall
 ret
    10c0:	8082                	ret

00000000000010c2 <link>:
.global link
link:
 li a7, SYS_link
    10c2:	48cd                	li	a7,19
 ecall
    10c4:	00000073          	ecall
 ret
    10c8:	8082                	ret

00000000000010ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    10ca:	48d1                	li	a7,20
 ecall
    10cc:	00000073          	ecall
 ret
    10d0:	8082                	ret

00000000000010d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    10d2:	48a5                	li	a7,9
 ecall
    10d4:	00000073          	ecall
 ret
    10d8:	8082                	ret

00000000000010da <dup>:
.global dup
dup:
 li a7, SYS_dup
    10da:	48a9                	li	a7,10
 ecall
    10dc:	00000073          	ecall
 ret
    10e0:	8082                	ret

00000000000010e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    10e2:	48ad                	li	a7,11
 ecall
    10e4:	00000073          	ecall
 ret
    10e8:	8082                	ret

00000000000010ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    10ea:	48b1                	li	a7,12
 ecall
    10ec:	00000073          	ecall
 ret
    10f0:	8082                	ret

00000000000010f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    10f2:	48b5                	li	a7,13
 ecall
    10f4:	00000073          	ecall
 ret
    10f8:	8082                	ret

00000000000010fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    10fa:	48b9                	li	a7,14
 ecall
    10fc:	00000073          	ecall
 ret
    1100:	8082                	ret

0000000000001102 <ps>:
.global ps
ps:
 li a7, SYS_ps
    1102:	48d9                	li	a7,22
 ecall
    1104:	00000073          	ecall
 ret
    1108:	8082                	ret

000000000000110a <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
    110a:	48dd                	li	a7,23
 ecall
    110c:	00000073          	ecall
 ret
    1110:	8082                	ret

0000000000001112 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
    1112:	48e1                	li	a7,24
 ecall
    1114:	00000073          	ecall
 ret
    1118:	8082                	ret

000000000000111a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    111a:	1101                	addi	sp,sp,-32
    111c:	ec06                	sd	ra,24(sp)
    111e:	e822                	sd	s0,16(sp)
    1120:	1000                	addi	s0,sp,32
    1122:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    1126:	4605                	li	a2,1
    1128:	fef40593          	addi	a1,s0,-17
    112c:	00000097          	auipc	ra,0x0
    1130:	f56080e7          	jalr	-170(ra) # 1082 <write>
}
    1134:	60e2                	ld	ra,24(sp)
    1136:	6442                	ld	s0,16(sp)
    1138:	6105                	addi	sp,sp,32
    113a:	8082                	ret

000000000000113c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    113c:	7139                	addi	sp,sp,-64
    113e:	fc06                	sd	ra,56(sp)
    1140:	f822                	sd	s0,48(sp)
    1142:	f426                	sd	s1,40(sp)
    1144:	f04a                	sd	s2,32(sp)
    1146:	ec4e                	sd	s3,24(sp)
    1148:	0080                	addi	s0,sp,64
    114a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    114c:	c299                	beqz	a3,1152 <printint+0x16>
    114e:	0805c963          	bltz	a1,11e0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1152:	2581                	sext.w	a1,a1
  neg = 0;
    1154:	4881                	li	a7,0
    1156:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    115a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    115c:	2601                	sext.w	a2,a2
    115e:	00001517          	auipc	a0,0x1
    1162:	81a50513          	addi	a0,a0,-2022 # 1978 <digits>
    1166:	883a                	mv	a6,a4
    1168:	2705                	addiw	a4,a4,1
    116a:	02c5f7bb          	remuw	a5,a1,a2
    116e:	1782                	slli	a5,a5,0x20
    1170:	9381                	srli	a5,a5,0x20
    1172:	97aa                	add	a5,a5,a0
    1174:	0007c783          	lbu	a5,0(a5)
    1178:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    117c:	0005879b          	sext.w	a5,a1
    1180:	02c5d5bb          	divuw	a1,a1,a2
    1184:	0685                	addi	a3,a3,1
    1186:	fec7f0e3          	bgeu	a5,a2,1166 <printint+0x2a>
  if(neg)
    118a:	00088c63          	beqz	a7,11a2 <printint+0x66>
    buf[i++] = '-';
    118e:	fd070793          	addi	a5,a4,-48
    1192:	00878733          	add	a4,a5,s0
    1196:	02d00793          	li	a5,45
    119a:	fef70823          	sb	a5,-16(a4)
    119e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    11a2:	02e05863          	blez	a4,11d2 <printint+0x96>
    11a6:	fc040793          	addi	a5,s0,-64
    11aa:	00e78933          	add	s2,a5,a4
    11ae:	fff78993          	addi	s3,a5,-1
    11b2:	99ba                	add	s3,s3,a4
    11b4:	377d                	addiw	a4,a4,-1
    11b6:	1702                	slli	a4,a4,0x20
    11b8:	9301                	srli	a4,a4,0x20
    11ba:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    11be:	fff94583          	lbu	a1,-1(s2)
    11c2:	8526                	mv	a0,s1
    11c4:	00000097          	auipc	ra,0x0
    11c8:	f56080e7          	jalr	-170(ra) # 111a <putc>
  while(--i >= 0)
    11cc:	197d                	addi	s2,s2,-1
    11ce:	ff3918e3          	bne	s2,s3,11be <printint+0x82>
}
    11d2:	70e2                	ld	ra,56(sp)
    11d4:	7442                	ld	s0,48(sp)
    11d6:	74a2                	ld	s1,40(sp)
    11d8:	7902                	ld	s2,32(sp)
    11da:	69e2                	ld	s3,24(sp)
    11dc:	6121                	addi	sp,sp,64
    11de:	8082                	ret
    x = -xx;
    11e0:	40b005bb          	negw	a1,a1
    neg = 1;
    11e4:	4885                	li	a7,1
    x = -xx;
    11e6:	bf85                	j	1156 <printint+0x1a>

00000000000011e8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    11e8:	715d                	addi	sp,sp,-80
    11ea:	e486                	sd	ra,72(sp)
    11ec:	e0a2                	sd	s0,64(sp)
    11ee:	fc26                	sd	s1,56(sp)
    11f0:	f84a                	sd	s2,48(sp)
    11f2:	f44e                	sd	s3,40(sp)
    11f4:	f052                	sd	s4,32(sp)
    11f6:	ec56                	sd	s5,24(sp)
    11f8:	e85a                	sd	s6,16(sp)
    11fa:	e45e                	sd	s7,8(sp)
    11fc:	e062                	sd	s8,0(sp)
    11fe:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1200:	0005c903          	lbu	s2,0(a1)
    1204:	18090c63          	beqz	s2,139c <vprintf+0x1b4>
    1208:	8aaa                	mv	s5,a0
    120a:	8bb2                	mv	s7,a2
    120c:	00158493          	addi	s1,a1,1
  state = 0;
    1210:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1212:	02500a13          	li	s4,37
    1216:	4b55                	li	s6,21
    1218:	a839                	j	1236 <vprintf+0x4e>
        putc(fd, c);
    121a:	85ca                	mv	a1,s2
    121c:	8556                	mv	a0,s5
    121e:	00000097          	auipc	ra,0x0
    1222:	efc080e7          	jalr	-260(ra) # 111a <putc>
    1226:	a019                	j	122c <vprintf+0x44>
    } else if(state == '%'){
    1228:	01498d63          	beq	s3,s4,1242 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    122c:	0485                	addi	s1,s1,1
    122e:	fff4c903          	lbu	s2,-1(s1)
    1232:	16090563          	beqz	s2,139c <vprintf+0x1b4>
    if(state == 0){
    1236:	fe0999e3          	bnez	s3,1228 <vprintf+0x40>
      if(c == '%'){
    123a:	ff4910e3          	bne	s2,s4,121a <vprintf+0x32>
        state = '%';
    123e:	89d2                	mv	s3,s4
    1240:	b7f5                	j	122c <vprintf+0x44>
      if(c == 'd'){
    1242:	13490263          	beq	s2,s4,1366 <vprintf+0x17e>
    1246:	f9d9079b          	addiw	a5,s2,-99
    124a:	0ff7f793          	zext.b	a5,a5
    124e:	12fb6563          	bltu	s6,a5,1378 <vprintf+0x190>
    1252:	f9d9079b          	addiw	a5,s2,-99
    1256:	0ff7f713          	zext.b	a4,a5
    125a:	10eb6f63          	bltu	s6,a4,1378 <vprintf+0x190>
    125e:	00271793          	slli	a5,a4,0x2
    1262:	00000717          	auipc	a4,0x0
    1266:	6be70713          	addi	a4,a4,1726 # 1920 <malloc+0x486>
    126a:	97ba                	add	a5,a5,a4
    126c:	439c                	lw	a5,0(a5)
    126e:	97ba                	add	a5,a5,a4
    1270:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1272:	008b8913          	addi	s2,s7,8
    1276:	4685                	li	a3,1
    1278:	4629                	li	a2,10
    127a:	000ba583          	lw	a1,0(s7)
    127e:	8556                	mv	a0,s5
    1280:	00000097          	auipc	ra,0x0
    1284:	ebc080e7          	jalr	-324(ra) # 113c <printint>
    1288:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    128a:	4981                	li	s3,0
    128c:	b745                	j	122c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    128e:	008b8913          	addi	s2,s7,8
    1292:	4681                	li	a3,0
    1294:	4629                	li	a2,10
    1296:	000ba583          	lw	a1,0(s7)
    129a:	8556                	mv	a0,s5
    129c:	00000097          	auipc	ra,0x0
    12a0:	ea0080e7          	jalr	-352(ra) # 113c <printint>
    12a4:	8bca                	mv	s7,s2
      state = 0;
    12a6:	4981                	li	s3,0
    12a8:	b751                	j	122c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    12aa:	008b8913          	addi	s2,s7,8
    12ae:	4681                	li	a3,0
    12b0:	4641                	li	a2,16
    12b2:	000ba583          	lw	a1,0(s7)
    12b6:	8556                	mv	a0,s5
    12b8:	00000097          	auipc	ra,0x0
    12bc:	e84080e7          	jalr	-380(ra) # 113c <printint>
    12c0:	8bca                	mv	s7,s2
      state = 0;
    12c2:	4981                	li	s3,0
    12c4:	b7a5                	j	122c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    12c6:	008b8c13          	addi	s8,s7,8
    12ca:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    12ce:	03000593          	li	a1,48
    12d2:	8556                	mv	a0,s5
    12d4:	00000097          	auipc	ra,0x0
    12d8:	e46080e7          	jalr	-442(ra) # 111a <putc>
  putc(fd, 'x');
    12dc:	07800593          	li	a1,120
    12e0:	8556                	mv	a0,s5
    12e2:	00000097          	auipc	ra,0x0
    12e6:	e38080e7          	jalr	-456(ra) # 111a <putc>
    12ea:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    12ec:	00000b97          	auipc	s7,0x0
    12f0:	68cb8b93          	addi	s7,s7,1676 # 1978 <digits>
    12f4:	03c9d793          	srli	a5,s3,0x3c
    12f8:	97de                	add	a5,a5,s7
    12fa:	0007c583          	lbu	a1,0(a5)
    12fe:	8556                	mv	a0,s5
    1300:	00000097          	auipc	ra,0x0
    1304:	e1a080e7          	jalr	-486(ra) # 111a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1308:	0992                	slli	s3,s3,0x4
    130a:	397d                	addiw	s2,s2,-1
    130c:	fe0914e3          	bnez	s2,12f4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1310:	8be2                	mv	s7,s8
      state = 0;
    1312:	4981                	li	s3,0
    1314:	bf21                	j	122c <vprintf+0x44>
        s = va_arg(ap, char*);
    1316:	008b8993          	addi	s3,s7,8
    131a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    131e:	02090163          	beqz	s2,1340 <vprintf+0x158>
        while(*s != 0){
    1322:	00094583          	lbu	a1,0(s2)
    1326:	c9a5                	beqz	a1,1396 <vprintf+0x1ae>
          putc(fd, *s);
    1328:	8556                	mv	a0,s5
    132a:	00000097          	auipc	ra,0x0
    132e:	df0080e7          	jalr	-528(ra) # 111a <putc>
          s++;
    1332:	0905                	addi	s2,s2,1
        while(*s != 0){
    1334:	00094583          	lbu	a1,0(s2)
    1338:	f9e5                	bnez	a1,1328 <vprintf+0x140>
        s = va_arg(ap, char*);
    133a:	8bce                	mv	s7,s3
      state = 0;
    133c:	4981                	li	s3,0
    133e:	b5fd                	j	122c <vprintf+0x44>
          s = "(null)";
    1340:	00000917          	auipc	s2,0x0
    1344:	5d890913          	addi	s2,s2,1496 # 1918 <malloc+0x47e>
        while(*s != 0){
    1348:	02800593          	li	a1,40
    134c:	bff1                	j	1328 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    134e:	008b8913          	addi	s2,s7,8
    1352:	000bc583          	lbu	a1,0(s7)
    1356:	8556                	mv	a0,s5
    1358:	00000097          	auipc	ra,0x0
    135c:	dc2080e7          	jalr	-574(ra) # 111a <putc>
    1360:	8bca                	mv	s7,s2
      state = 0;
    1362:	4981                	li	s3,0
    1364:	b5e1                	j	122c <vprintf+0x44>
        putc(fd, c);
    1366:	02500593          	li	a1,37
    136a:	8556                	mv	a0,s5
    136c:	00000097          	auipc	ra,0x0
    1370:	dae080e7          	jalr	-594(ra) # 111a <putc>
      state = 0;
    1374:	4981                	li	s3,0
    1376:	bd5d                	j	122c <vprintf+0x44>
        putc(fd, '%');
    1378:	02500593          	li	a1,37
    137c:	8556                	mv	a0,s5
    137e:	00000097          	auipc	ra,0x0
    1382:	d9c080e7          	jalr	-612(ra) # 111a <putc>
        putc(fd, c);
    1386:	85ca                	mv	a1,s2
    1388:	8556                	mv	a0,s5
    138a:	00000097          	auipc	ra,0x0
    138e:	d90080e7          	jalr	-624(ra) # 111a <putc>
      state = 0;
    1392:	4981                	li	s3,0
    1394:	bd61                	j	122c <vprintf+0x44>
        s = va_arg(ap, char*);
    1396:	8bce                	mv	s7,s3
      state = 0;
    1398:	4981                	li	s3,0
    139a:	bd49                	j	122c <vprintf+0x44>
    }
  }
}
    139c:	60a6                	ld	ra,72(sp)
    139e:	6406                	ld	s0,64(sp)
    13a0:	74e2                	ld	s1,56(sp)
    13a2:	7942                	ld	s2,48(sp)
    13a4:	79a2                	ld	s3,40(sp)
    13a6:	7a02                	ld	s4,32(sp)
    13a8:	6ae2                	ld	s5,24(sp)
    13aa:	6b42                	ld	s6,16(sp)
    13ac:	6ba2                	ld	s7,8(sp)
    13ae:	6c02                	ld	s8,0(sp)
    13b0:	6161                	addi	sp,sp,80
    13b2:	8082                	ret

00000000000013b4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    13b4:	715d                	addi	sp,sp,-80
    13b6:	ec06                	sd	ra,24(sp)
    13b8:	e822                	sd	s0,16(sp)
    13ba:	1000                	addi	s0,sp,32
    13bc:	e010                	sd	a2,0(s0)
    13be:	e414                	sd	a3,8(s0)
    13c0:	e818                	sd	a4,16(s0)
    13c2:	ec1c                	sd	a5,24(s0)
    13c4:	03043023          	sd	a6,32(s0)
    13c8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    13cc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    13d0:	8622                	mv	a2,s0
    13d2:	00000097          	auipc	ra,0x0
    13d6:	e16080e7          	jalr	-490(ra) # 11e8 <vprintf>
}
    13da:	60e2                	ld	ra,24(sp)
    13dc:	6442                	ld	s0,16(sp)
    13de:	6161                	addi	sp,sp,80
    13e0:	8082                	ret

00000000000013e2 <printf>:

void
printf(const char *fmt, ...)
{
    13e2:	711d                	addi	sp,sp,-96
    13e4:	ec06                	sd	ra,24(sp)
    13e6:	e822                	sd	s0,16(sp)
    13e8:	1000                	addi	s0,sp,32
    13ea:	e40c                	sd	a1,8(s0)
    13ec:	e810                	sd	a2,16(s0)
    13ee:	ec14                	sd	a3,24(s0)
    13f0:	f018                	sd	a4,32(s0)
    13f2:	f41c                	sd	a5,40(s0)
    13f4:	03043823          	sd	a6,48(s0)
    13f8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    13fc:	00840613          	addi	a2,s0,8
    1400:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1404:	85aa                	mv	a1,a0
    1406:	4505                	li	a0,1
    1408:	00000097          	auipc	ra,0x0
    140c:	de0080e7          	jalr	-544(ra) # 11e8 <vprintf>
}
    1410:	60e2                	ld	ra,24(sp)
    1412:	6442                	ld	s0,16(sp)
    1414:	6125                	addi	sp,sp,96
    1416:	8082                	ret

0000000000001418 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    1418:	1141                	addi	sp,sp,-16
    141a:	e422                	sd	s0,8(sp)
    141c:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    141e:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1422:	00001797          	auipc	a5,0x1
    1426:	bf67b783          	ld	a5,-1034(a5) # 2018 <freep>
    142a:	a02d                	j	1454 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    142c:	4618                	lw	a4,8(a2)
    142e:	9f2d                	addw	a4,a4,a1
    1430:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    1434:	6398                	ld	a4,0(a5)
    1436:	6310                	ld	a2,0(a4)
    1438:	a83d                	j	1476 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    143a:	ff852703          	lw	a4,-8(a0)
    143e:	9f31                	addw	a4,a4,a2
    1440:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    1442:	ff053683          	ld	a3,-16(a0)
    1446:	a091                	j	148a <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1448:	6398                	ld	a4,0(a5)
    144a:	00e7e463          	bltu	a5,a4,1452 <free+0x3a>
    144e:	00e6ea63          	bltu	a3,a4,1462 <free+0x4a>
{
    1452:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1454:	fed7fae3          	bgeu	a5,a3,1448 <free+0x30>
    1458:	6398                	ld	a4,0(a5)
    145a:	00e6e463          	bltu	a3,a4,1462 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    145e:	fee7eae3          	bltu	a5,a4,1452 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    1462:	ff852583          	lw	a1,-8(a0)
    1466:	6390                	ld	a2,0(a5)
    1468:	02059813          	slli	a6,a1,0x20
    146c:	01c85713          	srli	a4,a6,0x1c
    1470:	9736                	add	a4,a4,a3
    1472:	fae60de3          	beq	a2,a4,142c <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    1476:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    147a:	4790                	lw	a2,8(a5)
    147c:	02061593          	slli	a1,a2,0x20
    1480:	01c5d713          	srli	a4,a1,0x1c
    1484:	973e                	add	a4,a4,a5
    1486:	fae68ae3          	beq	a3,a4,143a <free+0x22>
        p->s.ptr = bp->s.ptr;
    148a:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    148c:	00001717          	auipc	a4,0x1
    1490:	b8f73623          	sd	a5,-1140(a4) # 2018 <freep>
}
    1494:	6422                	ld	s0,8(sp)
    1496:	0141                	addi	sp,sp,16
    1498:	8082                	ret

000000000000149a <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    149a:	7139                	addi	sp,sp,-64
    149c:	fc06                	sd	ra,56(sp)
    149e:	f822                	sd	s0,48(sp)
    14a0:	f426                	sd	s1,40(sp)
    14a2:	f04a                	sd	s2,32(sp)
    14a4:	ec4e                	sd	s3,24(sp)
    14a6:	e852                	sd	s4,16(sp)
    14a8:	e456                	sd	s5,8(sp)
    14aa:	e05a                	sd	s6,0(sp)
    14ac:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    14ae:	02051493          	slli	s1,a0,0x20
    14b2:	9081                	srli	s1,s1,0x20
    14b4:	04bd                	addi	s1,s1,15
    14b6:	8091                	srli	s1,s1,0x4
    14b8:	0014899b          	addiw	s3,s1,1
    14bc:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    14be:	00001517          	auipc	a0,0x1
    14c2:	b5a53503          	ld	a0,-1190(a0) # 2018 <freep>
    14c6:	c515                	beqz	a0,14f2 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    14c8:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    14ca:	4798                	lw	a4,8(a5)
    14cc:	02977f63          	bgeu	a4,s1,150a <malloc+0x70>
    if (nu < 4096)
    14d0:	8a4e                	mv	s4,s3
    14d2:	0009871b          	sext.w	a4,s3
    14d6:	6685                	lui	a3,0x1
    14d8:	00d77363          	bgeu	a4,a3,14de <malloc+0x44>
    14dc:	6a05                	lui	s4,0x1
    14de:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    14e2:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    14e6:	00001917          	auipc	s2,0x1
    14ea:	b3290913          	addi	s2,s2,-1230 # 2018 <freep>
    if (p == (char *)-1)
    14ee:	5afd                	li	s5,-1
    14f0:	a895                	j	1564 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    14f2:	00001797          	auipc	a5,0x1
    14f6:	f1678793          	addi	a5,a5,-234 # 2408 <base>
    14fa:	00001717          	auipc	a4,0x1
    14fe:	b0f73f23          	sd	a5,-1250(a4) # 2018 <freep>
    1502:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    1504:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    1508:	b7e1                	j	14d0 <malloc+0x36>
            if (p->s.size == nunits)
    150a:	02e48c63          	beq	s1,a4,1542 <malloc+0xa8>
                p->s.size -= nunits;
    150e:	4137073b          	subw	a4,a4,s3
    1512:	c798                	sw	a4,8(a5)
                p += p->s.size;
    1514:	02071693          	slli	a3,a4,0x20
    1518:	01c6d713          	srli	a4,a3,0x1c
    151c:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    151e:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    1522:	00001717          	auipc	a4,0x1
    1526:	aea73b23          	sd	a0,-1290(a4) # 2018 <freep>
            return (void *)(p + 1);
    152a:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    152e:	70e2                	ld	ra,56(sp)
    1530:	7442                	ld	s0,48(sp)
    1532:	74a2                	ld	s1,40(sp)
    1534:	7902                	ld	s2,32(sp)
    1536:	69e2                	ld	s3,24(sp)
    1538:	6a42                	ld	s4,16(sp)
    153a:	6aa2                	ld	s5,8(sp)
    153c:	6b02                	ld	s6,0(sp)
    153e:	6121                	addi	sp,sp,64
    1540:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    1542:	6398                	ld	a4,0(a5)
    1544:	e118                	sd	a4,0(a0)
    1546:	bff1                	j	1522 <malloc+0x88>
    hp->s.size = nu;
    1548:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    154c:	0541                	addi	a0,a0,16
    154e:	00000097          	auipc	ra,0x0
    1552:	eca080e7          	jalr	-310(ra) # 1418 <free>
    return freep;
    1556:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    155a:	d971                	beqz	a0,152e <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    155c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    155e:	4798                	lw	a4,8(a5)
    1560:	fa9775e3          	bgeu	a4,s1,150a <malloc+0x70>
        if (p == freep)
    1564:	00093703          	ld	a4,0(s2)
    1568:	853e                	mv	a0,a5
    156a:	fef719e3          	bne	a4,a5,155c <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    156e:	8552                	mv	a0,s4
    1570:	00000097          	auipc	ra,0x0
    1574:	b7a080e7          	jalr	-1158(ra) # 10ea <sbrk>
    if (p == (char *)-1)
    1578:	fd5518e3          	bne	a0,s5,1548 <malloc+0xae>
                return 0;
    157c:	4501                	li	a0,0
    157e:	bf45                	j	152e <malloc+0x94>
