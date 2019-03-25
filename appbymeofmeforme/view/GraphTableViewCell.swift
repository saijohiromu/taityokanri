//
//  graphTableViewCell.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/11.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class GraphTableViewCell: UITableViewCell {
    
    let logger = Logger(true)
    
    let YSIZE : Float = 200
    var addPosInt: [Int] = [0,0,0,0,0]
    var graphSize: [Float] = [50,300,300,200]//(x: Float, y: Float, width: Float, height: Float).self
    let graphMergin: Float = 30
    
    var sublayers: [CAShapeLayer] = []
    
    @IBOutlet var darwView: UIView!
    
    var drawAxisFlag: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(section: Any){
        
        drawAxis()
        
        print("layers count : \(sublayers.count)")
        let initlayerNum = 2                                    //軸の数
        if sublayers.count > initlayerNum{                     //軸以外を全て消す
            for i in (initlayerNum ..< sublayers.count).reversed(){
                sublayers[i].removeFromSuperlayer()
                sublayers.remove(at: i)
            }
            
        }
        
        //1
        addlayer(from: (x: SharedInputDataManager.shared.viewInputedData.MORNING, y: SharedInputDataManager.shared.viewInputedData.morning*100), to: (x: SharedInputDataManager.shared.viewInputedData.AM, y: SharedInputDataManager.shared.viewInputedData.am*100), pos: 0)
        //2
        addlayer(from: (x: SharedInputDataManager.shared.viewInputedData.AM, y: SharedInputDataManager.shared.viewInputedData.am*100), to: (x: SharedInputDataManager.shared.viewInputedData.NOON, y: SharedInputDataManager.shared.viewInputedData.noon*100), pos: 1)
        //3
        addlayer(from: (x: SharedInputDataManager.shared.viewInputedData.NOON, y: SharedInputDataManager.shared.viewInputedData.noon*100), to: (x: SharedInputDataManager.shared.viewInputedData.PM, y: SharedInputDataManager.shared.viewInputedData.pm*100), pos: 2)
        //4
        addlayer(from: (x: SharedInputDataManager.shared.viewInputedData.PM, y: SharedInputDataManager.shared.viewInputedData.pm*100), to: (x: SharedInputDataManager.shared.viewInputedData.EVENING, y: SharedInputDataManager.shared.viewInputedData.evening*100), pos: 3)
        //5
        addlayer(from: (x: SharedInputDataManager.shared.viewInputedData.EVENING, y: SharedInputDataManager.shared.viewInputedData.evening*100), to: (x: SharedInputDataManager.shared.viewInputedData.NIGHT, y: SharedInputDataManager.shared.viewInputedData.night*100), pos: 4)
        
        //要素は6個 y = a[0] + a[1]x + a[2]x^2 + a[3]x^3 + a[4]x^4 + a[5]x^5
        
        
        
        func matrixRow(x: Float)->[Float]{
            return [1,expo(base: Float(x), count: 1),expo(base: Float(x), count: 2),expo(base: Float(x), count: 3),expo(base: Float(x), count: 4),expo(base: Float(x), count: 5)]
        }
        let mat = MatrixUtils()
        let interval: Int = 5
        let a: [Float] = mat.rowReduction(dimention: 6, matrix: [matrixRow(x: SharedInputDataManager.shared.viewInputedData.MORNING),
                                                                 matrixRow(x: SharedInputDataManager.shared.viewInputedData.AM),
                                                                 matrixRow(x: SharedInputDataManager.shared.viewInputedData.NOON),
                                                                 matrixRow(x: SharedInputDataManager.shared.viewInputedData.PM),
                                                                 matrixRow(x: SharedInputDataManager.shared.viewInputedData.EVENING),
                                                                 matrixRow(x: SharedInputDataManager.shared.viewInputedData.NIGHT)], vector: [SharedInputDataManager.shared.viewInputedData.morning,
                                                                               SharedInputDataManager.shared.viewInputedData.am,
                                                                               SharedInputDataManager.shared.viewInputedData.noon,
                                                                               SharedInputDataManager.shared.viewInputedData.pm,
                                                                               SharedInputDataManager.shared.viewInputedData.evening,
                                                                               SharedInputDataManager.shared.viewInputedData.night])

        func retY(x: Int)->Float{
            return a[0] + a[1]*expo(base: Float(x), count: 1) + a[2]*expo(base: Float(x), count: 2) + a[3]*expo(base: Float(x), count: 3) + a[4]*expo(base: Float(x), count: 4) + a[5]*expo(base: Float(x), count: 5)
        }


        for i in stride(from: 50, to: 300, by: interval){
            logger.logger("x:\(Float(i)),y:\(YSIZE - retY(x: i)*100), x:\(Float(i+interval)),y:\(YSIZE - retY(x: i+interval)*100)")
            drawLine(from: (x: Float(i), y: YSIZE - retY(x: i)*100), to: (x: Float(i+interval), y: YSIZE - retY(x: i+interval)*100),UIColor.green)
        }
        
        let b: [[Float]] = [mat.rowReduction(dimention: 3, matrix: [matrixRow(x: SharedInputDataManager.shared.viewInputedData.MORNING),
                                                                 matrixRow(x: SharedInputDataManager.shared.viewInputedData.AM),
                                                                 matrixRow(x: SharedInputDataManager.shared.viewInputedData.NOON)], vector: [SharedInputDataManager.shared.viewInputedData.morning,
                                                                                                                                             SharedInputDataManager.shared.viewInputedData.am,
                                                                                                                                             SharedInputDataManager.shared.viewInputedData.noon]),
                            mat.rowReduction(dimention: 3, matrix: [matrixRow(x: SharedInputDataManager.shared.viewInputedData.AM),
                                                                    matrixRow(x: SharedInputDataManager.shared.viewInputedData.NOON),
                                                                    matrixRow(x: SharedInputDataManager.shared.viewInputedData.PM)], vector: [SharedInputDataManager.shared.viewInputedData.am,
                                                                                                                                                SharedInputDataManager.shared.viewInputedData.noon,SharedInputDataManager.shared.viewInputedData.pm]),
                            mat.rowReduction(dimention: 3, matrix: [matrixRow(x: SharedInputDataManager.shared.viewInputedData.NOON),
                                                                    matrixRow(x: SharedInputDataManager.shared.viewInputedData.PM),
                                                                    matrixRow(x: SharedInputDataManager.shared.viewInputedData.EVENING)], vector: [
                                                                                                                                                SharedInputDataManager.shared.viewInputedData.noon,SharedInputDataManager.shared.viewInputedData.pm,SharedInputDataManager.shared.viewInputedData.evening]),
                            mat.rowReduction(dimention: 3, matrix: [matrixRow(x: SharedInputDataManager.shared.viewInputedData.PM),
                                                                    matrixRow(x: SharedInputDataManager.shared.viewInputedData.EVENING),
                                                                    matrixRow(x: SharedInputDataManager.shared.viewInputedData.NIGHT)], vector: [SharedInputDataManager.shared.viewInputedData.pm,
                                                                                                                                                 SharedInputDataManager.shared.viewInputedData.evening,
                                                                                                                                                 SharedInputDataManager.shared.viewInputedData.night])
                            ]
        
        func bretY(index: Int, x: Int)->Float{
            return b[index][0] + b[index][1]*expo(base: Float(x), count: 1) + b[index][2]*expo(base: Float(x), count: 2)
        }
        
        let mergin: Int = 50
        var pos:[Float] = []
        for index in 0 ..< b.count{
            for i in stride(from: mergin*(index+1), to: mergin*(index+3)+interval, by: interval){
                
                //logger.logger("x:\(Float(i)),y:\(YSIZE - bretY(index: index, x: i)*100), x:\(Float(i+interval)),y:\(YSIZE - bretY(index: index,x: i+interval)*100)")
                //let weight: Float = ((index % 2 == 0 ? 0 : -1.0) + Float(mergin*(index+3) - i)/Float(mergin * 2)) + 0.5
                print("x,possize: \((i-mergin)/interval), \(pos.count)")//, \(weight) = \(Float(mergin*(index+3) - i))/\(mergin*2)")
                if pos.count == (i-mergin)/interval{
                    pos.append(YSIZE - bretY(index: index, x: i)*100)
                }else{
                    pos[(i-mergin)/interval] = ((pos[(i-mergin)/interval] + (YSIZE - bretY(index: index, x: i)*100))/2)// + weight*bretY(index: index, x: i)*100/2
                }
                //drawLine(from: (x: Float(i), y: YSIZE - bretY(index: index,x: i)*100), to: (x: Float(i+interval), y: YSIZE - bretY(index: index,x: i+interval)*100))
            }
        }
        
        for i in 0 ..< pos.count-1{
            drawLine(from: (x: Float(mergin+(i*interval)), y: pos[i]), to: (x: Float(mergin+((i+1)*interval)), y: pos[i+1]), UIColor.blue)
        }
        
//        darwView = GraphView()
//        self.addSubview(darwView)
        
        
        
    }
    
    private func expo(base: Float, count: Int) -> Float{
        if count == 0{
            return 1
        }else{
            var ret:Float = 1
            for _ in 0 ..< count{
                ret = ret*base
            }
            return ret
        }
    }
    
    //yは100バイして！
    private func addlayer(from: (x: Float, y: Float), to: (x: Float, y:Float), pos: Int){
        let shapeLayer = CAShapeLayer()
        //moringi -> am
        let uiPath = UIBezierPath()
        uiPath.move(to: CGPoint(x: Int(from.x), y: Int(YSIZE - from.y))) //ここから
        uiPath.addLine(to: CGPoint(x: Int(to.x), y: Int(YSIZE - to.y))) //ここまで
        
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        shapeLayer.path = uiPath.cgPath
        shapeLayer.lineWidth = 3
//        if addPosInt[pos] == 0{
//            
//            addPosInt[pos] = self.layer.sublayers!.count - 1
//        }else{
//            self.layer.sublayers?.remove(at: addPosInt[pos])
//            self.layer.addSublayer(shapeLayer)
//            addPosInt[pos] = self.layer.sublayers!.count - 1
//            for i in 0 ..< addPosInt.count{
//                if pos != i{
//                    addPosInt[i] -= 1
//                }
//            }
//        }
        sublayers.append(shapeLayer)
        self.layer.addSublayer(shapeLayer)
        shapeLayer.add(anim(), forKey: nil)
        logger.logger("addPosInt: \(addPosInt[0]) \(addPosInt[1]) \(addPosInt[2]) \(addPosInt[3]) \(addPosInt[4])")
    }
    
    private func drawLine(from: (x: Float, y: Float), to: (x: Float, y:Float), _ color: UIColor = UIColor.black){
        
        let shapeLayer = CAShapeLayer()
        //moringi -> am
        let uiPath = UIBezierPath()
        uiPath.move(to: CGPoint(x: Int(from.x), y: Int(from.y))) //ここから
        uiPath.addLine(to: CGPoint(x: Int(to.x), y: Int(to.y))) //ここまで
        
        shapeLayer.strokeColor = color.cgColor
        
        shapeLayer.path = uiPath.cgPath
        shapeLayer.lineWidth = 3
        
        sublayers.append(shapeLayer)
        self.layer.addSublayer(shapeLayer)
        shapeLayer.add(anim(), forKey: nil)
    }
    
    private func anim() -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.repeatDuration = 1
        animation.repeatCount = .infinity
        
        return animation
    }
    
    private func drawAxis(){
        if drawAxisFlag == false{
            let bound = self.bounds
            let paramsize = 6
            let gridY = bound.height/6
            let gridX = bound.width/CGFloat(paramsize + 2)
            graphSize = [Float(gridX),Float(gridY * CGFloat(5)),Float(gridX * CGFloat(paramsize)),Float(gridY * CGFloat(4))]
            logger.logger("x: \(bound.width), y: \(bound.height)")
            //横軸
            drawLine(from: (x: graphSize[0] - graphMergin, y: graphSize[1]), to: (x: graphSize[0] + graphSize[2], y: graphSize[1]))
            //縦軸
            drawLine(from: (x: graphSize[0], y: graphSize[1] + graphMergin), to: (x: graphSize[0], y: graphSize[1] - graphSize[3] ))
            
        }
        drawAxisFlag = true
    }
    
}
