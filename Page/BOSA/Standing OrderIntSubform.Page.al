page 50182 "Standing Order Int. Subform"
{
    // version TL2.0

    AutoSplitKey = true;
    Caption = 'Internal STO Subform';
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Standing Order Line";
    SourceTableView = WHERE("STO Type" = FILTER(Internal));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    OptionCaption = '<G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        //PageVisibility;
    end;

    var
        IsInternalVisible: Boolean;
        IsExternalVisible: Boolean;
        StandingOrderCard: Page "Standing Order Card";

    local procedure PageVisibility()
    begin
        IF Rec."STO Type" = Rec."STO Type"::Internal THEN
            IsInternalVisible := TRUE
        ELSE
            IsInternalVisible := FALSE;

        IF Rec."STO Type" = Rec."STO Type"::External THEN
            IsExternalVisible := TRUE
        ELSE
            IsExternalVisible := FALSE;
    end;
}

