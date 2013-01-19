local bagpane = {}

--******************************背包面板暂时如下*****************

--@parm1:面板的width
--@parm2:窗口的height
--@parm3:背包物品的表
--@parm4:背包物品排列序号表
--@parm5:对应上列序号的物品数量表
contentLayerTag=5;
menuTag=10;
bagpane.pastGezi=null;
bagpane.pastIndex=1;



function bagpane.new(width,height,goods,bag,num)
    
    --载入背包的组件和布局*********
    dialog=require("resource/ui/bag/dialogpane")
    
    --主层，new函数返回的对象，其子层为标题层和内容层
    MainLayer=CCLayer:create()              
    MainLayer:setPosition(ccp(100,100))
    
    
    --主层的上方- 标题层，放置标题文字和关闭按钮
    titleLayer=CCLayerColor:create(ccc4(100,0,100,255),width,1.0/8*height) 
    titleLayer:setAnchorPoint(ccp(0.5,0.5))
    titleLayer:setPosition(0,7*height/8)
    titleLayerSize=titleLayer:getContentSize()
    MainLayer:addChild(titleLayer)  
    
    --主层的下方- 内容层，放置标题和关闭按钮之外所有控件
    contentLayer= CCLayerColor:create(ccc4(100,100,100,255),width,height)   
    contentLayer:setAnchorPoint(ccp(0.5,0.5))
    contentLayer:setPosition(0,0)
    contentLayersize=contentLayer:getContentSize()
    MainLayer:addChild(contentLayer,1,contentLayerTag)
    
    
    
    --标题层的内容-标题“背包”
    titleLabel=CCLabelTTF:create("背包", "Arail", 30)                        
    titleLabel:setPosition(titleLayerSize.width/2,titleLayerSize.height/2)
    titleLayer:addChild(titleLabel)
     
    geziView=CCArray:create()
    --内容层的上方-翻页按钮
    normal1=CCSprite:create("resource/ui/bag/pagebutton1.png")
    selected1=CCSprite:create("resource/ui/bag/pagebutton1_1.png")
    normal2=CCSprite:create("resource/ui/bag/pagebutton2.png")
    selected2=CCSprite:create("resource/ui/bag/pagebutton2_1.png")
    normal3=CCSprite:create("resource/ui/bag/pagebutton3.png")
    selected3=CCSprite:create("resource/ui/bag/pagebutton3_1.png")
    pagebutton1=CCMenuItemSprite:create(normal1,selected1)
    pagebutton2=CCMenuItemSprite:create(normal2,selected2)
    pagebutton3=CCMenuItemSprite:create(normal3,selected3)
    pagebutton1:setAnchorPoint(ccp(0,0))
    pagebutton2:setAnchorPoint(ccp(0,0))
    pagebutton3:setAnchorPoint(ccp(0,0))
    pagebutton1:setPosition(ccp(contentLayersize.width/4,contentLayersize.height*6/8))
    pagebutton2:setPosition(ccp(pagebutton1:getPositionX()+pagebutton1:getContentSize().width+25,pagebutton1:getPositionY()))
    pagebutton3:setPosition(ccp(pagebutton2:getPositionX()+pagebutton2:getContentSize().width+25,pagebutton1:getPositionY()))
    pagebutton1:setTag(20)
    pagebutton2:setTag(21)
    pagebutton3:setTag(22)
    geziView:addObject(pagebutton1)
    geziView:addObject(pagebutton2)
    geziView:addObject(pagebutton3)
    
    
    --内容层的中央-背包层主要放置背包区域的layout和格子区域的背景，位于内容层的中间
    local bagLayer=CCLayerColor:create(ccc4(100,100,100,250),contentLayersize.width,contentLayersize.height*13/16)
    bagLayer:setAnchorPoint(ccp(0,0))
    bagLayer:setPosition(0,contentLayersize.height*1/16)
    contentLayer:addChild(bagLayer)
    
    --背包层内格子Layout设置
    local j=0
    
     
    for i=1,16 do
        if(i%4==1 and i~=1) then j=j+1 end 
        local normal=CCSprite:create("resource/ui/bag/gezi.png")
        local selected=CCSprite:create("resource/ui/bag/gezi2.png")
        gezi=CCMenuItemSprite:create(normal, selected)
        gezi:setAnchorPoint(ccp(0.5,0.5))
        gezi:setPosition(ccp(width*3/10+80*((i-1)%4),height*11/16-(j)*80))
        gezi:setTag(i+1)    
        geziView:addObject(gezi)
    end
    
    --内容层下方按钮：出售 整理 丢弃
    pclear=CCMenuItemImage:create("resource/ui/bag/clearbutton.png","resource/ui/bag/clearbutton.png")
    pthrow=CCMenuItemImage:create("resource/ui/bag/throwbutton.png","resource/ui/bag/throwbutton.png")
    psell=CCMenuItemImage:create("resource/ui/bag/sellbutton.png","resource/ui/bag/sellbutton.png")
    pclear:setAnchorPoint(ccp(0,0))
    pthrow:setAnchorPoint(ccp(0,0))
    psell:setAnchorPoint(ccp(0,0))

    pclear:setPosition(ccp(contentLayersize.width/4,contentLayersize.height/12))
    psell:setPosition(pclear:getPositionX()+pclear:getContentSize().width+20,pclear:getPositionY())
    pthrow:setPosition(psell:getPositionX()+pclear:getContentSize().width+20,psell:getPositionY())
    pclear:setTag(31)
    psell:setTag(32)
    pthrow:setTag(33)
    geziView:addObject(pclear)
    geziView:addObject(pthrow)
    geziView:addObject(psell)
    
    
    --内容层最下方的文字label：显示玩家金钱数量
    pLabelMoney=CCLabelTTF:create("银两 ：5000000    元宝:1000","Arial",20)
    pLabelMoney:setAnchorPoint(ccp(0,0))
    pLabelMoney:setPosition(ccp(contentLayersize.width/4,10))
    contentLayer:addChild(pLabelMoney)
    function bagSell()
        if(contentLayer:getChildrenCount()<4) then
        box=dialog.new("出售",300,150)
        contentLayer:addChild(box,1,50)
        box:setPosition(ccp(0,100))
        
        else
        contentLayer:getChildByTag(50):removeFromParentAndCleanup(true)
        
        end
    end
    psell:registerScriptTapHandler(bagSell)
    function bagThrow()
        if(contentLayer:getChildrenCount()<4) then
        box=dialog.new("丢弃",300,150)
        contentLayer:addChild(box,1,50)
        box:setPosition(ccp(0,100))
        
        else
        contentLayer:getChildByTag(50):removeFromParentAndCleanup(true)
        
        end
    end
    pthrow:registerScriptTapHandler(bagThrow)
    
    
    
    menu = CCMenu:createWithArray(geziView)
    menu:setAnchorPoint(ccp(0,0))
    menu:setPosition(ccp(0,0))
    contentLayer:addChild(menu,1,menuTag)
    
    
    
    
--函数部分
    function changeBagPage(tag) ---换页函数
        local nocontentLayerdex=tag-19
        for i=1,16 do
            
            if(bag[bagpane.pastIndex][i]>0) then
            menu:getChildByTag(i+1):removeChildByTag(11,true)
            end
            
        end
        if(bagpane.pastIndex==1) then
            sprite=CCSprite:create("resource/ui/bag/pagebutton1.png")
             pagebutton1:setNormalImage(sprite)
        end
        if(bagpane.pastIndex==2) then
             sprite=CCSprite:create("resource/ui/bag/pagebutton2.png")
             pagebutton2:setNormalImage(sprite)
        end
        if(bagpane.pastIndex==3) then
             sprite=CCSprite:create("resource/ui/bag/pagebutton3.png")
             pagebutton3:setNormalImage(sprite)
        end
        if(nocontentLayerdex==1) then
            sprite=CCSprite:create("resource/ui/bag/pagebutton1_1.png")
             pagebutton1:setNormalImage(sprite)
        end
        if(nocontentLayerdex==2) then
             sprite=CCSprite:create("resource/ui/bag/pagebutton2_1.png")
             pagebutton2:setNormalImage(sprite)
        end
        if(nocontentLayerdex==3) then
             sprite=CCSprite:create("resource/ui/bag/pagebutton3_1.png")
             pagebutton3:setNormalImage(sprite)
        end
        
        bagLoad(nocontentLayerdex)
    end
    pagebutton1:registerScriptTapHandler(changeBagPage)
    pagebutton2:registerScriptTapHandler(changeBagPage)       
    pagebutton3:registerScriptTapHandler(changeBagPage)
    
    function bagLoad(index) --载入背包函数
        
    for  i=1,16 do
        if bag[index][i]>0
        then
            print(goods[bag[index][i]].strView)
            
            sprite1=CCSprite:create(goods[bag[index][i]].strView)
            
            sprite1:setPosition(ccp(menu:getChildByTag(2):getContentSize().width/2,menu:getChildByTag(2):getContentSize().height/2))
            --sprite1:setVertexZ(100)
            
            if(num[index][i]>1) then
                 snum=""
                snum=snum..num[index][i]
                print ("snum",snum)
            numLabel=CCLabelTTF:create(snum,"Verdana",20)
            --numLabel:setColor(ccc3(0,0,255))
            numsize=numLabel:getContentSize()
            
            numLabel:setPosition(ccp(menu:getChildByTag(2):getContentSize().width/2,menu:getChildByTag(2):getContentSize().height/2))
            numLabel:setColor(ccc3(0,255,0))
            sprite1:addChild(numLabel,3,12)
            --menu:getChildByTag(i+1):addChild(numLayer,3,14)
            
            end
            menu:getChildByTag(i+1):addChild(sprite1,3,11)
            
            
        end
        
    
    

    bagpane.pastIndex=index
        
    end
    
    end
    
  bagLoad(1)
    
    closeItem = CCMenuItemImage:create("resource/ui/bag/winclose.png", "resource/ui/bag/winclose.png")
    --closeItem: setAnchorPoint(ccp(0,0))
    closeItem :setPosition(width, height)
    
    
    menu:addChild(closeItem,2,40)
    
    --全局变量
    
    function clearBag(tag) 
        for i=1,16 do
            
            if(num[bagpane.pastIndex][i]>1) then menu:getChildByTag(i+1):getChildByTag(11):removeChildByTag(12,true)
                
            end
            if(bag[bagpane.pastIndex][i]>0)  then menu:getChildByTag(i+1):removeChildByTag(11,true)
                
            end
            --print(table.concat(num[pastIndex],"-",1,16))
            
        end
        
        bagpane:selectsort(bag[bagpane.pastIndex],16,num[bagpane.pastIndex])
        
        --print(table.concat(bag[pastIndex],",",1,16))
        --print(table.concat(num[pastIndex],"-",1,16))
        local count
        local j
        j=1
        count=1
        for i=1,15 do
            if(bag[bagpane.pastIndex][i]>0) then
                if(bag[bagpane.pastIndex][i]~=bag[bagpane.pastIndex][i+1]) then
                    sum=0
                    for k=j,i do
                        --print(k,i,sum,count)
                        sum=sum+num[bagpane.pastIndex][k]
                        
                        
                        
                    end
                    num[bagpane.pastIndex][count]=sum
                        bag[bagpane.pastIndex][count]=bag[bagpane.pastIndex][i]
                        j=i+1
                    count=count+1
                else
                    bag[bagpane.pastIndex][i]=0
                    
                end
            end
        end
        for m=count,16 do
            num[bagpane.pastIndex][m]=0
            bag[bagpane.pastIndex][m]=0
        end
        bagLoad(bagpane.pastIndex)
    end

    pclear:registerScriptTapHandler(clearBag)
    
    
    
    
    
    
    return MainLayer
    
    end

    
function bagpane:selectsort(shu,length,num) ---背包整理时专用排序算法
    local i,j,k
    for i=1,length do
        k=i
        for j=i,length do
            if (shu[j]>shu[k]) then
                k=j
            end
        end
        if(k~=i) then
            shu[i]=shu[i]+shu[k]
            shu[k]=shu[i]-shu[k]
            shu[i]=shu[i]-shu[k]
            
            num[i]=num[i]+num[k]
            num[k]=num[i]-num[k]
            num[i]=num[i]-num[k]
        end
    end
end 

    
    


return bagpane