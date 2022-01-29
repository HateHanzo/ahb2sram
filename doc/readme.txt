1、w2r_0，/study/sram_top1.v，sram_signal_generate.txt，只有碰到写后读才拉低readyo
2、w2r_1，/study/sram_top.v，pseu_w2r1.txt，readyo永远为“1”，碰到写后读则出错
3、w2r_2，/study/sram_top2.v，pseu_w2r2.txt，只要遇到有效写就在下一拍拉低readyo

