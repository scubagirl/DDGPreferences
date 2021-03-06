//
//  NSData+DDGValue.m
//  DDGPreferences
//
//  Created by Andrew Donoho on 2012/10/20.
//  Copyright (c) 2012 Donoho Design Group, L.L.C. All rights reserved.
//

/*
 
 As NSUbiquitousKeyValueStore does not store NSValues, it only supports .plist 
 compatible data types. Hence, I extended NSData to cover all of the UIKit 
 additions to NSValue. I also incorporated a general mechanism to convert an 
 arbitrary NSValue into an NSData. Those methods, +dataWithValue:/-initWithValue:, 
 are based upon ideas described by Steffen Itterheim,
 <http://stackoverflow.com/users/201863/learncocos2d>, on Stack Overflow at: 
 <http://stackoverflow.com/questions/8447380/how-to-convert-nsvalue-to-nsdata-and-back>.
 
 As with all Stack Overflow contributions, <http://stackoverflow.com/faq#editing>, 
 Steffen's code is used under terms specified by the Creative Commons 
 Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) license: 
 <http://creativecommons.org/licenses/by-sa/3.0/>.
 
 */

/*
 
 The below license is the new BSD license with the OSI recommended
 personalizations.
 <http://www.opensource.org/licenses/bsd-license.php>
 
 Copyright (C) 2010-2012 Donoho Design Group, LLC. All Rights Reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:
 
 * Redistributions of source code must retain the above copyright notice,
 this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of Andrew W. Donoho nor Donoho Design Group, L.L.C.
 may be used to endorse or promote products derived from this software
 without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY DONOHO DESIGN GROUP, L.L.C. "AS IS" AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#if !__has_feature(objc_arc)
#  error Please compile this class with ARC (-fobjc-arc).
#endif

#import "NSData+DDGValue.h"

@implementation NSData (DDGValue)

+ (NSData *) dataWithValue: (NSValue *) value {
    
    return [self.alloc initWithValue: value];

} // +dataWithValue:


- (NSData *) initWithValue: (NSValue *) value {
    
    NSUInteger size = 0;
    
    NSGetSizeAndAlignment(value.objCType, &size, NULL);
    
    void *valueData = malloc(size);
    
    [value getValue: valueData];

    return (self = [self initWithBytesNoCopy: valueData length: size freeWhenDone: YES]);
    
} // -initWithValue:


+ (NSData *) dataWithCGAffineTransform: (CGAffineTransform) transform {
    
    return [self.alloc initWithCGAffineTransform: transform];
    
} // -dataWithCGAffineTransform:


- (NSData *) initWithCGAffineTransform: (CGAffineTransform) transform {
    
    return (self = [self initWithBytes: &transform length: sizeof(CGAffineTransform)]);
    
} // -initWithCGAffineTransform:


- (CGAffineTransform) CGAffineTransformValue {
    
    return *(CGAffineTransform *)(self.bytes);
    
} // -CGAffineTransformValue


+ (NSData *) dataWithCGPoint: (CGPoint) point {
    
    return [self.alloc initWithCGPoint: point];
    
} // -dataWithCGPoint:


- (NSData *) initWithCGPoint: (CGPoint) point {
    
    return (self = [self initWithBytes: &point length: sizeof(CGPoint)]);
    
} // -initWithCGPoint:


- (CGPoint) CGPointValue {
    
    return *(CGPoint *)(self.bytes);
    
} // -CGPointValue


+ (NSData *) dataWithCGRect: (CGRect) rect {
    
    return [self.alloc initWithCGRect: rect];
    
} // -dataWithCGRect:


- (NSData *) initWithCGRect: (CGRect) rect {
    
    return (self = [self initWithBytes: &rect length: sizeof(CGRect)]);
    
} // -initWithCGRect:


- (CGRect) CGRectValue {
    
    return *(CGRect *)(self.bytes);
    
} // -CGRectValue


+ (NSData *) dataWithCGSize: (CGSize) size {
    
    return [self.alloc initWithCGSize: size];
    
} // -dataWithCGSize:


- (NSData *) initWithCGSize: (CGSize) size {
    
    return (self = [self initWithBytes: &size length: sizeof(CGSize)]);
    
} // -initWithCGSize:


- (CGSize) CGSizeValue {
    
    return *(CGSize *)(self.bytes);
    
} // -CGSizeValue


+ (NSData *) dataWithUIEdgeInsets: (UIEdgeInsets) insets {
    
    return [self.alloc initWithUIEdgeInsets: insets];
    
} // -dataWithUIEdgeInsets:


- (NSData *) initWithUIEdgeInsets: (UIEdgeInsets) insets {
    
    return (self = [self initWithBytes: &insets length: sizeof(UIEdgeInsets)]);
    
} // -initWithUIEdgeInsets:


- (UIEdgeInsets) UIEdgeInsetsValue {
    
    return *(UIEdgeInsets *)(self.bytes);
    
} // -UIEdgeInsetsValue


+ (NSData *) dataWithUIOffset: (UIOffset) offset {
    
    return [self.alloc initWithUIOffset: offset];
    
} // -dataWithUIOffset:


- (NSData *) initWithUIOffset: (UIOffset) offset {
    
    return (self = [self initWithBytes: &offset length: sizeof(UIOffset)]);
    
} // -initWithUIOffset:


- (UIOffset) UIOffsetValue {
    
    return *(UIOffset *)(self.bytes);
    
} // -UIOffsetValue

@end
