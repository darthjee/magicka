# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Button do
  let(:renderer) { instance_double('renderer') }
  let(:template) { 'templates/forms/button' }

  let(:ng_click)    { 'controler.click()' }
  let(:ng_disabled) { 'false' }
  let(:classes)     { 'custom class' }
  let(:text)        { 'Click' }

  let(:locals) do
    {
      ng_click: ng_click,
      ng_disabled: ng_disabled,
      classes: classes,
      text: text
    }
  end

  describe '.render' do
    let(:arguments) do
      {
        renderer: renderer,
        ng_click: ng_click,
        ng_disabled: ng_disabled,
        classes: classes,
        text: text
      }
    end

    before do
      allow(renderer)
        .to receive(:render)
        .with(partial: template, locals: locals)
    end

    it do
      described_class.render(arguments)

      expect(renderer).to have_received(:render)
    end

    context 'when called with extra params' do
      it do
        described_class.render(name: 'Name', **arguments)

        expect(renderer).to have_received(:render)
      end
    end
  end
end
