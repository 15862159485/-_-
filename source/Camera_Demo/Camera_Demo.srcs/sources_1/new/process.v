module process(
    input clk,
    input [7:0] R,G,B,
    input vid_pVDE,vid_pHSync,vid_pVSync,
    input [10:0]x,
    input [10:0]y,
    output reg [23:0] rgb
);
reg [7:0]gray_0;//灰度
reg bw;//二值化的像素点
reg [11:0] addr=0;//ROM地址
wire [9:0] sample;//样本像素
reg [11:0] alike;//相似度
reg status;
mem_0 mem_0(clk,addr,sample[0]);
//以下是图像灰度化和二值化模块
always@(*)
begin
    gray_0=R/3+G/2+B/10;
    if(gray_0>128)
        bw=1'b1;
    else
        bw=1'b0;
end
//以下是显示模块
always@(*)
begin
    if(x>389 && x<890 && y>109 && y<610)
    begin
        if(x%10==1'b0)
        begin
            if(y%10==1'b0)
            addr=(x-390)/10+((y-110)/10-1'd1)*50-1'd1;
            else
            addr=(x-390)/10+((y-110)/10)*50-1'd1;
        end
        else
            addr=(x-390)/10+((y-110)/10)*50;
    end
    else if(status==1'b1 && x>614 && x<665 && y>639 && y<690)
    begin
        addr=x-615+(y-640)*50;
    end
    
        if(x>389 && x<890 && y>109 && y<610)
        begin
            rgb={R,G,B};
        end
        else if(status==1'b1 && x>614 && x<665 && y>639 && y<690)
        begin
            if(sample[0]==1'b1)
                rgb={8'd255,8'd255,8'd255};
            if(sample[0]==1'b0)
                rgb={8'd0,8'd0,8'd0};
        end
        else
            rgb={8'd255,8'd255,8'd255};
         
end
//以下是相似度判断
always@(posedge clk)
begin
    if(x==12'd1280 && y==12'd720)
    begin
        status=1'b0;
        alike=1'b0;
        addr=1'b0;
    end
    if(x>389 && x<890 && y>109 && y<610 && x%10==1'b0 && y%10==1'b0 &&  bw==sample[0])
        alike=alike+1'b1;
    if(alike>12'd50)
        status=1'b1;
end

endmodule


