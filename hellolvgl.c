#include <stdlib.h>
#include <stdio.h>
#include <lvgl.h>

extern void lv_platform_init(void);
extern void lv_platform_exit(void);

static void btn_event_cb(lv_event_t * e)
{
    lv_event_code_t code = lv_event_get_code(e);
    lv_obj_t * btn = lv_event_get_target(e);
    if (code == LV_EVENT_CLICKED) {
        static uint8_t cnt = 0;
        cnt++;

        /*Get the first child of the button which is the label and change its text*/
        lv_obj_t * label = lv_obj_get_child(btn, 0);
        lv_label_set_text_fmt(label, "Hello World: %d", cnt);
    }
}

static void lv_hello_world(void)
{
    lv_obj_t * btn = lv_btn_create(lv_scr_act());   /*Add a button the current screen*/
    lv_obj_set_pos(btn, 10, 10);                    /*Set its position*/
    lv_obj_set_size(btn, 120, 50);                  /*Set its size*/
    lv_obj_add_event_cb(btn, btn_event_cb, LV_EVENT_ALL, NULL); /*Assign a callback to the button*/

    lv_obj_t * label = lv_label_create(btn);        /*Add a label to the button*/
    lv_label_set_text(label, "Hello World");        /*Set the labels text*/
    lv_obj_center(label);  
}

int main(void)
{
    lv_init();
    lv_platform_init();

    lv_hello_world();
    
    lv_platform_exit();
    return 0;
}
