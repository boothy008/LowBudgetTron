#define MAX_TRAILS 800

struct VS_INPUT
{
    float4 pos : POSITION;
    float2 texCoord : TEXCOORD;
    float3 normal : NORMAL;
    float3 tangent : TANGENT;
    float3 binormal : BINORMAL;
};

struct VS_OUTPUT
{
    float4 pos : SV_POSITION;
    float2 texCoord : TEXCOORD;
    float2 addToTex : TEXCOORD2;
};

cbuffer CameraBuffer : register(b0)
{
    float4x4 viewMat;
    float4x4 projMat;
    float4 cameraPosition;
    float2 uvMovement;
}

cbuffer ConstantBuffer : register(b2)
{
    float4x4 worldMatrix[MAX_TRAILS];
}

VS_OUTPUT main(VS_INPUT input, uint instanceID : SV_INSTANCEID)
{
    VS_OUTPUT output;

    //Change the position vector to be 4 units
    input.pos.w = 1.0f;

    //Calculate the vertex world position
    //output.pos = mul(input.pos, worldMatrix);
    output.pos = mul(input.pos, worldMatrix[instanceID]);
    output.pos = mul(output.pos, viewMat);
    output.pos = mul(output.pos, projMat);

    output.texCoord = input.texCoord;

    //store texture coordinates
    output.addToTex = uvMovement;

    return output;
}