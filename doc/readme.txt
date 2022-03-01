sram 大小为512X32

1、w2r_0，/study/sram_top1.v，sram_signal_generate.txt，只有碰到写后读才拉低readyo
2、w2r_1，/study/sram_top.v，pseu_w2r1.txt，readyo永远为“1”，碰到写后读则出错
3、w2r_2，/study/sram_top2.v，pseu_w2r2.txt，只要遇到有效写就在下一拍拉低readyo
4、w2r_3，/study/sram_top3.v，pseu_w2r3.txt，只要遇到有效读就在下一拍拉低readyo
5、w2r_4，/study/sram_top4.v，pseu_w2r4.txt，readyo永远为“1”，但亦可以完成写后读操作