import { codegenNativeComponent, type ViewProps } from 'react-native';
import type { Float } from 'react-native/Libraries/Types/CodegenTypesNamespace';

export interface NativeProps extends ViewProps {
  /**
   * The distance between elements at which they begin to merge.
   * Defaults to 0.
   */
  spacing?: Float;
}

export default codegenNativeComponent<NativeProps>('LiquidGlassContainerView');
