// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: inventory.proto

package com.manning.mss.ch08.sample02;

public interface ProductOrBuilder extends
    // @@protoc_insertion_point(interface_extends:sample02.Product)
    com.google.protobuf.MessageOrBuilder {

  /**
   * <code>int32 id = 1;</code>
   */
  int getId();

  /**
   * <code>string name = 2;</code>
   */
  java.lang.String getName();
  /**
   * <code>string name = 2;</code>
   */
  com.google.protobuf.ByteString
      getNameBytes();

  /**
   * <code>string category = 3;</code>
   */
  java.lang.String getCategory();
  /**
   * <code>string category = 3;</code>
   */
  com.google.protobuf.ByteString
      getCategoryBytes();

  /**
   * <code>float unitPrice = 4;</code>
   */
  float getUnitPrice();
}