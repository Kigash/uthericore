page 50733 "Store Return List - Open"
{
    // version TL2.0

    CardPageID = "Store Return Application Card";
    PageType = List;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE("Requisition Type" = FILTER('Store Return'),
                            Status = FILTER(New));

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
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Requisition Date"; Rec."Requisition Date")
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

