// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: inventory.proto

package com.manning.mss.ch08.sample02;

public interface LineItemOrBuilder extends
    // @@protoc_insertion_point(interface_extends:sample02.LineItem)
    com.google.protobuf.MessageOrBuilder {

  /**
   * <code>.sample02.Product product = 1;</code>
   */
  boolean hasProduct();
  /**
   * <code>.sample02.Product product = 1;</code>
   */
  com.manning.mss.ch08.sample02.Product getProduct();
  /**
   * <code>.sample02.Product product = 1;</code>
   */
  com.manning.mss.ch08.sample02.ProductOrBuilder getProductOrBuilder();

  /**
   * <code>int32 quantity = 2;</code>
   */
  int getQuantity();
}