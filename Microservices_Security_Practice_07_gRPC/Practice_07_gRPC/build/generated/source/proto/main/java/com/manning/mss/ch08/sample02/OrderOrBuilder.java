// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: inventory.proto

package com.manning.mss.ch08.sample02;

public interface OrderOrBuilder extends
    // @@protoc_insertion_point(interface_extends:sample02.Order)
    com.google.protobuf.MessageOrBuilder {

  /**
   * <code>int32 orderId = 1;</code>
   */
  int getOrderId();

  /**
   * <code>repeated .sample02.LineItem items = 2;</code>
   */
  java.util.List<com.manning.mss.ch08.sample02.LineItem> 
      getItemsList();
  /**
   * <code>repeated .sample02.LineItem items = 2;</code>
   */
  com.manning.mss.ch08.sample02.LineItem getItems(int index);
  /**
   * <code>repeated .sample02.LineItem items = 2;</code>
   */
  int getItemsCount();
  /**
   * <code>repeated .sample02.LineItem items = 2;</code>
   */
  java.util.List<? extends com.manning.mss.ch08.sample02.LineItemOrBuilder> 
      getItemsOrBuilderList();
  /**
   * <code>repeated .sample02.LineItem items = 2;</code>
   */
  com.manning.mss.ch08.sample02.LineItemOrBuilder getItemsOrBuilder(
      int index);
}
