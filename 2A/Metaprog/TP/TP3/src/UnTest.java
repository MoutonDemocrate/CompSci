/**
 * Annotation "@Avant"
 * 
 * @author LBck
 * @version $Revision$
 */
public @interface UnTest {

  boolean enabled() default true;
  String expected() default "Non";

}
