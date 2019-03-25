//
//  MatrixUtils.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/17.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class MatrixUtils: NSObject {
    
/*
     
     c Gauss の消去法により n 元連立方程式
     c Ax = b
     c の解を求める。
     c 入力
     c n: 次元
     c a: 係数行列 A の要素 (n x n)
     c b: ベクトル b の要素 (n)
     c 出力
     c a: 行列 A を上三角行列に変換したもの
     c (左下の非対角要素は意味が無い)
     c b: 解 x
     
     //前処理
     c input/output:
     integer n
     real a(n,n),b(n)
     c local
     integer i,j,k
     c begin:
     do i=1,n
     do j=i+1,n
     a(j,i)=a(j,i)/a(i,i) ! Pivot:c=a_ji/a_ii
     do k=i+1,n
     a(j,k)=a(j,k)-a(j,i)*a(i,k)
     end do
     b(j)=b(j)-a(j,i)*b(i)
     end do
     end do
     
     //解
     do i=n,1,-1
     do j=i+1,n
     b(i)=b(i)-a(i,j)*b(j)
     end do
     b(i)=b(i)/a(i,i) ! Ax=b の解 x
     end do
     return
     end
 
 */
    //dimention n次元， matrix [nxn]， vector [n]
    func rowReduction(dimention: Int, matrix:[[Float]], vector: [Float]) -> [Float]{
        var m: [[Float]] = matrix
        var v: [Float] = vector
        
        //前処理
        for i in 0 ..< dimention{
            for j in i+1 ..< dimention{
                m[j][i] = m[j][i]/m[i][i]   //pivot
                for k in i+1 ..< dimention{
                    m[j][k] = m[j][k] - (m[j][i] * m[i][k])
                }
                v[j] = v[j] - (m[j][i] * v[i])
            }
        }
        
        //解
        for i in (0 ..< dimention).reversed(){
            for j in i+1 ..< dimention{
                v[i] = v[i] - (m[i][j] * v[j])
            }
            v[i] = v[i] / m[i][i]
        }
        
        return v
    }

}
