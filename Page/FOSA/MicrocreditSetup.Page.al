page 50391 "Microcredit Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Microcredit Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Group Attendance Nos."; Rec."Group Attendance Nos.")
                {
                    ApplicationArea = All;
                }
                field("Group Allocation Nos."; Rec."Group Allocation Nos.")
                {
                    ApplicationArea = All;
                }
                field("Portfolio Transfer Nos."; Rec."Portfolio Transfer Nos.")
                {
                    ApplicationArea = All;
                }

                field("Group In-Transit Account Type"; Rec."Group In-Transit Account Type")
                {
                    ApplicationArea = All;
                }
                field("Group Allocation Report Code"; Rec."Group Allocation Report Code")
                {
                    ApplicationArea = All;
                }
                field("Group Attendance Report Code"; Rec."Group Attendance Report Code")
                {
                    ApplicationArea = All;
                }
                field("Group Collection Report Code"; Rec."Group Collection Report Code")
                {
                    ApplicationArea = All;
                }

                field("Group Collection Control A/c"; Rec."Group Collection Control A/c")
                {
                    ApplicationArea = All;
                }
                field("Group Paybill Nos."; Rec."Group Paybill Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("GP Allocation Template Name"; Rec."GP Allocation Template Name")
                {
                    ApplicationArea = All;
                }
                field("GP Allocation Batch Name"; Rec."GP Allocation Batch Name")
                {
                    ApplicationArea = All;
                }
                field("GP Collection Template Name"; Rec."GP Collection Template Name")
                {
                    ApplicationArea = All;
                }
                field("GP Collection Batch Name"; Rec."GP Collection Batch Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            /* action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            } */
        }
    }

    var
        myInt: Integer;
}