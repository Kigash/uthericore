page 50806 ProcurementCue
{

    Caption = 'Procurement Activities';
    PageType = CardPart;
    SourceTable = "Procurement Cue";
    layout
    {
        area(content)
        {
            cuegroup(PurchReqBalances)
            {
                Caption = 'Requisition Amounts';
                CuegroupLayout = Wide;
                field(TotalPlanAmount; Rec.TotalPlanAmount)
                {
                    Caption = 'Total Plan Amount';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var

                    begin
                        Page.Run(50714);
                    end;

                }
                field(TotalReqAmount; Rec.TotalReqAmount)
                {
                    Caption = 'Total Requisitions Amount';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var

                    begin
                        Page.Run(50722);
                    end;

                }
                field(TotalOrderAmount; Rec.TotalOrderAmount)
                {
                    Caption = 'Total LPO Amount';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var

                    begin
                        Page.Run(9307);
                    end;
                }

            }

            cuegroup(PurchaseReqCueContainer)
            {

                Caption = 'Requisition Summary';
                //CuegroupLayout = Wide;

                field("PurchaseRequisition-New"; Rec."PurchaseRequisition-New")
                {
                    Caption = 'New Purchase Requisitions';
                    DrillDownPageId = "Purchase Requisition List";
                    ApplicationArea = All;
                }
                field("PurchaseRequisition-Pending"; Rec."PurchaseRequisition-Pending")
                {
                    Caption = 'Purchase Requisitions - Pending';
                    DrillDownPageId = "Purch Requisition List-Pending";
                    ApplicationArea = All;
                }
                field("PurchaseRequisition-Approved"; Rec."PurchaseRequisition-Approved")
                {
                    Caption = 'Purchase Requisitions - Approved';
                    DrillDownPageId = "Purch Requisition List-Approve";
                    ApplicationArea = All;
                }


            }
            cuegroup(StoreRequisitionsCueContainer)
            {
                Caption = 'Store Requisitions';
                //CuegroupLayout = Wide;
                field("StoreRequisiton-New"; Rec."StoreRequisiton-New")
                {
                    Caption = 'New Store Requisitions';
                    DrillDownPageId = "Store Requisition List - Open";
                    ApplicationArea = All;
                }
                field("StoreRequisiton-Pending"; Rec."StoreRequisiton-Pending")
                {
                    Caption = 'Pending Store Requisitions';
                    DrillDownPageId = "Store Requisition List - Pend";
                    ApplicationArea = All;
                }
                field("StoreRequisiton-Approved"; Rec."StoreRequisiton-Approved")
                {
                    Caption = 'Approved Store Requisitions';
                    DrillDownPageId = "Store Requisition List - Appr";
                    ApplicationArea = All;
                }
                field("StoreRequisiton-Issued"; Rec."StoreRequisiton-Issued")
                {
                    Caption = 'Issued Store Requisitions';
                    DrillDownPageId = "Issued Store Requisitions";
                    ApplicationArea = All;
                }

            }
            cuegroup(StoreReturnCueContainer)
            {
                Caption = 'Store Return';
                //CuegroupLayout = Wide;
                field("StoreReturn-New"; Rec."StoreReturn-New")
                {
                    Caption = 'New Store Return';
                    DrillDownPageId = "Store Return List - Open";
                    ApplicationArea = All;
                }
                field("StoreReturn-Pending"; Rec."StoreReturn-Pending")
                {
                    Caption = 'Pending Approval';
                    DrillDownPageId = "Store Return List - Pending";
                    ApplicationArea = All;
                }
                field("StoreReturn-Approved"; Rec."StoreReturn-Approved")
                {
                    Caption = 'Approved Store Return';
                    DrillDownPageId = "Store Requisition List - Appr";
                    ApplicationArea = All;
                }

            }
            cuegroup(data)
            {
                Caption = 'Action Items';
                //     CuegroupLayout = Wide;
                actions
                {
                    action("Procurement Plan")
                    {
                        RunObject = page "Procurement Plan Card";
                        Image = TileNew;

                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
            cuegroup(data1)
            {
                Caption = 'Action Items';
                // CuegroupLayout = Wide;
                actions
                {
                    action("Purchase Requisition")
                    {
                        RunObject = page "Purchase Req. Application Card";
                        Image = TileNew;

                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
            cuegroup(data2)
            {
                Caption = 'Action Items';
                //  CuegroupLayout = Wide;
                actions
                {
                    action("Store Requisition")
                    {
                        RunObject = page "Store Req. Application Card";
                        Image = TileNew;

                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    local procedure CalculateProcAmounts()
    var
        ProcurementPlan: Record "Procurement Plan Header";
        ProcurementPlanLines: Record "Procurement Plan Line";
        RequisitionHeader: Record "Requisition Header";
        RequisitionHeaderLine: Record "Requisition Header Line";
        UserSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        ProcurementRequest: Record "Procurement Request";
    begin
        if UserSetup.Get(UserId) then;
        ProcurementPlan.Reset();
        ProcurementPlan.SetRange(Status, ProcurementPlan.Status::Approved);
        ProcurementPlan.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if ProcurementPlan.FindSet then begin
            repeat
                ProcurementPlanLines.Reset();
                ProcurementPlanLines.SetRange("Plan No", ProcurementPlan."No.");
                if ProcurementPlanLines.FindSet then begin
                    repeat
                        Rec."TotalPlanAmount" += ProcurementPlanLines."Estimated Cost";
                    until ProcurementPlanLines.next = 0;
                end;
            until ProcurementPlan.Next = 0;
        end;
        RequisitionHeader.Reset();
        RequisitionHeader.SetRange(Status, RequisitionHeader.Status::Released);
        RequisitionHeader.SetRange("Requisition Type", RequisitionHeader."Requisition Type"::"Purchase Requisition");
        RequisitionHeader.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if RequisitionHeader.FindSet then begin
            repeat
                RequisitionHeaderLine.Reset();
                RequisitionHeaderLine.SetRange("Requisition No.", RequisitionHeader."No.");
                if RequisitionHeaderLine.FindSet then begin
                    repeat
                        Rec."TotalReqAmount" += RequisitionHeaderLine.Amount;
                    until RequisitionHeaderLine.next = 0;
                end;
            until RequisitionHeader.Next = 0;
        end;
        ProcurementRequest.Reset();
        //ProcurementRequest.SetFilter("Process Status", '%1', ProcurementRequest."Process Status"::LPO);
        ProcurementRequest.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if ProcurementRequest.FindSet then begin
            repeat
                PurchaseHeader.Reset();
                PurchaseHeader.SetRange("Process No.", ProcurementRequest."No.");
                if PurchaseHeader.FindFirst() then begin
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                    PurchaseLine.CalcSums(Amount);
                    Rec."TotalOrderAmount" += PurchaseLine.Amount;

                end;
            until ProcurementRequest.Next = 0;
        end;
    end;

    trigger OnAfterGetRecord()

    begin
        CalculateProcAmounts();
    end;

}