pageextension 50408 "Employee Relative Ext" extends "Employee Relatives"
{
    layout
    {
        addafter("Middle Name")
        {
            field("Last Name"; Rec."Last Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Phone No.")
        {
            field("Relation Type"; Rec."Relation Type")
            {
                ApplicationArea = All;
            }
        }
    }
}