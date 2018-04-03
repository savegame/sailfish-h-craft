#ifndef SAILFISH_RENDER_H
#define SAILFISH_RENDER_H

#include <irrlicht.h>
#ifdef _IRR_COMPILE_WITH_SAILFISH_DEVICE_

#include "config.h"
#include <../source/Irrlicht/CIrrDeviceSailfish.h>

class ScreenShaderCB : public irr::video::IShaderConstantSetCallBack
{
    friend class ScreenQuad;
public:
    enum ScreenOrientation : int {
        Normal    = 0,
        Rotate90  = 1,
        Rotate270 = 2
    };
public:
    ScreenShaderCB() : WorldViewProjID(-1),
        TextureID0(-1), TextureID1(-1), FirstUpdate(true),
        m_screenOrientation(Rotate90),
        OrientationID(-1),
        ResolutionID(-1)
    {
        m_resolution = irr::core::dimension2df(640.0,480.0);
        m_depth_far = irr::core::vector2df(0.999f,0.95f);
        m_depth_near = irr::core::vector2df(0.005f,0.01f);
    }

    virtual void OnSetConstants(irr::video::IMaterialRendererServices* services,
            irr::s32 userData) _IRR_OVERRIDE_;

    void setIsFlipped(irr::s32 val)
    {
        m_screenOrientation = val;
    }

private:
    irr::s32 WorldViewProjID;
//	s32 TransWorldID;
//	s32 InvWorldID;
//	s32 PositionID;
//	s32 ColorID;
    irr::s32 TextureID0;
    irr::s32 TextureID1;
    irr::s32 OrientationID;
    irr::s32 ResolutionID;
    irr::s32 DepthNearID;
    irr::s32 DepthFarID;
    irr::s32 IsUseDepthID;

public:
    irr::s32  m_screenOrientation;
    irr::core::vector2df  m_depth_near;
    irr::core::vector2df  m_depth_far;
    irr::core::dimension2df m_resolution;
    bool FirstUpdate;
};

class IrrlichtManager;

class ScreenQuad //: irr::scene::ISceneNode
{
    friend class IrrlichtManager;
public:
    ScreenQuad(IrrlichtManager *irrManager,const Config& config);

    ~ScreenQuad();

    ScreenShaderCB* getShader() const;

    void draw(irr::video::IVideoDriver* driver);

protected:
    irr::video::SMaterial m_material;
    irr::u16              m_index[6];
    irr::video::S3DVertex m_vertex[4];
    ScreenShaderCB*       m_shader;
    irr::core::matrix4    m_transformation;
};

#endif

#endif // SAILFISH_RENDER_H
