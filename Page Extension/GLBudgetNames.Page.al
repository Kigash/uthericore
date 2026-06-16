pageextension 50506 "G/L Budget Names Ext" extends "G/L Budget Names"
{
    layout
    {
        addafter(Description)
        {
            field("Budget Period"; Rec."Budget Period")
            {
                ApplicationArea = All;
            }
            field("Budget Per Branch?"; Rec."Budget Per Branch?")
            {
                ApplicationArea = All;
            }
            field("Budget Per Department?"; Rec."Budget Per Department?")
            {
                ApplicationArea = All;
            }
            field("Budget Start Date"; Rec."Budget Start Date")
            {
                ApplicationArea = All;
            }
            field("Budget End Date"; Rec."Budget End Date")
            {
                ApplicationArea = All;
            }

        }
    }
}