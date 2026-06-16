pageextension 50504 "Company Information Ext" extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addafter(GLN)
        {
            field("Company P.I.N"; Rec."Company P.I.N")
            {
                ApplicationArea = All;
            }
            field("Sacco Number"; Rec."Sacco Number")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}