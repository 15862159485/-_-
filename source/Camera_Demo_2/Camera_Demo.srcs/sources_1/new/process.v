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
reg [3:0] x_j=0,y_j=0;//交点个数
reg status=0;
reg [9:0] temp_x=0,temp_y=0;
mem_0 mem_0(clk,addr,sample[0]);
//以下是图像灰度化和二值化模块
always@(*)
begin
    if( x==11'd640 && x>389 && x<890 && y>109 && y<610)
    begin
    temp_y[9:1]=temp_y[8:0];
    temp_y[0]=~bw;
    end
    if( y==11'd360 && x>389 && x<890 && y>109 && y<610)
    begin
    temp_x[9:1]=temp_x[8:0];
    temp_x[0]=~bw;
    end
    gray_0=R/3+G/2+B/10;
    if(gray_0>80)
        bw=1'b1;
    else
        bw=1'b0;
end
//以下是显示模块
always@(*)
begin
  
        if(x>389 && x<890 && y>109 && y<610)
        begin
        if(x==11'd640 || y==11'd360)
            rgb={8'd0,8'd0,8'd255};
        else
        begin
            if(bw==1'b1)
                rgb={8'd255,8'd255,8'd255};
            else
                rgb=1'b0;
        end
        end
        else if(status==1'b1 && x>614 && x<665 && y>639 && y<690)
        begin
            if(sample[0]==1'b1)
                rgb={8'd255,8'd255,8'd255};
            if(sample[0]==1'b0)
                rgb=1'b0;
        end
        else if(status==1'b1)
            rgb={8'd255,8'd0,8'd0};
        else
            rgb={8'd255,8'd255,8'd255};
         
end
//以下是相似度判断
always@(posedge clk)
begin    
    if(status==1'b1 && x>614 && x<665 && y>639 && y<690)
    begin
        addr=x-615+(y-640)*50;
    end
    else if(x==12'd1280 && y==12'd720)
    begin
        status=1'b0;
        {x_j,y_j}=1'b0;
        addr=1'b0;
    end
    if(x>389 && x<890 && y==11'd360 && temp_x==10'b1111111111 && bw==1'b1)
        x_j=x_j+1'b1;
    if(y>109 && y<610 && x==11'd640 && temp_y==10'b1111111111 && bw==1'b1)
        y_j=y_j+1'b1;
    if(x_j==2'd2 && y_j==2'd2)
        status=1'b1;
    else
        status=1'b0;
end

endmodule