page 50423 "Legal Cases"
{
    // version TL2.0

    CardPageID = "Disciplinary Cases Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50215;
    SourceTableView = WHERE("Case Status" = filter('Court'));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Case No"; Rec."Case No")
                {
                    ApplicationArea = All;
                }
                field("Case Description"; Rec."Case Description")
                {
                    ApplicationArea = All;
                }
                field("Date of the Case"; Rec."Date of the Case")
                {
                    ApplicationArea = All;
                }
                field("Offense Type"; Rec."Offense Type")
                {
                    ApplicationArea = All;
                }
                field("Offense Name"; Rec."Offense Name")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Case Status"; Rec."Case Status")
                {
                    ApplicationArea = All;
                }
                field("HOD Recommendation"; Rec."HOD Recommendation")
                {
                    ApplicationArea = All;
                }
                field("HR Recommendation"; Rec."HR Recommendation")
                {
                    ApplicationArea = All;
                }
                field("Commitee Recommendation"; Rec."Commitee Recommendation")
                {
                    ApplicationArea = All;
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = All;
                }
                field(Appealed; Rec.Appealed)
                {
                    ApplicationArea = All;
                }
                field("Committee Recon After Appeal"; Rec."Committee Recon After Appeal")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
