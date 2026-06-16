page 50183 "Standing Order Ex. Subform"
{
    // version TL2.0

    AutoSplitKey = true;
    Caption = 'External STO Subform';
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Standing Order Line";
    SourceTableView = WHERE("STO Type" = FILTER(External));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = All;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = All;
                }
                field("Destination Bank Name"; Rec."Destination Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Destination Branch Name"; Rec."Destination Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Swift Code"; Rec."Swift Code")
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

