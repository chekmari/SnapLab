//
//  MetalView.swift
//  SnapLab
//
//  Created by macbook on 30.04.2023.
//
import UIKit
import MetalKit
import SnapKit

class MetalView: MTKView {
    
    private var texture: MTLTexture!
    private var vertexBuffer: MTLBuffer!
    private var pipelineState: MTLRenderPipelineState!
    
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        setup()
    }
    
    private func setup() {
        guard let device = device, let commandQueue = device.makeCommandQueue() else { return }
        self.device = device
        self.framebufferOnly = false
        self.contentMode = .scaleAspectFill
        self.clearColor = MTLClearColorMake(0, 0, 0, 1)
        self.device = device
        self.delegate = self
        
        let vertexData: [Float] = [
            -1.0, -1.0, 0.0, 0.0,
             1.0, -1.0, 1.0, 0.0,
            -1.0,  1.0, 0.0, 1.0,
             1.0,  1.0, 1.0, 1.0,
        ]
        vertexBuffer = device.makeBuffer(bytes: vertexData, length: vertexData.count * MemoryLayout<Float>.size, options: [])!
        
        let library = device.makeDefaultLibrary()!
        let vertexFunction = library.makeFunction(name: "vertexShader")
        let fragmentFunction = library.makeFunction(name: "fragmentShader")
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }
    
}

extension MetalView: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        view = .
        size = size
    }
    
    
    func draw(in view: MTKView) {
        guard let device = device, let commandBuffer = device.makeCommandQueue()?.makeCommandBuffer(), let drawable = currentDrawable else { return }
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        renderPassDescriptor.colorAttachments[0].clearColor = clearColor
        
        let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)!
        encoder.setRenderPipelineState(pipelineState)
        
        encoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        encoder.setFragmentTexture(texture, index: 0)
        encoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
        
        encoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    
    func setPhoto(_ photo: UIImage) {
        texture = try! MTKTextureLoader(device: device!).newTexture(cgImage: photo.cgImage!, options: nil)
        setNeedsDisplay()
    }
    
}

