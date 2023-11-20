#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/udp.h>
#include <linux/string.h>

static struct nf_hook_ops *nf_hook_ex_ops = NULL;

static unsigned int nf_hook_ex(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
{
	struct iphdr *iph; // ip header
	//char target[16]="192.168.192.236"; // target ip
	char sipaddr[16]; // source ip
	char dipaddr[16]; // destination ip
	//struct tcphdr *tcpHeader;
	//struct udphdr *udpHeader;

	if(!skb){
		return NF_ACCEPT;
	}
	iph = (struct iphdr *)ip_hdr(skb); 
	snprintf(sipaddr, 16, "%pI4", &iph->saddr); // convert to saddr
	snprintf(dipaddr, 16, "%pI4", &iph->daddr); // convert to daddr

	if (strcmp(sipaddr, "127.0.0.1") != 0){
		printk(KERN_INFO "YOUR IP ADDRESS = %s AND MY IP ADDRESS = %s \n", sipaddr, dipaddr);
	}

	return NF_ACCEPT;
}
	/*
	if (strcmp(sipaddr, target) == 0) { // compare client ip to target ip
		printk(KERN_INFO "Droped packet from: %s \n", sipaddr);
		return NF_DROP;
	}
	printk(KERN_INFO "Received packet from: %s \n", sipaddr);
	if (iph->protocol == 6) {
		tcpHeader = (struct tcphdr *) (iph + sizeof(struct iphdr));
		printk(KERN_INFO "Droped TCP packet from %s port %d \n", sipaddr, ntohs(tcpHeader->source));
		return NF_DROP;
	}

	if (iph->protocol == 17) 
	{
		udpHeader = (struct udphdr *) (iph + sizeof(struct iphdr));
		printk(KERN_INFO "Droped UDP packet from %s port %d \n", sipaddr, ntohs(udpHeader->source));
		return NF_DROP;
	}

	printk(KERN_INFO "Received packet from %s port %d \n", sipaddr, udpHeader->dest);
	*/


/* Được gọi khi sử dụng lệnh 'insmod' */
static int __init kmod_init(void) {
	nf_hook_ex_ops = (struct nf_hook_ops*)kcalloc(1,  sizeof(struct nf_hook_ops), GFP_KERNEL);
	if (nf_hook_ex_ops != NULL) {

		/* đây là hàm callback `nf_hook_ex` kiểu nf_hookfn - định nghĩa trong include/linux/netfilter.h, line 47
				- các tham số của hook mà người dùng định nghĩa phải khớp với kiểu nf_hookfn */
		nf_hook_ex_ops->hook = (nf_hookfn*)nf_hook_ex;
		
		/* Sự kiện mà hook này đăng ký  */
		nf_hook_ex_ops->hooknum = NF_INET_PRE_ROUTING; 

		/* Chỉ xử lý các Internet (IPv4) packet  */
		nf_hook_ex_ops->pf = NFPROTO_IPV4;

		/* Cài đặt độ ưu tiên của hook này ở mức độ cao nhất*/
		nf_hook_ex_ops->priority = NF_IP_PRI_FIRST;
		
		nf_register_net_hook(&init_net, nf_hook_ex_ops);
	}
	return 0;
}


static void __exit kmod_exit(void) {
	if(nf_hook_ex_ops != NULL) {
		nf_unregister_net_hook(&init_net, nf_hook_ex_ops);
		kfree(nf_hook_ex_ops);
	}
	printk(KERN_INFO "Exit");
}

module_init(kmod_init);
module_exit(kmod_exit);

MODULE_LICENSE("GPL");
