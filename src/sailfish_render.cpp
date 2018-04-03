#include "sailfish_render.h"
#include "irrlicht_manager.h"

#ifdef _IRR_COMPILE_WITH_SAILFISH_DEVICE_
using namespace irr;

ScreenQuad::ScreenQuad(IrrlichtManager *irrManager, const Config &config)
{
    irr::scene::ISceneManager* mgr = irrManager->GetSceneManager();
    bool UseHighLevelShaders= true;
    m_material.Wireframe = false;
    m_material.Lighting = false;
    m_material.Thickness=0.f;
    m_vertex[0] = video::S3DVertex(-1,-1.0,0, 5,1,0,
                                   video::SColor(255,0,255,255), 0, 1);
    m_vertex[1] = video::S3DVertex(-1,1,0, 10,0,0,
                                   video::SColor(255,255,0,255), 0, 0);
    m_vertex[2] = video::S3DVertex(1,1,0, 20,1,1,
                                   video::SColor(255,255,255,0), 1, 0);
    m_vertex[3] = video::S3DVertex(1,-1,0, 40,0,1,
                                   video::SColor(255,0,255,0), 1, 1);
    //shader
#ifdef _DEBUG
    irr::io::path psFileName = "/opt/sdk/h-craft";
    irr::io::path vsFileName = "/opt/sdk/h-craft";
#else
    irr::io::path psFileName = "";
    irr::io::path vsFileName = "";
#endif
    psFileName += config.MakeFilenameShader("DFGLES2Screen.fsh").c_str();
    vsFileName += config.MakeFilenameShader("DFGLES2Screen.vsh").c_str();

    irr::video::IGPUProgrammingServices* gpu = mgr->getVideoDriver()->getGPUProgrammingServices();
    irr::s32 ShaderMaterial = 0 ;

    if (gpu)
    {
        m_shader = new ScreenShaderCB();
        m_shader->m_resolution.Width = irrManager->GetVideoDriver()->getScreenSize().Height;
        m_shader->m_resolution.Height = irrManager->GetVideoDriver()->getScreenSize().Width;

        if (true)
        {
            // Choose the desired shader type. Default is the native
            // shader type for the driver
            const irr::video::E_GPU_SHADING_LANGUAGE shadingLanguage = irr::video::EGSL_DEFAULT;

            ShaderMaterial = gpu->addHighLevelShaderMaterialFromFiles(
                        vsFileName, "main", irr::video::EVST_VS_1_1,
                        psFileName, "main", irr::video::EPST_PS_1_1,
                        m_shader, irr::video::EMT_SOLID, 0, shadingLanguage);
//            if(ShaderMaterial > 0 )
                m_material.MaterialType = ((irr::video::E_MATERIAL_TYPE)ShaderMaterial);
//            else
//                m_material.MaterialType = video::EMT_SOLID;
        }
    }
    irr::u16 indices[] = { 0,1,2, 0,2,3 };
    memcpy(m_index,indices, 6*sizeof(irr::u16));

    m_transformation.setRotationDegrees( core::vector3df(0,0,0) );
    m_transformation.setTranslation( core::vector3df(0,0,0) );
    m_transformation.setScale(1.0);
}

ScreenQuad::~ScreenQuad()
{
    m_shader->drop();
}

ScreenShaderCB *ScreenQuad::getShader() const
{
    return m_shader;
}

void ScreenQuad::draw(video::IVideoDriver *driver)
{
    //        driver->setMaterial(irr::video::SMaterial());
    driver->setTransform ( irr::video::ETS_PROJECTION, irr::core::IdentityMatrix );
    driver->setTransform ( irr::video::ETS_VIEW, irr::core::IdentityMatrix );
    driver->setTransform ( irr::video::ETS_WORLD, irr::core::IdentityMatrix );


    driver->setMaterial(m_material);
//    driver->setTransform(irr::video::ETS_WORLD, m_transformation);
    driver->drawVertexPrimitiveList(m_vertex, 4, m_index, 2, irr::video::EVT_STANDARD, irr::scene::EPT_TRIANGLES, irr::video::EIT_16BIT);
}


void ScreenShaderCB::OnSetConstants(video::IMaterialRendererServices *services, s32 userData)
{
    irr::video::IVideoDriver* driver = services->getVideoDriver();

    // get shader constants id.

    if (FirstUpdate)
    {
        WorldViewProjID = services->getVertexShaderConstantID("mWorldViewProj");
        //			TransWorldID = services->getVertexShaderConstantID("mTransWorld");
        //			InvWorldID = services->getVertexShaderConstantID("mInvWorld");
        //			PositionID = services->getVertexShaderConstantID("mLightPos");
        //			ColorID = services->getVertexShaderConstantID("mLightColor");
        TextureID0 = services->getPixelShaderConstantID("Texture0");
        TextureID1 = services->getPixelShaderConstantID("Texture1");
        OrientationID = services->getPixelShaderConstantID("inScreenOrientation");
        ResolutionID = services->getPixelShaderConstantID("inResolution");
        DepthNearID = services->getPixelShaderConstantID("inDepthNear");
        DepthFarID = services->getPixelShaderConstantID("inDepthFar");
        IsUseDepthID  = services->getPixelShaderConstantID("inIsUseDepth");
        FirstUpdate = false;
    }

    irr::core::matrix4 invWorld = driver->getTransform(irr::video::ETS_WORLD);
    invWorld.makeInverse();

    irr::core::matrix4 worldViewProj;
    worldViewProj = driver->getTransform(irr::video::ETS_PROJECTION);
    worldViewProj *= driver->getTransform(irr::video::ETS_VIEW);
    worldViewProj *= driver->getTransform(irr::video::ETS_WORLD);

    services->setVertexShaderConstant(WorldViewProjID, worldViewProj.pointer(), 16);

    irr::video::SColorf col(0.0f,1.0f,1.0f,0.0f);
    irr::core::matrix4 world = driver->getTransform(video::ETS_WORLD);
    world = world.getTransposed();

    irr::s32 TextureLayerID = 0;
    services->setPixelShaderConstant(TextureID0, &TextureLayerID, 1);
    irr::s32 TextureLayerID1 = 1;
    services->setPixelShaderConstant(TextureID1, &TextureLayerID1, 1);
    services->setPixelShaderConstant(OrientationID,&m_screenOrientation, 1);
    services->setPixelShaderConstant(ResolutionID,reinterpret_cast<f32*>(&m_resolution), 2);
    services->setPixelShaderConstant(DepthNearID,reinterpret_cast<f32*>(&m_depth_near), 2);
    services->setPixelShaderConstant(DepthFarID,reinterpret_cast<f32*>(&m_depth_far), 2);
}

#endif
