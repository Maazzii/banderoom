package com.project.vo;

import java.util.Date;

public class MessagesVO {
	
	private int msgIdx;
	private String senderType; // "general", "host"
	private int sender;
	private String senderNickname;
	private String receiverNickname;
	private String receiverType; // "general", "host"
	private int receiver;
	private String content;
	private Date sentDate;
	private int status; // 0: 읽지 않음 1: 읽음
	
	public int getMsgIdx() {
		return msgIdx;
	}
	public void setMsgIdx(int msgIdx) {
		this.msgIdx = msgIdx;
	}
	public String getSenderType() {
		return senderType;
	}
	public void setSenderType(String senderType) {
		this.senderType = senderType;
	}
	public int getSender() {
		return sender;
	}
	public void setSender(int sender) {
		this.sender = sender;
	}
	public String getReceiverType() {
		return receiverType;
	}
	public void setReceiverType(String receiverType) {
		this.receiverType = receiverType;
	}
	public int getReceiver() {
		return receiver;
	}
	public void setReceiver(int receiver) {
		this.receiver = receiver;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getSentDate() {
		return sentDate;
	}
	public void setSentDate(Date sentDate) {
		this.sentDate = sentDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getSenderNickname() {
		return senderNickname;
	}
	public void setSenderNickname(String senderNickname) {
		this.senderNickname = senderNickname;
	}
	public String getReceiverNickname() {
		return receiverNickname;
	}
	public void setReceiverNickname(String receiverNickname) {
		this.receiverNickname = receiverNickname;
	}
}
