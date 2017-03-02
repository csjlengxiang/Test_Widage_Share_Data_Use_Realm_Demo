这个demo测试了下，iOS widget 如何数据传递
传统我们用userdefault archive 来传递数据
由于realm 数据库是个文件，我就尝试能否使用realm放在app group数据域里，然后widget跟主app都访问，以保持数据一致性
实践发现可行。考虑向下兼容realm原来在主app的目录下，需要使用file manager 移动到 app group下，于是也试了试，发现依然可行
这个挺66的哟...
只不过我们记账项目的 快速记账widget，考虑到移动数据库的风险最终我还是使用了临时文件的方式，通过archive将要交换的数据写入app group
重点是非常轻量
