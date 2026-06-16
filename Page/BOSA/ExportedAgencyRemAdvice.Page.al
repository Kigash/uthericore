page 50343 "Exported Agency Rem. Advice"
{
    // version TL2.0

    Caption = 'Exported Agency Remittance Advice';
    CardPageID = "Agency Remittance Advice";
    Editable = false;
    PageType = List;
    SourceTable = "Agency Remittance Header";
    SourceTableView = WHERE(Status = FILTER(Exported));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
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

